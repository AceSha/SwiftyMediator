//
//  PresentedViewController.swift
//  SwiftyMediator_Example
//
//  Created by shayuan on 2019/1/18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class PresentedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
}
