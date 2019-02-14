#if os(iOS) || os(tvOS)
import UIKit
#endif

public let Mediator = SwiftyMediator()

open class SwiftyMediator {
    private var routeTargets: [MediatorRoutable.Type] = []
    private var replacePatterns: [String: URLConvertible] = [:]
    
    public func register(_ targetType: MediatorRoutable.Type) {
        self.routeTargets.append(targetType)
    }
    
    public func replace(url: URLConvertible, with replacer: URLConvertible) {
        self.replacePatterns[url.pattern] = replacer
    }

    @discardableResult
    public func push(_ target: MediatorTargetType, from: UINavigationController? = nil, animated: Bool = true) -> UIViewController? {
        guard let viewController = self.viewController(of: target) else { return nil }
        guard let navigationController = from ?? UIViewController.topMost?.navigationController else { return nil }
        navigationController.pushViewController(viewController, animated: animated)
        return viewController
    }
    
    @discardableResult
    public func present(_ target: MediatorTargetType, from: UIViewController? = nil, wrap: UINavigationController.Type? = nil, animated: Bool = true, completion: (() -> Void)? = nil) -> UIViewController? {
        guard let viewController = self.viewController(of: target) else { return nil }
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
    
    @discardableResult
    public func push(_ url: URLConvertible, from: UINavigationController? = nil, animated: Bool = true) -> UIViewController? {
        guard let target = self.targetType(of: url) else { return nil }
        return self.push(target, from: from, animated: animated)
    }
    
    @discardableResult
    public func present(_ url: URLConvertible, from: UIViewController? = nil, wrap: UINavigationController.Type? = nil, animated: Bool = true, completion: (() -> Void)? = nil) -> UIViewController? {
        guard let target = self.targetType(of: url) else { return nil }
        return self.present(target, from: from, wrap: wrap, animated: animated, completion: completion)
    }
    
}

extension SwiftyMediator: SwiftyMediatorType {
    public func viewController(of target: MediatorTargetType) -> UIViewController? {
        guard let t = target as? MediatorSourceType else {
            print("MEDIATOR WARNINIG: \(target) does not conform to MediatorSourceType")
            return nil
        }
        guard let viewController = t.viewController else { return nil }
        return viewController
    }
}

extension SwiftyMediator: SwiftyMediatorRoutable {
    public func targetType(of url: URLConvertible) -> MediatorTargetType? {
        guard let routable = routeTargets.compactMap({ $0.init(url: url) }).first else { return nil  }
        guard let target = routable as? MediatorTargetType else { return nil }
        return target
    }
    
    public func viewController(of url: URLConvertible) -> UIViewController? {
        let url = self.replacePatterns[url.pattern] ?? url
        guard let target = self.targetType(of: url) else { return nil }
        return self.viewController(of: target)
    }
}
