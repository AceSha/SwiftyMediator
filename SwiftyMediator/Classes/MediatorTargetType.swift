#if os(iOS) || os(tvOS)
import UIKit
#endif

public protocol MediatorTargetType {
    var viewController: UIViewController? { get }
}

extension MediatorTargetType {
    var viewController: UIViewController? { return nil }
}
