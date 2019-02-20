//
//  NewsCelllPresenter.swift
//  sportUpdate
//
//  Created by rboboti on 20/02/2019.
//  Copyright © 2019 rboboti. All rights reserved.
//

import Foundation

protocol NewsCellPresenter {
    var title       : String { get }
    var description : String { get }
    var url         : String { get }
    var urlToImage  : String? { get }
    var publishedAt : String { get }
    var content     : String { get } 
}

class NewsCellPresenterImpl: NewsCellPresenter {
    
    var article : Article
    
    var title      : String { return article.title! }
    var description: String { return article.newsDesc! }
    var url        : String { return article.url! }
    var urlToImage : String? { return article.urlToImage }
    var publishedAt: String { return article.publishedAt! }
    var content:     String { return article.content! }
    
    init(article:Article) {
        self.article = article
    }

}

