//
//  FFListViewController.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation

import UIKit
import BNRCoreDataStack
import Haneke

class FFListViewController: UIViewController {
    
    // MARK: - Variables
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var coreDataStack: CoreDataStack!
    private var loader: FFListLoader<FFPhoto>!
    private var dataSource: FFFRCTableViewDataSource<FFPhoto, FFPhotoTableViewCell>!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        prepareListLoader()
        prepareDataSource()
        
        loadList()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0;
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    private func prepareListLoader() {
        let requestManager = FFRequestManager(baseURL: FFDefinitions.BaseURL)
        let mapper = FFListRequestResponseMapper<FFPhoto>(
            context: coreDataStack.newBackgroundWorkerMOC(),
            primaryKey: "photos",
            secondaryKey:  "photo"
        )
        loader = FFListLoader(requestManager: requestManager, mapper: mapper)
    }
    
    private func prepareDataSource() {
        let factory = FFFRCTableViewDataSourceFactory<FFPhoto>(
            tableView: tableView,
            context: coreDataStack.mainQueueContext
        )
        dataSource = factory.productFRCTableViewDataSource(
            FFPhotoTableViewCell.self,
            sortResultsBy: "remoteID",
            ascending: true)
        dataSource.cellSetupHandler = cellSetupHandler
        
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    private func cellSetupHandler(photo:FFPhoto, cell:FFPhotoTableViewCell, indexPath:NSIndexPath) {
        cell.photoTitleLabel.text = "[No Description]"
        if let title = photo.title {
            if (title.characters.count > 0) { cell.photoTitleLabel.text = title }
        }
        if let url = photo.imageURL, imageURL = NSURL(string: url) {
            cell.photoImageView.hnk_setImageFromURL(imageURL)
        }
    }
    
    // MARK: - Load List
    
    private func loadList() {
        
        let endPoint = FFRouter.endPoint(FFRouterTypeProvider.entityEndPoint(FFPhoto))
        guard let path = endPoint else {
            NSException(name:NSInternalInconsistencyException, reason:"Incorrect End Point", userInfo:nil).raise()
            return
        }
        indicatorView.startAnimating()
        loader.loadList(path).then { loadedResult -> Void in
            
        }.always {
            self.indicatorView.stopAnimating()
        }.error { error in
            if let loaderError = error as? FFLoaderError {
                let alert = UIAlertController(title: "Error", message: loaderError.resultMessage, preferredStyle: .Alert)
                let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in}
                alert.addAction(cancelAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
}
