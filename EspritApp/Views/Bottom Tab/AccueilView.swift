//
//  FrontViewController.swift
//  HamburgerMenu
//
//  Created by Mohanmed Melek Chtourou on 15/08/22
//  Copyright © 2018 Big Rattle Technologies Private Limited. All rights reserved.
//

import UIKit

class PostCell : UICollectionViewCell{
    
    @IBOutlet weak var backView: UIView!
}

class AccueilView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
    
    var tableauPosts = [Post]()
    var filteredPosts = [Post]()
    let searchController = UISearchController()
    let dateFormatter = DateFormatter()
    let formaterDateString = DateFormatter()
    let formaterStringToDate = DateFormatter()
    @IBOutlet weak var tablePost: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (searchController.isActive){
            return filteredPosts.count
        }
        return tableauPosts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell",for: indexPath) as? PostCell else{
            fatalError("impossible de creer une cellule")
        }
       
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: -1, height: 1.0)
        cell.layer.shadowRadius = 2
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        let cv = cell.contentView
        let titre = cv.viewWithTag(3) as! UILabel
        let date = cv.viewWithTag(4) as! UILabel
        let like = cv.viewWithTag(5) as! UILabel
        let views = cv.viewWithTag(6) as! UILabel
        let image = cv.viewWithTag(7) as! UIImageView
        //let date1 = formaterStringToDate.date(from: tableauEventDate[indexPath.row].startDate)
        if(searchController.isActive)
        {
            titre.text = filteredPosts[indexPath.row].title
            date.text = formaterDateString.string(from: formaterStringToDate.date(from: filteredPosts[indexPath.row].createdAt)!)
            like.text = String(filteredPosts[indexPath.row].likes) + " likes"
            views.text = String(filteredPosts[indexPath.row].views) + " views"
        }
        else
        {
            titre.text = tableauPosts[indexPath.row].title
            date.text = formaterDateString.string(from: formaterStringToDate.date(from: tableauPosts[indexPath.row].createdAt)!)
            like.text = String(tableauPosts[indexPath.row].likes) + " likes"
            views.text = String(tableauPosts[indexPath.row].views) + " views"
            
        }

        image.image = UIImage(named: "espritLogo")
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController)
    {
        let searchBar = searchController.searchBar
        //let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText)
    }
    
    func filterForSearchTextAndScopeButton(searchText: String)
    {
        filteredPosts = tableauPosts.filter
        {
            shape in
            if(searchController.searchBar.text != "")
            {
                let searchTextMatch = shape.title.lowercased().contains(searchText.lowercased())
                
                return searchTextMatch
            }
            return true
        }
        tablePost.reloadData()
    }

    override func viewDidLoad() {
        SearchBarConfiguration().initSearchController(searchController: searchController, result: self, delegate: self, view: self)
        loadPostToTableview(tableau:self.tablePost)
        formaterDateString.dateFormat = "yyyy-MM-dd"
        formaterStringToDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        filteredPosts = tableauPosts
        super.viewDidLoad()
    }

    @IBAction func hamburgerBtnAction(_ sender: UIBarButtonItem) {
      HamburgerMenu().triggerSideMenu()
    }
    
    @objc func hideHamburger(){
        HamburgerMenu().closeSideMenu()
    }
    
     func loadPostToTableview (tableau:UICollectionView){
        PostService().getPosts { succes, reponse in
            if succes {
                for article in reponse!{
                    self.tableauPosts.append(article)
                    DispatchQueue.main.async {
                        tableau.reloadData()
                                }
                }
            }else{
                self.tableauPosts.removeAll()
                self.tablePost.reloadData()
            }
        }
    }
    
}
