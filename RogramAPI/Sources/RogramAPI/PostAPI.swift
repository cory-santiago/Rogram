// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public protocol PostAPI {
    /// Fetches post for the feed
    /// - Note: Should be updated to support pagination
    func fetchMainFeed() async throws ->  [FeedPost]
}

final public class RogramNetworking: PostAPI {
    static private let mockFileName = "MockMainFeedResponse"
    
    public init() { }
    
    public func fetchMainFeed() async throws -> [FeedPost] {
        return loadJson(filename: Self.mockFileName) ?? []
    }
}

internal extension RogramNetworking {
    // Improvement: Create a generic version of this function
    func loadJson(filename fileName: String) -> [FeedPost]? {
        if let url = Bundle.module.url(forResource: fileName, withExtension: nil) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([FeedPost].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
