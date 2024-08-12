//
//  LaunchListServiceProtocol.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import RxSwift

/// Protocol defining the service behavior for fetching launch data and company information.
protocol LaunchListServiceProtocol {
    
    /// Fetches a list of launches based on the provided request model.
    /// - Parameter request: A model containing the query parameters for fetching launches.
    /// - Returns: An observable emitting a `LaunchResponseModel`.
    func fetchLaunches(request: LaunchRequestModel) -> Observable<LaunchResponseModel>
    
    /// Fetches the company information.
    /// - Returns: An observable emitting a `CompanyResponseModel`.
    func fetchCompanyInfo() -> Observable<CompanyResponseModel>
}

