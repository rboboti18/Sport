//
//  News.swift
//  sportUpdate
//
//  Created by rboboti on 18/02/2019.
//  Copyright © 2019 rboboti. All rights reserved.
//

import RealmSwift

class News: Object, Decodable {
    
    @objc dynamic var status: String?
    @objc dynamic var totalResults:Int = 0
    let articles = List<Article>()
    
    enum CodingKeys : String, CodingKey {
        case status
        case totalResults
        case articles = "articles" 
    }
   
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container     = try decoder.container(keyedBy: CodingKeys.self)
        self.status       = try container.decode(String.self, forKey: .status)
        self.totalResults = try container.decode(Int.self, forKey: .totalResults)

        
        let articlesArray = try container.decodeIfPresent([Article].self, forKey: .articles) ?? [Article()]
        self.articles.append(objectsIn: articlesArray)
        
    }
}


