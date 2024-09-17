//  RogramAPI
//  FeedPost.swift
//
//  Created by Cory Santiago on 9/16/24.
//

import Foundation

/// Model Object to represent the json response from the feed endpoint
public struct FeedPost: Codable, Identifiable {
    public let albumId: Int
    public let id: Int
    public let title: String
    public let url: URL
    public let thumbnailUrl: URL
    
    init(albumId: Int, id: Int, title: String, url: URL, thumbnailUrl: URL) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}
