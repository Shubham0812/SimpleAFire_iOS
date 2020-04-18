//
//  API.swift
//  SimpleAFire
//
//  Created by Shubham Singh on 17/04/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import Foundation
import Alamofire


// model for a Resource
struct Resource: Decodable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

// creating an enum which contains the API requests and it's calling function
enum APIManager: URLRequestConvertible {
    
    static let endpoint = URL(string: "https://jsonplaceholder.typicode.com")!
    
    // creating cases for each API request
    case getResource(resourceId: Int)
    case getAllResources
    case createResource(res: Resource)
    
    // specifying the endpoints for each API
    var path: String {
        switch self {
        // when you need to pass a parameter to the endpoint
        case .getResource(let resourceId):
            return "/posts/\(resourceId)"
        case .getAllResources:
            return "/posts"
        // for this post call we do not need to add anything to the path so we use _
        case .createResource(_):
            return "/posts"
        }
    }
    
    // specifying the methods for each API
    var method: HTTPMethod {
        switch self {
        case .getResource(_):
            return .get
        case .getAllResources:
            return .get
        case .createResource(_):
            return .post
        }
    }
    
    // If the API requires body or queryString encoding, it can be specified here
    var encoding : URLEncoding {
        switch self {
        default:
            return .default
        }
    }
    
    // this function will return the request for the API call, for POST calls the body or additional headers can be added here
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: APIManager.endpoint.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        var parameters = Parameters()
        
        switch self {
        // since we only need to pass parameters for the POST call we have not specified the other cases
        case .createResource(let resource):
            parameters["userId"] = resource.userId
            parameters["title"] = resource.title
            parameters["body"] = resource.body
            
            // adding the headers for this case
            request.addValue("Content-type", forHTTPHeaderField: "application/json; charset=UTF-8")
        default:
            break
        }
        
        // encoding the request with the encoding specified above if any
        request = try encoding.encode(request, with: parameters)
        return request
    }
    
    //MARK:- functions for calling the API's
    // GET API - To get a particular resource
    static func getResource(resourceID: Int, onCompletion: @escaping (Resource) -> Void) {
        AF.request(APIManager.getResource(resourceId: resourceID)).responseJSON {(json) in
            let jsonDecoder = JSONDecoder()
            let jsonData = try! JSONSerialization.data(withJSONObject: json.value!, options: .sortedKeys)
            let resource = try! jsonDecoder.decode(Resource.self, from: jsonData)
            onCompletion(resource)
        }
    }
    
    // GET API - To get all the resources
    static func getAllResources(onCompletion: @escaping ([Resource]) -> Void) {
        AF.request(APIManager.getAllResources).responseJSON {(json) in
            let jsonDecoder = JSONDecoder()
            let jsonData = try! JSONSerialization.data(withJSONObject: json.value!, options: .sortedKeys)
            let resources = try! jsonDecoder.decode([Resource].self, from: jsonData)
            onCompletion(resources)
        }
    }
    
    // POST API - passing resource Model to the function
    static func postResource(res: Resource ) {
        AF.request(APIManager.createResource(res: res)).responseJSON {(json) in
            print("Result", json.result)
        }
    }
}
