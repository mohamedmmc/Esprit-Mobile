//
//  DepartementView.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 21/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation
import UIKit

class DepartementView: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate {
    
    @IBOutlet weak var departementTableView: UITableView!
    var tableauDepartement = [Departement]()
    var filtredTableauDepartement = [Departement]()
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDepartementToTableview(tableau:self.departementTableView)
        SearchBarConfiguration().initSearchController(searchController: searchController, result: self, delegate: self, view: self)
        filtredTableauDepartement = tableauDepartement
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive){
            return filtredTableauDepartement.count
        }
        return tableauDepartement.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDepartement",for: indexPath)
        let cv = cell.contentView
        let titre = cv.viewWithTag(1) as! UILabel
        let button = cv.viewWithTag(2) as! UIButton
        
        if(searchController.isActive)
        {
            titre.text = filtredTableauDepartement[indexPath.row].label
            //description.text = filtredTableauDepartement[indexPath.row].description
            //insuredBy.text = filtredTableauDesk[indexPath.row].insuredBy
        }
        else
        {
            titre.text = tableauDepartement[indexPath.row].label
           // description.text = tableauDesk[indexPath.row].description
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
        filtredTableauDepartement = tableauDepartement.filter
        {
            shape in
            if(searchController.searchBar.text != "")
            {
                let searchTextMatch = shape.label.lowercased().contains(searchText.lowercased())
                
                return searchTextMatch
            }
            return true
        }
        departementTableView.reloadData()
    }
    
     func loadDepartementToTableview (tableau:UITableView){
        DepartementService().getDepartements { succes, reponse in
            if succes {
                for desk in reponse!{
                    self.tableauDepartement.append(desk)
                    DispatchQueue.main.async {
                        tableau.reloadData()
                                }
                }
            }else{
                self.tableauDepartement.removeAll()
                self.departementTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive {
            UserDefaults.standard.setValue(filtredTableauDepartement[indexPath.row].id, forKey: "idDep")
            UserDefaults.standard.setValue(filtredTableauDepartement[indexPath.row].responsible, forKey: "respDep")
            UserDefaults.standard.setValue(filtredTableauDepartement[indexPath.row].label, forKey: "labelDep")
            UserDefaults.standard.setValue(filtredTableauDepartement[indexPath.row].contact, forKey: "descDep")
        }else{
            UserDefaults.standard.setValue(tableauDepartement[indexPath.row].id, forKey: "idDep")
            UserDefaults.standard.setValue(tableauDepartement[indexPath.row].responsible, forKey: "respDep")
            UserDefaults.standard.setValue(tableauDepartement[indexPath.row].label, forKey: "labelDep")
            UserDefaults.standard.setValue(tableauDepartement[indexPath.row].contact, forKey: "descDep")

        }
            self.performSegue(withIdentifier: "seguePu", sender: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
