//
//  FFPhoto+CoreDataProperties.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension FFPhoto {

    @NSManaged var remoteID: String?
    @NSManaged var title: String?
    @NSManaged var imageURL: String?

}
