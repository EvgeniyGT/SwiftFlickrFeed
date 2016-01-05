//
//  FFRootControllerConfigurator.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation
import UIKit
import BNRCoreDataStack

class FFRootControllerConfigurator {
    
    // MARK: - Variables
    
    private weak var window: UIWindow?
    
    
    // MARK: - Init
    
    init(mainWindow: UIWindow?) {
        self.window = mainWindow
    }
    
    // MARK: - Public
    
    func configurate() {
        if let coreDataStack = self.instantiateCoreDataStack().stack {
            let listViewController = FFListViewController.controllerFromStoryboardWithName("Main") as! FFListViewController
            listViewController.coreDataStack = coreDataStack
            window?.rootViewController = listViewController
        }
    }
    
    // MARK: - Private
    
    private func instantiateCoreDataStack() -> (stack: CoreDataStack?, error: NSError?)  {
        do {
            let stack = try CoreDataStack.constructInMemoryStack(withModelName: "SwiftFlickrFeed")
            return (stack, nil)
        } catch {
            let constructError = error as NSError
            return (nil, constructError)
        }
    }
}