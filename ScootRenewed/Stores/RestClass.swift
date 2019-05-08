//
//  RestClass.swift
//  ScootRenewed
//
//  Created by Jann Aleli Zaplan on 6/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Alamofire
import AlamofireImage




public typealias CompletionBlock = (_ result: AnyObject?, _ error: String?) -> Void


open class RestClient {
    func sendRequest(_ route:URLRequestConvertible,completionBlock:@escaping CompletionBlock){
        
        let routeRequest = try! route.asURLRequest()
        
        
        Alamofire.request(routeRequest)
            .responseJSON { response in
                
                guard response.result.isSuccess else {
                    // Request Error
                    completionBlock(nil,"Error")
                    return
                }
                
                
                guard let array = response.result.value else {
                    // Request Error
                    completionBlock(nil,"Error")
                    return
                }
                
                var finalArray = JSON(array)
                var cardArray = finalArray["cards"].array!
                print(cardArray)
                var finalImageURL: [String] = []
                for each in cardArray {
                    finalImageURL.append(each["imageUrl"].stringValue)
                }
                print(finalImageURL)
                completionBlock(finalImageURL as AnyObject, nil)
                
                
        }
        
    }
    
    func sendRequestForImage(url: String, completionBlock:@escaping CompletionBlock) {
        Alamofire.request(url).responseImage { response in
            
            
            guard response.result.isSuccess else {
                completionBlock(nil, "Error")
                return
            }
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                completionBlock(image, nil)
            }
        }
    }
    
    /*
     
     open func getWeather(completionBlock: @escaping CompletionBlock){
     NetworkManager().retrieveWeather(completionBlock: {
     data, error in
     
     if data != nil {
     
     do {
     // data we are getting from network request
     let decoder = JSONDecoder()
     let response = try decoder.decode(Weather.self, from: data! as! Data)
     self.saveUserDefaults(response: data!)
     
     
     print(response.city) //Output - EMT
     completionBlock(response as AnyObject, nil)
     } catch { print(error) }
     }else{
     completionBlock(nil,nil)
     }
     
     
     
     })
     }
     */
}
