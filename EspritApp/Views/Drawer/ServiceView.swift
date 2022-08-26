//
//  ViewOneSideMenuViewController.swift
//  HamburgerMenu
//
//  Created by Prathamesh Salvi on 24/10/18.
//  Copyright © 2018 Big Rattle Technologies Private Limited. All rights reserved.
//

import UIKit

class ServiceView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate, UISearchResultsUpdating  {
    
    var tableauDesk = [FromDesk]()
    var filtredTableauDesk = [FromDesk]()
    let searchController = UISearchController()
    @IBOutlet weak var collectionViewDesk: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBarConfiguration().initSearchController(searchController: searchController, result: self, delegate: self, view: self)
        loadServiceToTableview(tableau:self.collectionViewDesk)
        filtredTableauDesk = tableauDesk
        super.viewDidLoad()
    }
    
    @IBAction func backBarBtnAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (searchController.isActive){
            return filtredTableauDesk.count
        }
        return tableauDesk.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellDesk",for: indexPath)
        let cv = cell.contentView
        cv.layer.cornerRadius = 20
        cv.layer.masksToBounds = true
        cv.layer.cornerRadius = 20
        cell.layer.masksToBounds = false
        cell.layer.shadowRadius = 8.0
        cell.layer.shadowOpacity = 0.10
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)

        let titre = cv.viewWithTag(1) as! UILabel
        let description = cv.viewWithTag(2) as! UILabel
        let button = cv.viewWithTag(3) as! UIButton
        
        if(searchController.isActive)
        {
            titre.text = filtredTableauDesk[indexPath.row].label
            description.text = filtredTableauDesk[indexPath.row].description
            //insuredBy.text = filtredTableauDesk[indexPath.row].insuredBy
        }
        else
        {
            titre.text = tableauDesk[indexPath.row].label
            description.text = tableauDesk[indexPath.row].description
            //insuredBy.text = tableauDesk[indexPath.row].insuredBy
            
        }
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        //let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText)
    }
    
    func filterForSearchTextAndScopeButton(searchText: String)
    {
        filtredTableauDesk = tableauDesk.filter
        {
            shape in
            if(searchController.searchBar.text != "")
            {
                let searchTextMatch = shape.label.lowercased().contains(searchText.lowercased())
                
                return searchTextMatch
            }
            return true
        }
        collectionViewDesk.reloadData()
    }
    
     func loadServiceToTableview (tableau:UICollectionView){
        DeskService().getDesks { succes, reponse in
            if succes {
                for desk in reponse!{
                    self.tableauDesk.append(desk)
                    DispatchQueue.main.async {
                        tableau.reloadData()
                                }
                }
            }else{
                self.tableauDesk.removeAll()
                self.collectionViewDesk.reloadData()
            }
        }
    }

}
