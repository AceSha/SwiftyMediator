//
//  SwiftyMediator.swift
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

public let Mediator = SwiftyMediator()

open class SwiftyMediator {

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
