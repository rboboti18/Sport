//
//  NewsListPresenter.swift
//  sportUpdate
//
//  Created by rboboti on 18/02/2019.
//  Copyright © 2019 rboboti. All rights reserved.
//

import Foundation

protocol NewsListPresenter {
    var datas : [Article] { get }
    func loadDataFromAPI(forURL url: String, completion:@escaping (() -> Void))
}

class NewsListPresenterImpl : NewsListPresenter {
    var datas = [Article]()
    fileprivate var networkLayer : NetworkLayer! 
    
    init(networkLayer:NetworkLayer) {
        self.networkLayer = networkLayer
    }
}


extension NewsListPresenterImpl {
    func loadDataFromAPI(forURL url: String, completion:@escaping ( () -> Void)) {  
        
        self.networkLayer.getSportNews(url: url, completion: { [weak self]
            datas, error in
            self?.datas = Array(datas!) 
            completion() 
        })
    }
}
