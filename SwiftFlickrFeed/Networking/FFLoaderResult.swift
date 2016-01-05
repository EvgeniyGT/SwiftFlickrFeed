//
//  FFLoaderResult.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation

enum FFLoadedResult {
    
    case FFLoadedResultOK
    case FFLoadedResultParsingError
    case FFLoadedResultContextSaveError
    case FFLoadedResultAPIError(error: NSError?)
    
    // MARK: - Variables
    
    var resultMessage: String {
        switch self {
        case .FFLoadedResultOK:
            return NSLocalizedString("Everything is OK", comment: "")
        case .FFLoadedResultParsingError:
            return NSLocalizedString("Parsing Error", comment: "")
        case .FFLoadedResultContextSaveError:
            return NSLocalizedString("Data Save Error", comment: "")
        case .FFLoadedResultAPIError(let error):
            guard let apiError = error else {
                return NSLocalizedString("API Error", comment: "")
            }
            return apiError.localizedDescription
        }
    }
}