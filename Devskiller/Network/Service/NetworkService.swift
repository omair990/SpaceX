//
//  NetworkService.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import Foundation
import RxSwift

/// NetworkService handles network requests using RxSwift and functional programming concepts.
class NetworkService: NetworkServiceProtocol {
    
    /// Fetches data using a given URLRequest and decodes it into the specified type.
    /// - Parameters:
    ///   - type: The type to decode the data into.
    ///   - request: The URLRequest used to fetch the data.
    /// - Returns: An Observable of the specified type, emitting the decoded data or an error.
    func fetch<T: Decodable>(_ type: T.Type, from request: URLRequest) -> Observable<T> {
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                // Handle any network error
                if let error = error {
                    observer.onError(NetworkError.requestFailed(AppConstants.ErrorMessages.requestFailed.localized() + ": " + error.localizedDescription))
                    return
                }
                
                // Ensure data is valid
                guard let data = data else {
                    observer.onError(NetworkError.invalidData(AppConstants.ErrorMessages.invalidData.localized()))
                    return
                }
                
                // Decode the data and handle any decoding errors
                do {
                    let decodedData = try self.decodeData(data, as: T.self)
                    observer.onNext(decodedData)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            
            task.resume()
            
            // Return a disposable to clean up resources
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    // MARK: - Private Helpers
    
    /// Decodes data into the specified type, handling any errors during the process.
    /// - Parameters:
    ///   - data: The data to decode.
    ///   - type: The type to decode the data into.
    ///   - decoder: The JSONDecoder used for decoding. Defaults to `JSONDecoder`.
    /// - Returns: The decoded object of the specified type.
    /// - Throws: An error if the data cannot be decoded.
    private func decodeData<T: Decodable>(_ data: Data, as type: T.Type, decoder: JSONDecoder = JSONDecoder()) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            // Log the error with the raw JSON for debugging purposes
            if let jsonString = String(data: data, encoding: .utf8) {
                print(AppConstants.ErrorMessages.decodingFailed.localized() + ": \(jsonString)")
            } else {
                print(AppConstants.ErrorMessages.decodingFailed.localized() + ": Unable to convert data to string")
            }
            print("Decoding error: \(error.localizedDescription)")
            throw NetworkError.decodingFailed(AppConstants.ErrorMessages.decodingFailed.localized() + ": \(error.localizedDescription)")
        }
    }
}
