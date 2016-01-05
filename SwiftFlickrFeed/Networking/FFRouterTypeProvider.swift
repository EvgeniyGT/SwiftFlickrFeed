//
//  FFRouterTypeProvider.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation
import EasyMapping

enum FFLoaderRequestType {
    case FFLoaderRequestTypeUnknown
    case FFLoaderRequestTypePhoto
}

class FFRouterTypeProvider {
    class func entityEndPoint<T: EKManagedObjectModel>(type: T.Type) -> FFLoaderRequestType! {
        switch type {
        case is FFPhoto.Type:
            return .FFLoaderRequestTypePhoto
        default:
            return .FFLoaderRequestTypeUnknown
        }
    }
}