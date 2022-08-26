//
//  SearchBarConfiguration.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 26/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation
import UIKit

class SearchBarConfiguration {
    
    func initSearchController(searchController :UISearchController,result :UISearchResultsUpdating,delegate:UISearchBarDelegate,view:UIViewController)
    {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = result
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        view.definesPresentationContext = true
        view.navigationItem.searchController = searchController
        view.navigationItem.hidesSearchBarWhenScrolling = false
        //searchController.searchBar.scopeButtonTitles = ["All", "Rect", "Square", "Oct", "Circle", "Triangle"]
        searchController.searchBar.delegate = delegate
    }
    
}
