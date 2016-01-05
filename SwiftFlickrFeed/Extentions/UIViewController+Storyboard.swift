//
//  UIViewController+Storyboard.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class func controllerFromStoryboardWithName(storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: NSBundle.mainBundle())
        let classString = NSStringFromClass(self).componentsSeparatedByString(".").last!
        return storyboard.instantiateViewControllerWithIdentifier(classString)
    }
}