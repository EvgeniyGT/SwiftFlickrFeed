//
//  FFListLoader.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation
import EasyMapping

class FFListLoader<T:EKManagedObjectModel> {
    
    typealias ListLoaderCompletionHandler = ((result: FFLoadedResult) -> ())
    
    // MARK: - Variables
    
    private var mapper: FFListRequestResponseMapper<T>
    private let requestManager: FFRequestManager
    
    // MARK: - Init
    
    init(requestManager: FFRequestManager, mapper: FFListRequestResponseMapper<T>) {
        self.mapper = mapper
        self.requestManager = requestManager
    }
    
    // MARK: - Public
    
    func loadList(apiPath: String, completionHandler: ListLoaderCompletionHandler?) {
        self.requestManager.getRequest(WithEndPoint: apiPath, parameters: nil) { (response) -> () in
            
            guard response.result.isSuccess else {
                completionHandler?(result: FFLoadedResult.FFLoadedResultAPIError(error: response.result.error))
                return
            }
            
            guard let resultDict = response.result.value as? Dictionary<String, AnyObject> else {
                completionHandler?(result: FFLoadedResult.FFLoadedResultParsingError)
                return
            }
            
            guard let resultArray = resultDict[self.mapper.primaryKey]?[self.mapper.secondaryKey] as? [AnyObject] else {
                completionHandler?(result: FFLoadedResult.FFLoadedResultParsingError)
                return
            }
            
            self.mapper.mapObjects(resultArray, completion: { mappingError in
                dispatch_async(dispatch_get_main_queue()) {
                    guard (mappingError == nil) else {
                        completionHandler?(result: FFLoadedResult.FFLoadedResultContextSaveError)
                        return
                    }
                    completionHandler?(result: FFLoadedResult.FFLoadedResultOK)
                }
            })
        }
    }
}