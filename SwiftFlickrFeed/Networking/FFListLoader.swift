//
//  FFListLoader.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation
import EasyMapping
import PromiseKit

class FFListLoader<T:EKManagedObjectModel> {
    
    // MARK: - Variables
    
    private var mapper: FFListRequestResponseMapper<T>
    private let requestManager: FFRequestManager
    
    // MARK: - Init
    
    init(requestManager: FFRequestManager, mapper: FFListRequestResponseMapper<T>) {
        self.mapper = mapper
        self.requestManager = requestManager
    }
    
    // MARK: - Public
    
    func loadList(apiPath: String)-> Promise<Bool> {
        return Promise { fulfill, reject in
            self.requestManager.getRequest(WithEndPoint: apiPath, parameters: nil) { (response) -> () in
                guard response.result.isSuccess else {
                    reject(FFLoaderError.FFLoaderAPIError(error: response.result.error))
                    return
                }
                guard let resultDict = response.result.value as? Dictionary<String, AnyObject> else {
                    reject(FFLoaderError.FFLoaderParsingError)
                    return
                }
                guard let resultArray = resultDict[self.mapper.primaryKey]?[self.mapper.secondaryKey] as? [AnyObject] else {
                    reject(FFLoaderError.FFLoaderParsingError)
                    return
                }
                self.mapper.mapObjects(resultArray, completion: { mappingError in
                    guard (mappingError == nil) else {
                        reject(FFLoaderError.FFMapperContextSaveError)
                        return
                    }
                    fulfill(true)
                })
            }
        }
    }
}