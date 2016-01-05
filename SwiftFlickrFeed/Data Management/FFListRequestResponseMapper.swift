//
//  FFListRequestResponseMapper.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation
import CoreData
import EasyMapping

class FFListRequestResponseMapper<T: EKManagedObjectModel> {
    
    // MARK: - Variables
    
    private let context: NSManagedObjectContext
    private(set) var primaryKey: String
    private(set) var secondaryKey: String
    
    // MARK: - Init
    
    init(context: NSManagedObjectContext, primaryKey: String, secondaryKey: String) {
        self.context = context
        self.primaryKey = primaryKey
        self.secondaryKey = secondaryKey
    }
    
    // MARK: - Public
    
    func mapObjects(objects: [AnyObject], completion: ((mappingError: NSError?) -> ())?) {
        context.performBlock {
            let mapping = T.objectMapping()
            let fetchRequest = NSFetchRequest(entityName: mapping.entityName)
            
            EKManagedObjectMapper.syncArrayOfObjectsFromExternalRepresentation(
                objects,
                withMapping: mapping,
                fetchRequest: fetchRequest,
                inManagedObjectContext: self.context
            )
            
            do {
                try self.context.save()
                completion?(mappingError: nil)
            }
            catch {
                let saveError = error as NSError
                completion?(mappingError: saveError)
            }
        }
    }
}