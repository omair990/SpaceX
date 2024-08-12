//
//  RocketResponseModel.swift
//  Devskiller
//
//  Created by Muhammad Umair on 07/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

/// Model representing the rocket details related to a SpaceX launch.
public struct RocketResponseModel: Codable {
    
    // MARK: - Properties
    
    public let name: String? // Optional name of the rocket
    public let type: String? // Optional type of the rocket
    public let id: String? // Optional unique identifier of the rocket
}
