//
//  LaunchListCoordinator.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import UIKit
import RxSwift

class LaunchListCoordinator: LaunchListCoordinatorProtocol {

    let navigationController: UINavigationController
    private let disposeBag = DisposeBag()
    private var viewModel: LaunchListViewModelProtocol?

    // Initialize the coordinator with a navigation controller
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // Start the coordinator by setting up the initial view controller
    func start() {
        guard viewModel == nil else {
            print("ViewModel already initialized, skipping re-initialization.")
            return
        }

        // Setup the view model and services
        let service = LaunchListService()
        viewModel = LaunchListViewModel(service: service, coordinator: self)

        // Configure the header view with company info
        let headerView = CompanyInfoHeaderView()
        viewModel!.companyInfo
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { companyInfo in
                headerView.configure(with: companyInfo)
            }, onError: { error in
                print(AppConstants.ErrorMessages.fetchCompanyInfoFailed.localized())
            })
            .disposed(by: disposeBag)

        // Setup table view handler and launch list view controller
        let tableViewHandler = LaunchListTableViewHandler(
            didSelectLaunch: { [weak self] selectedLaunch in
                self?.showLaunchDetail(for: selectedLaunch)
            },
            headerView: headerView,
            viewModel: viewModel!
        )

        let launchListViewController = LaunchListViewController(
            viewModel: viewModel!,
            tableViewHandler: tableViewHandler
        )

        // Set the view controller stack
        navigationController.viewControllers = [launchListViewController]
    }

    // Navigate to the launch detail view controller
    func showLaunchDetail(for launch: LaunchListModel) {
        let detailService = LaunchDetailService()
        let detailViewModel = LaunchDetailViewModel(service: detailService)
        
        detailViewModel.fetchLaunchDetail(for: launch.id)
            .subscribe(onNext: { [weak self] _ in
                let detailViewController = LaunchDetailViewController(viewModel: detailViewModel)
                self?.navigationController.pushViewController(detailViewController, animated: true)
            }, onError: { error in
                print("Error loading launch detail: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}
