#if os(iOS) || os(tvOS)
import UIKit
#endif

public protocol MediatorTargetType {}

public protocol MediatorSourceType {
    var viewController: UIViewController? { get }
}
