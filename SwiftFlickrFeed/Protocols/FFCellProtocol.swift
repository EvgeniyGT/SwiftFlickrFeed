//
//  FFCellProtocol.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation
import UIKit

protocol FFCellProtocol: class  {
    static func cellReuseIdentifier() ->  String
}

extension FFCellProtocol {
    static func cellReuseIdentifier() ->  String {
        return String(self)
    }
}