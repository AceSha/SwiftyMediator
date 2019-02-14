//
//  ViewController.swift
//  SwiftyMediator
//
//  Created by shayuan on 01/18/2019.
//  Copyright (c) 2019 shayuan. All rights reserved.
//

import UIKit
import SwiftyMediator

public enum ModuleAMediatorType: MediatorTargetType {
    case push(title: String)
    case present(color: UIColor)
}

extension ModuleAMediatorType: MediatorRoutable {
    public init?(url: URLConvertible) {

        switch url.pattern {
        case "sy://push":
            self = .push(title: url.queryParameters["title"] ?? "default")
        case "sy://present":
            self = .present(color: UIColor.red)
        default:
            return nil 
        }
    }
}

extension ModuleAMediatorType: MediatorSourceType {
    public var viewController: UIViewController? {
        switch self {
        case .push(let title):
            let vc = UIViewController()
            vc.view.backgroundColor = .green 
            vc.title = title
            return vc
            
        case .present(let color):
            let vc = PresentedViewController()
            vc.view.backgroundColor = color
            vc.title = "Presented"
            return vc
        }
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Mediator.register(ModuleAMediatorType.self)
    }

    @IBAction func push(_ sender: Any) {
        // `from` is optional
//        Mediator.push(ModuleAMediatorType.push(title: "hello world"), from: self.navigationController)
        
        Mediator.push("sy://push?title=hahaha", from: self.navigationController)
    }
    
    @IBAction func present(_ sender: Any) {
        // `from` is optional
        Mediator.present(ModuleAMediatorType.present(color: .blue), from: self)
    }
    
}

