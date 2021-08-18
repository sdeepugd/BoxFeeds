//
//  FeedXMLParser.swift
//  BoxFeeds
//
//  Created by Deepu on 14/08/21.
//

import Foundation
import FeedKit


class FeedXMLParser:NSObject {
    var url:URL
    var feedList:FeedList
    
    init(url:URL) {
        self.url = url
        feedList = FeedList()
    }
    
    func parse(){
        let parser = FeedParser(URL: url)
        let result = parser.parse()
        switch result {
        case .success(let feed):
            switch feed {
            case let .atom(feed):       // Atom Syndication Format Feed Model
                feedList.title = feed.title!
                feedList.subtitle = feed.subtitle?.value
                feedList.link = feed.links?.first?.attributes?.href
                feedList.pubDate = feed.updated!
                var feedItems = [Feed]()
                for rssfeedItem in feed.entries!{
                    let feedItem = Feed()
                    feedItem.author = rssfeedItem.authors?.first?.name
                    feedItem.content = rssfeedItem.content?.value!
                    feedItem.id = rssfeedItem.id
                    feedItem.link = rssfeedItem.links?[0].attributes?.href
                    feedItem.summary = rssfeedItem.summary?.value!
                    feedItem.title = rssfeedItem.title!
                    feedItem.pubDate = rssfeedItem.updated!
                    feedItems.append(feedItem)
                }
                feedList.feeds = feedItems
                break
            case let .rss(feed):        // Really Simple Syndication Feed Model
                feedList.title = feed.title!
                feedList.subtitle = feed.description!
                feedList.imageLink = feed.image?.link!
                feedList.link = feed.link!
                feedList.pubDate = feed.pubDate!
                var feedItems = [Feed]()
                for rssfeedItem in feed.items!{
                    let feedItem = Feed()
                    feedItem.author = rssfeedItem.author!
                    feedItem.content = rssfeedItem.content?.contentEncoded!
                    feedItem.id = rssfeedItem.guid?.value!
                    feedItem.link = rssfeedItem.link!
                    feedItem.summary = rssfeedItem.description!
                    feedItem.title = rssfeedItem.title!
                    feedItem.pubDate = rssfeedItem.pubDate!
                    feedItems.append(feedItem)
                }
                feedList.feeds = feedItems
                break
            case let .json(feed):       // JSON Feed Model
                print(feed.title!)
                break
            }
        case .failure(let error):
            print(error)
        }
    }
}


