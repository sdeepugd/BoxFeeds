//
//  ViewController.swift
//  BoxFeeds
//
//  Created by Deepu on 13/08/21.
//

import UIKit

class FeedListTVC: UIViewController {

    var feedList:FeedList?
    let refreshControl = UIRefreshControl()
    var tableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        let fxp = FeedXMLParser(url: URL(  string: "https://nshipster.com/feed.xml")!)
        
        tableView = UITableView()
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(FeedListTVCell.self, forCellReuseIdentifier: FeedListTVCell.identifier)
        self.view.addSubview(tableView!)
        guard let tableView = tableView else {return}
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
        
        tableView.refreshControl = refreshControl

    }

}

extension FeedListTVC:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let feedList = feedList {
            return (feedList.feeds?.count)!
        }
        else
        {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedListTVCell.identifier) as! FeedListTVCell
        guard let feedList = feedList else {return UITableViewCell()}
        let feed = feedList.feeds?[indexPath.row]
        guard let feed = feed else {return UITableViewCell()}
        cell.config(feed: feed, style: .default)
        return cell
    }
}

extension FeedListTVC:UITableViewDelegate {
    
}
