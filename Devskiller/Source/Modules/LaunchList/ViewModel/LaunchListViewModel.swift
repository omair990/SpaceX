//
//  LaunchListViewModel.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import RxSwift
import RxCocoa

class LaunchListViewModel: LaunchListViewModelProtocol {

    // MARK: - Properties

    private let service: LaunchListServiceProtocol
    private let coordinator: LaunchListCoordinatorProtocol
    private let disposeBag = DisposeBag()

    private var currentPage = 1
    private var isFetching = false

    private var filterYear: String? = nil
    private var filterStatus: LaunchStatus = .all
    private var isAscending: Bool = true

    private let allLaunchesRelay = BehaviorRelay<[LaunchListModel]>(value: [])
    var launches: Observable<[LaunchListModel]> {
        return allLaunchesRelay.asObservable()
    }

    private let companyInfoRelay = BehaviorRelay<CompanyResponseModel?>(value: nil)
    var companyInfo: Observable<CompanyResponseModel> {
        return companyInfoRelay.compactMap { $0 }.asObservable()
    }

    // MARK: - Initializer

    init(service: LaunchListServiceProtocol, coordinator: LaunchListCoordinatorProtocol) {
        self.service = service
        self.coordinator = coordinator
        fetchCompanyInfo()
        fetchInitialLaunches()
    }

    // MARK: - Public Methods

    func fetchCompanyInfo() {
        service.fetchCompanyInfo()
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] companyInfo in
                self?.companyInfoRelay.accept(companyInfo)
            }, onError: { error in
                print(AppConstants.ErrorMessages.fetchCompanyInfoFailed.localized())
            })
            .subscribe()
            .disposed(by: disposeBag)
    }

    func fetchLaunches(request: LaunchRequestModel) -> Observable<Void> {
        guard !isFetching else { return Observable.empty() }

        isFetching = true

        return service.fetchLaunches(request: request)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] responseModel in
                guard let self = self else { return }
                self.handleFetchSuccess(responseModel.docs.map { LaunchListModel(from: $0) })
                if !responseModel.docs.isEmpty {
                    self.currentPage += 1
                }
            }, onDispose: { [weak self] in
                self?.isFetching = false
            })
            .map { _ in }
            .catchAndReturn(())
    }

    func applyFilter(year: String?, status: LaunchStatus, isAscending: Bool) {
        filterYear = year
        filterStatus = status
        self.isAscending = isAscending
        currentPage = 1
        allLaunchesRelay.accept([])

        fetchLaunches(request: createLaunchRequestModel(page: currentPage, year: year, status: status, isAscending: isAscending))
            .subscribe()
            .disposed(by: disposeBag)
    }

    func fetchMoreLaunches() -> Observable<Void> {
        return fetchLaunches(request: createLaunchRequestModel(page: currentPage, year: filterYear, status: filterStatus, isAscending: isAscending))
    }

    func didSelectLaunch(_ launch: LaunchListModel) {
        coordinator.showLaunchDetail(for: launch)
    }

    // MARK: - Private Methods

    private func fetchInitialLaunches() {
        fetchLaunches(request: createLaunchRequestModel(page: currentPage, year: nil, status: .all, isAscending: true))
            .subscribe()
            .disposed(by: disposeBag)
    }

    private func createLaunchRequestModel(page: Int, year: String?, status: LaunchStatus, isAscending: Bool) -> LaunchRequestModel {
        let query = createQuery(year: year, status: status)
        let options = createOptions(page: page, isAscending: isAscending)
        return LaunchRequestModel(query: query, options: options)
    }

    private func createQuery(year: String?, status: LaunchStatus) -> LaunchRequestModel.Query? {
        guard year != nil || status != .all else { return nil }

        var dateRange: LaunchRequestModel.Query.DateRange? = nil
        if let year = year {
            dateRange = LaunchRequestModel.Query.DateRange(
                gte: "\(year)-01-01",
                lte: "\(year)-12-31"
            )
        }
        
        let success: Bool?
        switch status {
        case .success:
            success = true
        case .failed:
            success = false
        case .all:
            success = nil
        }

        return LaunchRequestModel.Query(dateUTC: dateRange, success: success)
    }

    private func createOptions(page: Int, isAscending: Bool) -> LaunchRequestModel.DataOptions {
        return LaunchRequestModel.DataOptions(
            populate: [
                LaunchRequestModel.DataOptions.Populate(
                    path: APIConstants.QueryParameters.rocket,
                    select: LaunchRequestModel.DataOptions.Populate.Select(name: 1, type: 1)
                )
            ],
            sort: LaunchRequestModel.DataOptions.Sort(dateUTC: isAscending ? APIConstants.QueryParameters.asc : APIConstants.QueryParameters.desc),
            page: page,
            limit: APIConstants.QueryParameters.limit
        )
    }

    private func handleFetchSuccess(_ newLaunches: [LaunchListModel]) {
        let uniqueNewLaunches = newLaunches.filter { newLaunch in
            !allLaunchesRelay.value.contains(where: { $0.id == newLaunch.id })
        }
        var updatedLaunches = allLaunchesRelay.value
        updatedLaunches.append(contentsOf: uniqueNewLaunches)
        allLaunchesRelay.accept(updatedLaunches)
    }
}
