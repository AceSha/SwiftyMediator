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
    
    private var mediator: SwiftyMediator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mediator = SwiftyMediator()
    }

    @IBAction func push(_ sender: Any) {
        // `from` is optional
        mediator.push(ModuleAMediatorType.push(title: "hello world"), from: self.navigationController)
    }
    
    @IBAction func present(_ sender: Any) {
        // `from` is optional
        mediator.present(ModuleAMediatorType.present(color: .blue), from: self)
    }
    
}

