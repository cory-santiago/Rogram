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
    
    let api: PostAPI
    // call the API upon load
    // add state var for the posts
    // add pull to refresh

    var body: some View {
        NavigationStack {
            ScrollView {
                // 4. Populate into grid
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                    ForEach(posts) { post in
                        cardView(forPost: post)
                            .padding(.vertical, 8)
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .principal) { Text("Ro").foregroundColor(.black).font(.largeTitle)     
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.white, for: .navigationBar)
            .background(.black)
        }
//        .navigationTitle("Ro")
//        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            Task {
                if let newPosts = try? await api.fetchMainFeed() {
                    self.posts = newPosts
                }
            }
        })
//        NavigationSplitView {
//            ScrollView {
//                // 4. Populate into grid
//                LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
//                    ForEach(posts) { post in
//                        cardView(forPost: post)
//                            .padding(.vertical, 8)
//                    }
//                }
//                .padding()
//            }.background(.black)
//        } detail: {
//            Text("Select an photo")
//        }
//        .navigationTitle("Ro")
        
    }
    
    func cardView(forPost: FeedPost) -> some View {
        VStack {
            AsyncImage(url: forPost.thumbnailUrl, content: { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            })
            HStack {
                Text(forPost.title).font(.title)
                Spacer()
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red)
            }.padding(.horizontal, 16)
            .overlay(Divider(), alignment: .top)
        }.background(.white)
        .border(.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
    }
    /*
     NavigationLink {
         Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
     } label: {
         Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
     }
     
     NavigationView that says Ro
     VStack {
     AsyncImage
     HStack {
     Text, heart shape
     }
     }
    */

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView(api: RogramNetworking())
        .modelContainer(for: Item.self, inMemory: true)
}
