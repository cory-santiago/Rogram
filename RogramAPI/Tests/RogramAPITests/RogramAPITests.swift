import XCTest
@testable import RogramAPI

final class RogramAPITests: XCTestCase {
    var sut: PostAPI!
    
    override func setUp() {
        sut = RogramNetworking()
    }
    
    func testCreationOfFeedPost() {
        let feedpost = FeedPost(albumId: 1, id: 1, title: "Title", url: URL(filePath: "test/path"), thumbnailUrl: URL(filePath: "test/path/thumb"))
        XCTAssert(feedpost.albumId == 1)
        XCTAssert(feedpost.id == 1)
        XCTAssert(feedpost.title == "Title")
        XCTAssert(feedpost.url == URL(filePath: "test/path"))
        XCTAssert(feedpost.thumbnailUrl == URL(filePath: "test/path/thumb"))
    }
    
    func testFetchMainFeedUsingLocalFile() async {
        // when
        let mainFeed = try? await sut.fetchMainFeed()
        // then
        XCTAssertNotNil(mainFeed)
        XCTAssert(mainFeed?.count == 50)
        
        // given
        let firstPost = mainFeed?.first
        // then
        XCTAssert(firstPost?.albumId == 1)
        XCTAssert(firstPost?.id == 1)
        XCTAssert(firstPost?.title == "accusamus beatae ad facilis cum similique qui sunt")
        XCTAssert(firstPost?.url.absoluteString == "https://via.placeholder.com/600/92c952")
        XCTAssert(firstPost?.thumbnailUrl.absoluteString == "https://via.placeholder.com/150/92c952")
        
        // given
        let lastPost = mainFeed?.last
        // then
        XCTAssert(lastPost?.albumId == 1)
        XCTAssert(lastPost?.id == 50)
        XCTAssert(lastPost?.title == "et inventore quae ut tempore eius voluptatum")
        XCTAssert(lastPost?.url.absoluteString == "https://via.placeholder.com/600/9e59da")
        XCTAssert(lastPost?.thumbnailUrl.absoluteString == "https://via.placeholder.com/150/9e59da")
    }
}
