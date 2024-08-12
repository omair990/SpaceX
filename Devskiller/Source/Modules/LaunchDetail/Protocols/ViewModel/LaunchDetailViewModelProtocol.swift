//
//  LaunchDetailViewModelProtocol.swift
//  Devskiller
//
//  Created by Muhammad Umair on 08/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import RxSwift

/// Protocol defining the interface for the LaunchDetailViewModel.
protocol LaunchDetailViewModelProtocol {
    /// Observable that emits the launch detail data as `LaunchDetailModel`.
    var launchDetail: Observable<LaunchDetailModel> { get }
    
    /// Fetches the launch detail data for a given launch ID.
    /// - Parameter launchID: The ID of the launch to fetch details for.
    /// - Returns: An `Observable` that completes once the data has been fetched.
    func fetchLaunchDetail(for launchID: String) -> Observable<Void>
}
