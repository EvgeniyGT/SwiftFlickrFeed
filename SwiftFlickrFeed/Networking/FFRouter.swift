//
//  FFRouter.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation

class FFRouter {
    class func endPoint(requestType: FFLoaderRequestType) -> String? {
        switch requestType {
        case .FFLoaderRequestTypePhoto:
            return "services/rest/?method=flickr.photos.getRecent&api_key=" + FFDefinitions.APIKey + "&per_page=30&format=json&nojsoncallback=1&extras=url_q"
        case .FFLoaderRequestTypeUnknown:
            return nil
        }
    }
}