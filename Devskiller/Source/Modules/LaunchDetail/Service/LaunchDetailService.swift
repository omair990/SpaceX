//
//  LaunchDetailService.swift
//  Devskiller
//
//  Created by Muhammad Umair on 08/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import Foundation
import RxSwift

/// Service Implementation for fetching launch detail data
class LaunchDetailService: LaunchDetailServiceProtocol {

    private let networkService: NetworkServiceProtocol

    /// Initializes the service with a network service, defaulting to `NetworkService`
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    /// Fetches the detailed information of a specific launch by its ID
    /// - Parameter id: The ID of the launch to fetch details for
    /// - Returns: An observable containing the `LaunchDetailModel`
    func fetchLaunchDetail(id: String) -> Observable<LaunchDetailModel> {
        guard let url = URL(string: "\(APIConstants.BaseURL.production)\(APIConstants.Endpoints.launchDetail)/\(id)") else {
            return Observable.error(NetworkError.requestFailed(AppConstants.ErrorMessages.invalidURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = APIConstants.HTTPMethods.get
        
        return networkService.fetch(LaunchDetailResponseModel.self, from: request)
            .map { responseModel in
                return LaunchDetailModel(from: responseModel)
            }
            .catch { error in
                return Observable.error(NetworkError.networkError(AppConstants.ErrorMessages.networkError.localized()))
            }
    }
}
