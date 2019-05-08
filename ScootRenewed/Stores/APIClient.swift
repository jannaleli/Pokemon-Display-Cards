//
//  APIClient.swift
//  ScootRenewed
//
//  Created by Jann Aleli Zaplan on 6/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

open class PokemonRoute : RestClient {
    
    
    
    
    enum PokemonRoute: URLRequestConvertible {
        
        static let baseURL = Foundation.URL(string:(APIConstants.BASE_URL))!
        static let getPokemonImagesURL = Foundation.URL(string: "/cards")!
        
        
        
        // End points
        case getPokemonImages()
        
        
        
        var method: Alamofire.HTTPMethod {
            switch self {
            case .getPokemonImages(_):
                return .get
                
                
                
            }
        }
        
        
        // Configure route path and params
        var route: (path: String, parameters: [String : AnyObject]?) {
            
            switch self {
                
            case .getPokemonImages(let params): return ("\(PokemonRoute.getPokemonImagesURL)/",nil)
                
                
            }
        }
        
        var URL: Foundation.URL { return PokemonRoute.baseURL.appendingPathComponent(route.path) }
        
        
        func asURLRequest() throws -> URLRequest {
            
            var urlRequest = URLRequest(url: URL)
            urlRequest.httpMethod = method.rawValue
            
            let req = try! Alamofire.URLEncoding.default.encode(urlRequest, with: route.parameters)
            
            return req
            
        }
        
    }
    
    public func getPokemonImages(completionBlock:@escaping CompletionBlock){
        
        
        
        let route:URLRequestConvertible = PokemonRoute.getPokemonImages()
        
        sendRequest(route, completionBlock: {
            
            (response:AnyObject?,error:String?) in
            
            if (response != nil)  {
                
                completionBlock(response as AnyObject, nil)
                
            }else{
                completionBlock(nil,error)
                
            }
        } )
    }
    
    
    
    
    
}
