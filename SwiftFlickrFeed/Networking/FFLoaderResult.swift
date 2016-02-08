//
//  FFLoaderResult.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation

enum FFLoaderError: ErrorType {
    
    case FFLoaderParsingError
    case FFLoaderAPIError(error: NSError?)
    case FFMapperContextSaveError
    
    // MARK: - Variables
    
    var resultMessage: String {
        switch self {
        case .FFLoaderParsingError:
            return NSLocalizedString("Parsing Error", comment: "")
        case .FFMapperContextSaveError:
            return NSLocalizedString("Data Save Error", comment: "")
        case .FFLoaderAPIError(let error):
            guard let apiError = error else {
                return NSLocalizedString("API Error", comment: "")
            }
            return apiError.localizedDescription
        }
    }
}