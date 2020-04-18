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
        
        // GET Single Resource
        APIManager.getResource(resourceID: 1) { (response) in
            print(response)
        }
        // GET All Resources
        APIManager.getAllResources { (resources) in
            print(resources, resources.count)
        }
        
        // POST a Resource
        APIManager.postResource(res: Resource(id: 435, userId: 8, title: "Demo Resource", body: "A dummy resource for Medium Post")) { (response) in
            print("API Response", response)
        }
        
        /* Calling the Generic API function - Pass the URLRequestConvertible defined and the Model
           in which we want the result of the API to be mapped.
        */
        APIManager.fetchData(urlRequest: APIManager.getResource(resourceId: 1)){ (res: Resource) in
            print("API Responce", res)
        }
    }
}






