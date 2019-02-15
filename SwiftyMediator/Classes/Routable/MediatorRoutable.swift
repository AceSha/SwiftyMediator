#if os(iOS) || os(tvOS)
import UIKit
#endif

public protocol MediatorRoutable where Self: MediatorTargetType {
    init?(url: URLConvertible)
}
