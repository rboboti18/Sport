//
//  NetworkLayer.swift
//  sportUpdate
//
//  Created by rboboti on 18/02/2019.
//  Copyright © 2019 rboboti. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

let urlAPI = "https://newsapi.org/v2/top-headlines?country=fr&category=sports&apiKey=616e2e9c174d494ca39ddf1e6fccb272" 

protocol NetworkLayer {
    func getSportNews(url urlString: String, completion: @escaping (List<Article>?, Error?) -> Void)
}

class NetworkLayerImpl: NetworkLayer  {
        
    func getSportNews(url urlString: String, completion: @escaping (List<Article>?, Error?) -> Void) {
        
        let url = URL(string: urlString)
        
        Alamofire.request(url!).responseJSON(completionHandler: {
            response in
            if response.response?.statusCode == 200 {
                
                switch response.result
                {
                    case .success:
                        guard
                            let data = response.data
                        else { return }
                        
                        let decoder = JSONDecoder()
                        let result  = try! decoder.decode(News.self, from: data)
                        completion(result.articles, nil)
                    break
                    case .failure(let error):
                        completion(nil, error)  
                    break
                }
            }
        })
        
    }
    
}
