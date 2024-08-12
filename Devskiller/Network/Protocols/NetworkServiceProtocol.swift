//
//  NetworkServiceProtocol.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import Foundation
import RxSwift

/// Protocol defining the network service behavior for fetching data.
protocol NetworkServiceProtocol {
    /// Generic method to fetch data from a given URLRequest and decode it into the specified type using RxSwift.
    /// - Parameters:
    ///   - type: The type of the data to be fetched and decoded.
    ///   - request: The URLRequest to fetch data from.
    /// - Returns: An Observable that emits the decoded data or a NetworkError.
    func fetch<T: Decodable>(_ type: T.Type, from request: URLRequest) -> Observable<T>
}
