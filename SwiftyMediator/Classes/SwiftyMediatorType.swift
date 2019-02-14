#if os(iOS) || os(tvOS)
import UIKit
#endif

public protocol SwiftyMediatorType: SwiftyMediatorRoutable {
    func viewController(of target: MediatorTargetType) -> UIViewController?
}

public protocol SwiftyMediatorRoutable {
    func targetType(of url: URLConvertible) -> MediatorTargetType?
    func viewController(of url: URLConvertible) -> UIViewController?
}
