//
//  LaunchDetailServiceProtocol.swift
//  Devskiller
//
//  Created by Muhammad Umair on 08/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import Foundation
import RxSwift

/// Protocol defining the service methods for fetching launch details.
protocol LaunchDetailServiceProtocol {
    /// Fetches the details of a specific launch.
    /// - Parameter id: The ID of the launch to fetch details for.
    /// - Returns: An observable that emits `LaunchDetailModel` containing the launch details.
    func fetchLaunchDetail(id: String) -> Observable<LaunchDetailModel>
}
