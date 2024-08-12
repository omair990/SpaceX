//
//  LaunchDetailViewModel.swift
//  Devskiller
//
//  Created by Muhammad Umair on 08/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import RxSwift

class LaunchDetailViewModel: LaunchDetailViewModelProtocol {
    
    // MARK: - Properties
    
    private let service: LaunchDetailServiceProtocol
    private let disposeBag = DisposeBag()
    
    private let _launchDetail = BehaviorSubject<LaunchDetailModel?>(value: nil)
    var launchDetail: Observable<LaunchDetailModel> {
        return _launchDetail.compactMap { $0 }.asObservable()
    }
    
    // MARK: - Initializer
    
    init(service: LaunchDetailServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func fetchLaunchDetail(for launchID: String) -> Observable<Void> {
        return service.fetchLaunchDetail(id: launchID)
            .observe(on: MainScheduler.instance) // Ensure the following operations run on the main thread
            .do(onNext: { [weak self] launchDetailModel in
                // Assign the fetched launch detail model to the BehaviorSubject
                self?._launchDetail.onNext(launchDetailModel)
            }, onError: { error in
                print("Error fetching launch detail: \(error.localizedDescription)")
            })
            .map { _ in } // Convert to Observable<Void>
    }

}
