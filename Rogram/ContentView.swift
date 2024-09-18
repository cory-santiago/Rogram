//
//  ContentView.swift
//  Rogram
//
//  Created by Cory Santiago on 9/16/24.
//

import RogramAPI
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var posts: [FeedPost] = []
    @State private var showDetailedView = false
    @State private var selectedPost: FeedPost?
    
    let api: PostAPI

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                    ForEach(posts) { post in
                        PostView(post: post,
                                 shouldUseFullImage: false,
                                 shouldShowHeart: true)
                        .padding(.vertical, 8)
                        .onTapGesture {
                            userTappedPost(post)
                        }
                    }
                }
                .padding()
            }
            .navigationDestination(isPresented: $showDetailedView) {
                if let post = selectedPost {
                    DetailedPostView(post: post)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) { Text("Ro").foregroundColor(.black).font(.largeTitle)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.white, for: .navigationBar)
        }
        .onAppear(perform: {
            Task {
                if let newPosts = try? await api.fetchMainFeed() {
                    self.posts = newPosts
                }
            }
        })
    }
    
    private func userTappedPost(_ post: FeedPost) {
        selectedPost = post
        showDetailedView = true
    }
}

#Preview {
    ContentView(api: RogramNetworking())
        .modelContainer(for: Item.self, inMemory: true)
}
