//
//  FFFRCTableViewDataSource.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FFFRCTableViewDataSource<T, CellType:FFCellProtocol>: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    var cellSetupHandler: ((T, CellType, NSIndexPath) -> ())?
    
    // MARK: - Variables
    
    weak var tableView: UITableView?
    let fetchedResultsController: NSFetchedResultsController
    
    // MARK: - Init
    
    init(tableView: UITableView?, fetchedResultsController: NSFetchedResultsController) {
        self.tableView = tableView
        self.fetchedResultsController = fetchedResultsController
        super.init()
        
        fetchedResultsController.delegate = self
        do {try fetchedResultsController.performFetch()}
        catch { print("FRC fetch error:\(error)")}
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections != nil ? fetchedResultsController.sections!.count : 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections[section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellType.cellReuseIdentifier())
        let model = self.fetchedResultsController.objectAtIndexPath(indexPath)
        
        if let cellSetupHandler = cellSetupHandler {
            cellSetupHandler(model as! T, cell as! CellType, indexPath)
        }
        
        return cell!
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView?.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView?.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        guard let tableView = tableView else { return }
        
        switch type {
        case .Delete : tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Insert : tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Move :
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Update : tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}