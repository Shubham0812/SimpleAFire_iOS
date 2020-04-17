//
//  API.swift
//  SimpleAFire
//
//  Created by Shubham Singh on 17/04/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import Foundation
import Alamofire


struct Resource: Decodable {
    let id: Int?
    let userId: Int
    let title: String
    let body: String
}


enum APIManager: URLRequestConvertible {
    
    static let endpoint = URL(string: "https://jsonplaceholder.typicode.com")!
    
    case getResource(resourceId: Int)
    case getAllResources
    case createResource(res: Resource)
    
    var path: String {
        switch self {
        case .getResource(let resourceId):
            return "/posts/\(resourceId)"
        case .getAllResources:
            return "/posts"
        case .createResource:
            return "/posts"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getResource(_):
            return .get
        case .getAllResources:
            return .get
        case .createResource:
            return .post
        }
    }
    
    var encoding : URLEncoding {
        switch self {
        default:
            return .default
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: APIManager.endpoint.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request = try encoding.encode(request, with: nil)
        return request
    }
    
    
    static func getResource(resourceID: Int, onCompletion: @escaping (Resource) -> Void) {
        AF.request(APIManager.getResource(resourceId: resourceID)).responseJSON {(json) in
            let jsonDecoder = JSONDecoder()
            let jsonData = try! JSONSerialization.data(withJSONObject: json.value!, options: .sortedKeys)
            let resource = try! jsonDecoder.decode(Resource.self, from: jsonData)
            onCompletion(resource)
        }
    }
    
    static func getAllResources(onCompletion: @escaping ([Resource]) -> Void) {
        AF.request(APIManager.getAllResources).responseJSON {(json) in
            let jsonDecoder = JSONDecoder()
            let jsonData = try! JSONSerialization.data(withJSONObject: json.value!, options: .sortedKeys)
            let resources = try! jsonDecoder.decode([Resource].self, from: jsonData)
            onCompletion(resources)
        }
    }
    
}
