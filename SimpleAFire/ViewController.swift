//
//  ViewController.swift
//  SimpleAFire
//
//  Created by Shubham Singh on 17/04/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        APIManager.getResource(resourceID: 1) { (res) in
//            print(res)
//        }
        
//        APIManager.getAllResources { (results) in
//            print(results, results.count)
//        }
        
        let resource = Resource(id: 435, userId: 8, title: "Demo Resource", body: "A dummy resource for Medium Post")
        
        APIManager.postResource(res: resource)
    }


}

