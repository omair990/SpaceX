//
//  MockNetworkService.swift
//  DevskillerTests
//
//  Created by Muhammad Umair on 08/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import RxSwift
@testable import Devskiller

// Mock implementation of NetworkServiceProtocol for testing purposes
class MockNetworkService: NetworkServiceProtocol {
    
    // Mocked response to simulate network requests
    var mockResponse: Result<Data, Error>?

    // Fetches data and decodes it to the specified type
    func fetch<T: Decodable>(_ type: T.Type, from request: URLRequest) -> Observable<T> {
        return Observable.create { observer in
            if let response = self.mockResponse {
                switch response {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        observer.onNext(decodedData)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            } else {
                observer.onError(NSError(domain: TestConstants.mockNetworkService, code: -1, userInfo: [NSLocalizedDescriptionKey: "No mock response set"]))
            }
            return Disposables.create()
        }
    }
}
