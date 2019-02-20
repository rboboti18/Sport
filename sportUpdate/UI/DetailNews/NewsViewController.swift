//
//  NewsViewController.swift
//  sportUpdate
//
//  Created by rboboti on 20/02/2019.
//  Copyright © 2019 rboboti. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    fileprivate var newsPresenter : NewsPresenter!
    fileprivate weak var navigationCoordinator: NavigationCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView() 
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            navigationCoordinator?.movingBack()
        }
    }
    
    func configure(with presenter: NewsPresenter, coordinator:NavigationCoordinator)
    {
        self.newsPresenter = presenter
        self.navigationCoordinator = coordinator 
    }
    
    func setupView() {
        if let title = newsPresenter.title {
            titleLabel.text = title
        }
        if let content = newsPresenter.content {
            contentLabel.text  = content
        }
        
        OperationQueue.main.addOperation({
            guard
                let urlImage = self.newsPresenter.urlToImage
            else { return }
            
            self.loadArticleImage(url: urlImage) 
        })
    }
    
    func loadArticleImage(url:String)
    {
        articleImage.sd_setImage(with: URL(string: url), completed: nil)
    }
   

}
