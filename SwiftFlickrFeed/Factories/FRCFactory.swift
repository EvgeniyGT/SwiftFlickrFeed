//
//  FRCFactory.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation

import CoreData
import EasyMapping

class FRCFactory<T: EKManagedObjectModel> {
    
    // MARK: - Variables
    
    private let context: NSManagedObjectContext
    
    // MARK: - Init
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Public
    
    func productFRC(sortBy: String, ascending: Bool) -> NSFetchedResultsController {
        let sortDescriptor = NSSortDescriptor(key: sortBy, ascending: ascending)
        
        let request = NSFetchRequest(entityName: String(T))
        request.fetchBatchSize = 20
        request.sortDescriptors = [sortDescriptor]
        
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
}