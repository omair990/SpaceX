//
//  LaunchListService.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import RxSwift

class LaunchListService: LaunchListServiceProtocol {
  
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    /// Fetches a list of launches from the SpaceX API with pagination support.
    /// - Parameter page: The page number to fetch.
    /// - Returns: An Observable array of `LaunchResponseModel` objects.
    func fetchLaunches(request options: LaunchRequestModel) -> Observable<LaunchResponseModel> {
        guard let url = URL(string: "\(APIConstants.BaseURL.production)\(APIConstants.Endpoints.allLaunches)") else {
            return Observable.error(NetworkError.requestFailed(AppConstants.ErrorMessages.invalidURL))
        }

        // Convert the struct to JSON data
        guard let jsonData = try? JSONEncoder().encode(options) else {
            return Observable.error(NetworkError.invalidData(AppConstants.ErrorMessages.invalidData.localized()))
        }

        // Create the POST request
        var request = URLRequest(url: url)
        request.httpMethod = APIConstants.HTTPMethods.post
        request.addValue(APIConstants.Headers.contentTypeJSON, forHTTPHeaderField: APIConstants.Headers.contentType)
        request.httpBody = jsonData

        // Make the network request and return the observable
        return networkService.fetch(LaunchResponseModel.self, from: request)
    }

    func fetchCompanyInfo() -> Observable<CompanyResponseModel> {
        guard let url = URL(string: APIConstants.BaseURL.production + APIConstants.Endpoints.companyInfo) else {
            return Observable.error(NetworkError.requestFailed(AppConstants.ErrorMessages.invalidURL))
        }
        
        // Create a URLRequest for a GET request
        var request = URLRequest(url: url)
        request.httpMethod = APIConstants.HTTPMethods.get
        
        // Fetch and return the company info
        return networkService.fetch(CompanyResponseModel.self, from: request)
    }
}
