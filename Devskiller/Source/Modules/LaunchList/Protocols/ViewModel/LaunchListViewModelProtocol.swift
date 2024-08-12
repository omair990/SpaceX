//
//  LaunchListViewModelProtocol.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import RxSwift

/// Protocol defining the responsibilities of the Launch List ViewModel.
protocol LaunchListViewModelProtocol: AnyObject {
    
    /// An observable stream of launches to be displayed.
    var launches: Observable<[LaunchListModel]> { get }
    
    /// An observable stream of company information.
    var companyInfo: Observable<CompanyResponseModel> { get }
    
    /// Fetches the company information.
    func fetchCompanyInfo()
    
    /// Fetches launches based on the provided request model.
    /// - Parameter request: A model containing the query parameters for fetching launches.
    /// - Returns: An observable that completes when the fetch operation finishes.
    func fetchLaunches(request: LaunchRequestModel) -> Observable<Void>
    
    /// Handles the selection of a launch.
    /// - Parameter launch: The selected launch model.
    func didSelectLaunch(_ launch: LaunchListModel)
    
    /// Applies a filter to the launch list based on the provided criteria.
    /// - Parameters:
    ///   - year: The year to filter launches by.
    ///   - status: The status to filter launches by (success, failed, all).
    ///   - isAscending: Boolean indicating whether the launches should be sorted in ascending order.
    func applyFilter(year: String?, status: LaunchStatus, isAscending: Bool)
    
    /// Fetches more launches, typically for pagination.
    /// - Returns: An observable that completes when the fetch operation finishes.
    func fetchMoreLaunches() -> Observable<Void>
}
