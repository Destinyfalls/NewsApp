//
//  NetworkingManager.swift
//  NewsApp
//
//  Created by Igor Belobrov on 27.11.2020.
//

import Foundation
import Alamofire

enum Defaults {
    static let apiKey = "064017255b664979a02b1488a22f4f34"
    static let baseUrl = "https://newsapi.org/v2/everything"
}

class NetworkingManager {

    static let shared = NetworkingManager()
    
    func getAllNews(page: Int, topic: String, completion: (([News]) -> Void)?) {
        
        let parameters: [String:Any] = ["apiKey": Defaults.apiKey, "q": topic, "page": page, "pageSize": 10]
        
        AF.request(Defaults.baseUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).response
        { (responseData) in
            guard let data = responseData.data else {return}
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonArray = jsonResponse as? [String: Any],
                      let articles = jsonArray["articles"] as? [[String: Any]] else { return }
                var allNews = [News]()
                articles.forEach({allNews.append(News(with: $0)) })
                completion?(allNews)
            } catch {
                print("Error decoding == \(error)")
            }
        }
    }
}
