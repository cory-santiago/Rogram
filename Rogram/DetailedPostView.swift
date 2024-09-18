//
//  DetailedPostView.swift
//  Rogram
//
//  Created by Cory Santiago on 9/17/24.
//

import RogramAPI
import SwiftUI

struct DetailedPostView: View {
    // -MARK: State
    @State var post: FeedPost
    
    var body: some View {
        PostView(post: post,
                 shouldUseFullImage: true,
                 shouldShowHeart: false)
    }
}

#Preview {
    DetailedPostView(post: .init(albumId: 1,
                                 id: 100,
                                 title: "Test Post",
                                 url: .init(string: "https://via.placeholder.com/600/92c952")!,
                                 thumbnailUrl: .init(string: "https://via.placeholder.com/150/92c952")!))
}
