//
//  FeedListTVCell.swift
//  BoxFeeds
//
//  Created by Deepak Srinivasan on 16/08/21.
//
import UIKit
import FluentUI

class FeedListTVCell : UITableViewCell {
    
    var feed:Feed?
    static let identifier = "FeedListTVCell"
    
    let title : UILabel = {
        let titleView = Label(style: .title1, colorStyle: .regular)
        titleView.contentMode = .left
        titleView.lineBreakMode = .byTruncatingMiddle
        return titleView
    }()
    
    let subtitle : UILabel = {
        let subtitleView = Label(style: .title2, colorStyle: .regular)
        subtitleView.contentMode = .left
        subtitleView.lineBreakMode = .byTruncatingMiddle
        return subtitleView
    }()
    
    let dateView : UILabel = {
        let dateView = Label(style: .title2, colorStyle: .regular)
        dateView.contentMode = .left
        dateView.lineBreakMode = .byTruncatingMiddle
        return dateView
    }()
    
    public func config(feed:Feed,style: UITableViewCell.CellStyle) {
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        
        let dateStack = UIStackView()
        dateStack.axis = .vertical
        let date = feed.pubDate
        let dateFormatter = DateFormatter()
        dateView.text = dateFormatter.string(from: date!)
        dateStack.addArrangedSubview(dateView)
        dateStack.alignment = .trailing
        mainStack.addArrangedSubview(dateStack)
        
        let textStack = UIStackView()
        textStack.axis = .vertical
        title.text = feed.title
        textStack.addArrangedSubview(title)
        subtitle.text = feed.summary
        mainStack.addArrangedSubview(textStack)
    }
    
}
