//
//  FFFRCTableViewDataSourceFactory.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation

import UIKit
import CoreData
import EasyMapping

class FFFRCTableViewDataSourceFactory<T: EKManagedObjectModel> {
    
    // MARK: - Variables
    
    private weak var tableView: UITableView?
    private let fetchedResultsControllerFactory: FRCFactory<T>
    
    // MARK: - Init
    
    init(tableView: UITableView?, context: NSManagedObjectContext) {
        self.tableView = tableView
        self.fetchedResultsControllerFactory = FRCFactory<T>(context: context)
    }
    
    // MARK: - Public
    
    func productFRCTableViewDataSource<U: FFCellProtocol>(cellType: U.Type, sortResultsBy: String, ascending: Bool) -> FFFRCTableViewDataSource<T, U> {
        let fetchedResultsController = fetchedResultsControllerFactory.productFRC(sortResultsBy, ascending: ascending)
        return FFFRCTableViewDataSource<T, U>(tableView: tableView, fetchedResultsController: fetchedResultsController)
    }
}