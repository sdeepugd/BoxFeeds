//
//  URLUtils.swift
//  BoxFeeds
//
//  Created by Deepu on 14/08/21.
//

import Foundation

class URLUtils{
    static func getFeedsXMLFromUrl(url :URL, completionHandler: @escaping (Data)->()){
        URLSession.shared.dataTask(with: url){ (data,response,error) in
            guard let data = data else { return }
            completionHandler(data)
        }.resume()
    }
}
