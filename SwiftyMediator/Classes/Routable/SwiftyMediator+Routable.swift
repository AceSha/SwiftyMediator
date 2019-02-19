//
//  SwiftyMediator+Routable.swift
//  SwiftyMediator
//
//  Created by shayuan on 02/18/2019.
//  Copyright (c) 2019 shayuan. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#if os(iOS) || os(tvOS)
import UIKit
#endif

private var routeTargetsKey = "routeTargetsKey"
private var replacePatternsKey = "replacePatternsKey"

extension SwiftyMediator: SwiftyMediatorRouterStoreType {
    
    internal var routeTargets: [MediatorRoutable.Type] {
        get { return objc_getAssociatedObject(self, &routeTargetsKey) as? [MediatorRoutable.Type] ?? [] }
        set { objc_setAssociatedObject(self, &routeTargetsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    internal var replacePatterns: [String: URLConvertible] {
        get { return objc_getAssociatedObject(self, &replacePatternsKey) as? [String: URLConvertible] ?? [:] }
        set { objc_setAssociatedObject(self, &replacePatternsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
}

extension SwiftyMediator: SwiftyMediatorRoutable {
    
    public func register(_ targetType: MediatorRoutable.Type) {
        self.routeTargets.append(targetType)
    }
    
    public func replace(url: URLConvertible, with replacer: URLConvertible) {
        self.replacePatterns[url.pattern] = replacer
    }

    public func targetType(of url: URLConvertible) -> MediatorTargetType? {
        let url = self.replacePatterns[url.pattern] ?? url
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


extension SwiftyMediator {

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
