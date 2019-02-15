#if os(iOS) || os(tvOS)
import UIKit
#endif

protocol SwiftyMediatorRouterStoreType {
    var routeTargets: [MediatorRoutable.Type] { get set }
    var replacePatterns: [String: URLConvertible] { get set }
}

public protocol SwiftyMediatorRoutable where Self: SwiftyMediatorRouterStoreType {
    func register(_ targetType: MediatorRoutable.Type)
    func replace(url: URLConvertible, with replacer: URLConvertible)
    
    func targetType(of url: URLConvertible) -> MediatorTargetType?
    func viewController(of url: URLConvertible) -> UIViewController?
}
