import UIKit
import Swinject
import SwinjectStoryboard

protocol DependencyRegisty {
    var container : Container { get }
    var navigationCoordinator: NavigationCoordinator! { get }
    
    typealias rootNavigationCoordinator = (UIViewController) -> NavigationCoordinator
    func makeRootNavigationCoordinator(rootViewController: UIViewController) -> NavigationCoordinator
    
    typealias NewsCellMaker = (UITableView, IndexPath, Article) -> NewsCell
    func makeNewsCell(for tableView: UITableView, at indexPath: IndexPath, article: Article) -> NewsCell
    
    typealias newsViewMaker       = (Article) -> NewsViewController
    func makeNewsViewMaker(with news:Article) -> NewsViewController
}


class DependencyRegistryImpl: DependencyRegisty {
     
    var container: Container
    var navigationCoordinator: NavigationCoordinator!

    init(container: Container) { 
        
        Container.loggingFunction = nil 
        self.container = container
        
        registerDependencies()
        registerPresenters()
        registerViewsControllers()
    }
    
   func registerDependencies()
   {
        container.register(NavigationCoordinator.self){
            (r, rootViewController:UIViewController) in
            return RootNavigationCoordinatorImpl(with: rootViewController, registry: self)
        }.inObjectScope(.container)
    
        container.register(NetworkLayer.self){_ in NetworkLayerImpl()
        }.inObjectScope(.container)  
   }
    
    func registerPresenters() {
        container.register(NewsListPresenter.self) {
            r in NewsListPresenterImpl(networkLayer: r.resolve(NetworkLayer.self)!)}
        
        container.register(NewsCellPresenter.self) {
            (r, article: Article) in
            NewsCellPresenterImpl(article: article)
        }
        container.register(NewsPresenter.self) {
            (r, news: Article) in NewsPresenterImpl(with: news)
        }
    }
    
    func registerViewsControllers(){
        container.register(NewsViewController.self) {
            (r, news:Article) in
            let presenter = r.resolve(NewsPresenter.self, argument: news)!
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController 
            
            vc.configure(with: presenter, coordinator: self.navigationCoordinator)
            return vc 
        }
    }
    
    func makeRootNavigationCoordinator(rootViewController: UIViewController) -> NavigationCoordinator {
        navigationCoordinator = container.resolve(NavigationCoordinator.self, argument: rootViewController)!
        return navigationCoordinator 
    }
    
    func makeNewsCell(for tableView: UITableView, at indexPath: IndexPath, article: Article) -> NewsCell {
       
        let presenter = container.resolve(NewsCellPresenter.self, argument: article)!
        let cell = NewsCell.dequeue(from: tableView, for: indexPath, with: presenter)
        return cell
    }
    
    func makeNewsViewMaker(with news: Article) -> NewsViewController {
        return container.resolve(NewsViewController.self, argument: news)!  
    }
    
    
   
}
