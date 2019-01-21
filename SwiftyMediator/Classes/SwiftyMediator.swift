#if os(iOS) || os(tvOS)
import UIKit
#endif

open class SwiftyMediator {
    
    public init() { }
    
    @discardableResult
    public func push(_ target: MediatorTargetType, from: UINavigationController? = nil, animated: Bool = true) -> UIViewController? {
        guard let viewController = target.viewController else { return nil }
        guard let navigationController = from ?? UIViewController.topMost?.navigationController else { return nil }
        navigationController.pushViewController(viewController, animated: animated)
        return viewController
    }
    
    @discardableResult
    public func present(_ target: MediatorTargetType, from: UIViewController? = nil, wrap: UINavigationController.Type? = nil, animated: Bool = true, completion: (() -> Void)? = nil) -> UIViewController? {
        guard let viewController = target.viewController else { return nil }
        guard let fromViewController = from ?? UIViewController.topMost else { return nil }
        
        let viewControllerToPresent: UIViewController
        if let navigationControllerClass = wrap, (viewController is UINavigationController) == false {
            viewControllerToPresent = navigationControllerClass.init(rootViewController: viewController)
        } else {
            viewControllerToPresent = viewController
        }
        
        fromViewController.present(viewControllerToPresent, animated: animated, completion: completion)
        return viewController
    }
}
