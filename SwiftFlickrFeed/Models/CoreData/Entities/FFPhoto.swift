//
//  FFPhoto.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation
import CoreData
import EasyMapping

class FFPhoto: EKManagedObjectModel {

    // MARK: - Mapping
    
    override class func objectMapping() -> EKManagedObjectMapping {
        return EKManagedObjectMapping(forEntityName: String(self)) { mapping in
            mapping.mapKeyPath("id", toProperty: "remoteID")
            mapping.mapKeyPath("title", toProperty: "title")
            mapping.mapKeyPath("url_q", toProperty: "imageURL")
            mapping.primaryKey = "remoteID"
        }
    }
}
