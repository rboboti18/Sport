//
//  NewsPresenter.swift
//  sportUpdate
//
//  Created by rboboti on 20/02/2019.
//  Copyright © 2019 rboboti. All rights reserved.
//

import Foundation


protocol NewsPresenter {
    
    var news : Article! { get }
 
    var title       : String? { get }
    var url         : String? { get }
    var urlToImage  : String? { get }
    var publishedAt : String? { get }
    var content     : String? { get }
    
}

class NewsPresenterImpl: NewsPresenter {
    
    var news: Article!
    
    var title: String? { return news.title }
    var url: String?   { return news.url   }
    var urlToImage: String?  { return news.urlToImage }
    var publishedAt: String? { return news.publishedAt } 
    var content: String?     { return news.content }
    
    init(with news:Article) {
        self.news = news 
    }
    
    
}
