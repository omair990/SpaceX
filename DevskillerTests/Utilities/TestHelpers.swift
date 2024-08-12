//
//  TestHelpers.swift
//  DevskillerTests
//
//  Created by Muhammad Umair on 08/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

// MARK: - Helper Methods
struct TestHelper {
    static func loadMockData(_ resourceName: String, bundle: Bundle) -> Data {
        guard let url = bundle.url(forResource: resourceName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(resourceName).json")
        }
        return data
    }
}
