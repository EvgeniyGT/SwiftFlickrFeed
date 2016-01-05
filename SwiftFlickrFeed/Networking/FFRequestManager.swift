//
//  FFRequestManager.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation
import Alamofire

class FFRequestManager {
    
    typealias RequestManagerCompletionHandler = ((response: Response<AnyObject, NSError>) -> ())
    
    // MARK: - Variables
    
    let baseURL: String
    
    
    // MARK: - Init
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    
    // MARK: - Public
    
    func getRequest(WithEndPoint endPoint: String, parameters: [String: AnyObject]?, completion: RequestManagerCompletionHandler?) {
        let url = baseURL.stringByAppendingString(endPoint)
        
        Alamofire.request(.GET, url, parameters: parameters)
            .responseJSON { response in
                completion?(response: response)
        }
    }
    
}