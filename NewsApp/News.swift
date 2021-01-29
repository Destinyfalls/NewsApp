//
//  News.swift
//  NewsApp
//
//  Created by Igor Belobrov on 27.11.2020.
//

import Foundation

class News: NSObject {
    
    var sourceId: String?
    var sourceName: String?
    var author: String?
    var title: String?
    var specification: String?
    var urlToImage : String?
    var mainUrl: URL?
    var imageUrl: URL?
    
    init(with newsDictionary: [String: Any]) {
        author = newsDictionary["author"] as? String ?? ""
        title = newsDictionary["title"] as? String ?? ""
        specification = newsDictionary["description"] as? String ?? ""
        urlToImage = newsDictionary["urlToImage"] as? String ?? ""
        mainUrl = URL(string: newsDictionary["url"] as? String ?? "")
        imageUrl = URL(string: newsDictionary["urlToImage"] as? String ?? "")
        if let source = newsDictionary["source"] as? [String: Any] {
            sourceId = source["id"] as? String ?? ""
            sourceName = source["name"] as? String ?? ""
        }
    }
}

