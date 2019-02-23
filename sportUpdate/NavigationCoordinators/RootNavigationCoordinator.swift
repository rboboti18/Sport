//
//  RootNavigationCoordinator.swift
//  sportUpdate
//
//  Created by rboboti on 20/02/2019.
//  Copyright © 2019 rboboti. All rights reserved.
//

import UIKit


protocol NavigationCoordinator : class {
    func next(arguments: Dictionary<String, Any>?) 
    func movingBack()
}

enum NavigationState{
    case atNewsList,
         atNewsView
} 

class RootNavigationCoordinatorImpl: NavigationCoordinator {

    var registry : DependencyRegisty
    var rootViewController : UIViewController
    
    var navState : NavigationState = .atNewsList 
    
    init(with rootViewController: UIViewController, registry:DependencyRegisty){
        self.rootViewController = rootViewController
        self.registry = registry
    }
    
    func next(arguments: Dictionary<String, Any>?) {
        switch navState {
        case .atNewsList:
            showDetails(arguments: arguments)
        default:
            break
        }
    }
    
    func movingBack() {
        switch navState {
        case .atNewsList:
            break
        case .atNewsView:
            navState = .atNewsList
            break
        }
    }
    
    func showDetails(arguments: Dictionary<String, Any>?) {
        
        guard let news = arguments?["article"] as? Article else { notifyNilArguments(); return }
        let newsViewContoller = registry.makeNewsViewMaker(with: news)
        
        rootViewController.navigationController?.pushViewController(newsViewContoller, animated: true)
        navState = .atNewsView 
    }
    
   
    
    func showNewsList() {
        rootViewController.navigationController?.popToRootViewController(animated: true)
        navState = .atNewsList
    }
    
    func notifyNilArguments() {
        print("notify user of error") 
    }
}
