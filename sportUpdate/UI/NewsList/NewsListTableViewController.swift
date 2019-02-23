//
//  NewsListTableViewController.swift
//  sportUpdate
//
//  Created by rboboti on 18/02/2019.
//  Copyright © 2019 rboboti. All rights reserved.
//

import UIKit

class NewsListTableViewController: UITableViewController {
    
    weak var navigationCoordinator: NavigationCoordinator?
    
    fileprivate var presenter: NewsListPresenter!
    fileprivate var newsCellMaker: DependencyRegisty.NewsCellMaker!
    
    
    func configure(with presenter:NewsListPresenter,
                   navigationCoordinate:NavigationCoordinator,
                   newsCellMaker: @escaping DependencyRegisty.NewsCellMaker)
    {
        self.presenter             = presenter
        self.navigationCoordinator = navigationCoordinate 
        self.newsCellMaker         = newsCellMaker 
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        NewsCell.register(with: tableView)
        
        presenter.loadDataFromAPI(forURL: urlAPI, completion: {
            self.newDataReceived() 
        })
        
    }
    
    func newDataReceived()
    {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter.datas.count 
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        let news = presenter.datas[indexPath.row]
        let cell = newsCellMaker(tableView, indexPath, news) 
        
        return cell
    }

}

extension NewsListTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = presenter.datas[indexPath.row]
        next(with: news)
    }
    
    func next(with news:Article) {
        let args = ["article": news]
        navigationCoordinator!.next(arguments: args)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
