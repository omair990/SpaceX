//
//  LaunchListServiceTests.swift
//  DevskillerTests
//
//  Created by Muhammad Umair on 08/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

@testable import Devskiller

// Tests for LaunchListService
class LaunchListServiceTests: XCTestCase {
    
    var service: LaunchListService!
    var mockNetworkService: MockNetworkService!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        mockNetworkService = MockNetworkService()
        service = LaunchListService(networkService: mockNetworkService)
    }

    override func tearDown() {
        disposeBag = nil
        mockNetworkService = nil
        service = nil
        super.tearDown()
    }

    func testFetchLaunchesSuccess() {
        // Given a successful mock response
        mockNetworkService.mockResponse = .success(TestHelper.loadMockData(TestConstants.mockLaunchList, bundle: Bundle(for: type(of: self))))

        let requestModel = LaunchRequestModel()
        let launchesObservable = service.fetchLaunches(request: requestModel)

        let launchResponse = try! launchesObservable.toBlocking().first()
        XCTAssertNotNil(launchResponse)
        XCTAssertEqual(launchResponse?.docs.count, 1)
    }
    
    func testFetchLaunchesFailure() {
        // Given a failed mock response
        mockNetworkService.mockResponse = .failure(NSError(domain: "", code: -1, userInfo: nil))

        let requestModel = LaunchRequestModel()
        let launchesObservable = service.fetchLaunches(request: requestModel)
        
        XCTAssertThrowsError(try launchesObservable.toBlocking().first(), "Expected error but got none")
    }
}
