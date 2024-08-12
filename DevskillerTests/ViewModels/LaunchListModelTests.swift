//
//  LaunchListModelTests.swift
//  DevskillerTests
//
//  Created by Muhammad Umair on 07/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

@testable import Devskiller

// MARK: - LaunchListModelTests
class LaunchListModelTests: XCTestCase {
    
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        disposeBag = nil
        super.tearDown()
    }

    // Test initialization of LaunchListModel from a decoded LaunchResponseModel
    func testLaunchListModelInitialization() {
        let data = TestHelper.loadMockData(TestConstants.mockLaunchList, bundle: Bundle(for: type(of: self)))
        let launchResponse = try! JSONDecoder().decode(LaunchResponseModel.self, from: data)
        let mockLaunchModel = launchResponse.docs.first!

        let observable = Observable.just(mockLaunchModel)
            .map { LaunchListModel(from: $0) }
        
        let launchListModel = try! observable.toBlocking().first()
        XCTAssertEqual(launchListModel?.id, TestConstants.launchId)
        XCTAssertEqual(launchListModel?.name, TestConstants.launchName)
        XCTAssertEqual(launchListModel?.date, TestConstants.launchDate)
        XCTAssertEqual(launchListModel?.success, true)
        XCTAssertEqual(launchListModel?.rocket_name, TestConstants.rocketName)
        XCTAssertEqual(launchListModel?.rocket_type, TestConstants.rocketType)
        XCTAssertEqual(launchListModel?.missionPatchURL, TestConstants.missionPatchSmallURL)
        XCTAssertEqual(launchListModel?.articleURL?.absoluteString, TestConstants.articleURL)
        XCTAssertEqual(launchListModel?.wikipediaURL?.absoluteString, TestConstants.wikipediaURL)
        XCTAssertEqual(launchListModel?.videoID, TestConstants.youtubeId)
    }
    
    // Test reconversion from LaunchListModel back to LaunchModel
    func testLaunchModelReconversion() {
        let data = TestHelper.loadMockData(TestConstants.mockLaunchList, bundle: Bundle(for: type(of: self)))
        let launchResponse = try! JSONDecoder().decode(LaunchResponseModel.self, from: data)
        let mockLaunchModel = launchResponse.docs.first!

        let observable = Observable.just(mockLaunchModel)
            .map { LaunchListModel(from: $0) }
            .map { $0.toLaunchModel() }
        
        let launchModel = try! observable.toBlocking().first()
        XCTAssertEqual(launchModel?.id, TestConstants.launchId)
        XCTAssertEqual(launchModel?.name, TestConstants.launchName)
        XCTAssertEqual(launchModel?.date_utc, TestConstants.launchDate)
        XCTAssertEqual(launchModel?.success, true)
        XCTAssertEqual(launchModel?.rocket?.name, TestConstants.rocketName)
        XCTAssertEqual(launchModel?.rocket?.type, TestConstants.rocketType)
        XCTAssertEqual(launchModel?.links?.patch?.small, TestConstants.missionPatchSmallURL)
        XCTAssertEqual(launchModel?.links?.article, TestConstants.articleURL)
        XCTAssertEqual(launchModel?.links?.wikipedia, TestConstants.wikipediaURL)
        XCTAssertEqual(launchModel?.links?.youtube_id, TestConstants.youtubeId)
    }
}
