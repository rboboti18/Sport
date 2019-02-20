//
//  News.swift
//  sportUpdate
//
//  Created by rboboti on 18/02/2019.
//  Copyright © 2019 rboboti. All rights reserved.
//

import RealmSwift


class Article: Object, Decodable {
    
    @objc dynamic var newsDesc : String? 
    @objc dynamic var author : String?
    @objc dynamic var title  : String?
    @objc dynamic var url    : String?
    @objc dynamic var urlToImage  : String?
    @objc dynamic var publishedAt : String?
    @objc dynamic var content : String?
    @objc dynamic var source  : Source?
    
    enum CodingKeys : String, CodingKey {
        case author, title, url, urlToImage, publishedAt, content, source
        case newsDesc = "description"
    }
}

class Source: Object, Decodable {
    @objc dynamic var id: String?
    @objc dynamic var name : String?
}
