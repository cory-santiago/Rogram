//
//  PostView.swift
//  Rogram
//
//  Created by Cory Santiago on 9/17/24.
//

import RogramAPI
import SwiftUI

struct PostView: View {
    // -MARK: State
    @State var post: FeedPost
    let shouldUseFullImage: Bool
    let shouldShowHeart: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: shouldUseFullImage ? post.url : post.thumbnailUrl, content: { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Color(.gray)
                            .frame(maxWidth: .infinity, maxHeight: 400)
                        ProgressView {
                            Text("Loading")
                                .foregroundColor(.red)
                                .bold()
                        }
                    }
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 400)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            })
            HStack {
                Text(post.title).font(.title)
                if shouldShowHeart {
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                }
            }.padding(.horizontal, 16)
            .overlay(Divider(), alignment: .top)
        }.background(.white)
        .border(.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PostView(post: .init(albumId: 1,
                         id: 100,
                         title: "Test Post",
                         url: .init(string: "https://via.placeholder.com/600/92c952")!,
                         thumbnailUrl: .init(string: "https://via.placeholder.com/150/92c952")!),
             shouldUseFullImage: false,
             shouldShowHeart: true)
}
