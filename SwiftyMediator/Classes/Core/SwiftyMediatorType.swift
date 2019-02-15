#if os(iOS) || os(tvOS)
import UIKit
#endif

public protocol SwiftyMediatorType {
    func viewController(of target: MediatorTargetType) -> UIViewController?
}
