import UIKit
import Swinject
import SwinjectStoryboard

// This enables injection of the initial view controller from the app's main
//   storyboard project settings. So, this is the starting point of the
//   dependency tree.
extension SwinjectStoryboard {
    public class func setup() {
        
        if AppDelegate.dependencyRegistry == nil {
            AppDelegate.dependencyRegistry = DependencyRegistryImpl(container: defaultContainer)
        }
        
        let dependencyRegistry:DependencyRegisty = AppDelegate.dependencyRegistry
        
        func main()
        {
            dependencyRegistry.container.storyboardInitCompleted(NewsListTableViewController.self){
                r, vc in
                
                let coordinator = dependencyRegistry.makeRootNavigationCoordinator(rootViewController: vc)
                setupData(resolver: r, navigationCoordinator: coordinator)
                
                let presenter = r.resolve(NewsListPresenter.self)!
                vc.configure(with: presenter,
                             navigationCoordinate: coordinator,
                             newsCellMaker:dependencyRegistry.makeNewsCell)
            }
        }
        
        func setupData(resolver r: Resolver, navigationCoordinator: NavigationCoordinator) {
            AppDelegate.navigationCoordinator = navigationCoordinator
        }
        
        main()

    }
}
