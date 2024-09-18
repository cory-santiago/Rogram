//
//  RogramTests.swift
//  RogramTests
//
//  Created by Cory Santiago on 9/16/24.
//

import RogramAPI
import XCTest
@testable import Rogram

final class RogramTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

private final class MockRogramAPI: PostAPI {
    var fetchMainFeedResponse: [RogramAPI.FeedPost] = []
    func fetchMainFeed() async throws -> [RogramAPI.FeedPost] {
        return fetchMainFeedResponse
    }
}
