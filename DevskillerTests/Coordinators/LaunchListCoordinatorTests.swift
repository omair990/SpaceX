//
//  LaunchListCoordinatorTests.swift
//  DevskillerTests
//
//  Created by Muhammad Umair on 07/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import XCTest
@testable import Devskiller

// Tests for LaunchListCoordinator
class LaunchListCoordinatorTests: XCTestCase {

    var coordinator: LaunchListCoordinator!
    var mockNavigationController: MockNavigationController!

    override func setUp() {
        super.setUp()
        mockNavigationController = MockNavigationController()
        coordinator = LaunchListCoordinator(navigationController: mockNavigationController)
    }

    override func tearDown() {
        coordinator = nil
        mockNavigationController = nil
        super.tearDown()
    }

    func testShowLaunchDetail() {
        // Given a mock launch model
        let launchModel = LaunchModel(
            id: TestConstants.launchId,
            name: TestConstants.launchName,
            date_utc: TestConstants.launchDate,
            success: true,
            rocket: RocketResponseModel(name: TestConstants.rocketName, type: TestConstants.rocketType, id: TestConstants.rocketId),
            links: LinksResponseModel(
                patch: LinksResponseModel.PatchResponseModel(small: TestConstants.missionPatchSmallURL, large: nil),
                youtube_id: TestConstants.youtubeId,
                article: TestConstants.articleURL,
                wikipedia: TestConstants.wikipediaURL
            )
        )

        let mockLaunch = LaunchListModel(from: launchModel)
        XCTAssertEqual(mockLaunch.id, TestConstants.launchId, "Expected mock launch ID to be '\(TestConstants.launchId)' but got \(mockLaunch.id)")

        let expectation = self.expectation(description: "Waiting for showLaunchDetail to push view controller")
        coordinator.showLaunchDetail(for: mockLaunch)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertTrue(mockNavigationController.pushedViewController is LaunchDetailViewController, "Expected LaunchDetailViewController but got \(String(describing: mockNavigationController.pushedViewController))")
    }
}
