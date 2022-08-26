//
//  PedagogicalUnityView.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 21/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation
import UIKit

class PedagogicalUnityView: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate {
    
    @IBOutlet weak var departement: UILabel!
    @IBOutlet weak var PUnitTableView: UITableView!
    var tableauPUnit = [PedagogicalUnity]()
    var filtredTableauPUnit = [PedagogicalUnity]()
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        departement.text = UserDefaults.standard.string(forKey: "labelDep")!
        loadPUToTableview(tableau:self.PUnitTableView)
        SearchBarConfiguration().initSearchController(searchController: searchController, result: self, delegate: self, view: self)
        filtredTableauPUnit = tableauPUnit
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            if (searchController.isActive){
                return filtredTableauPUnit.count
            }
            return tableauPUnit.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellResponsible",for: indexPath) as! cellResponsible
           
            departement.text = UserDefaults.standard.string(forKey: "labelDep")!
            cell.name.text = UserDefaults.standard.string(forKey: "respDep")!
            cell.desc.text = UserDefaults.standard.string(forKey: "descDep")!
            return cell

        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellPu",for: indexPath) as! cellPU
            
            if(searchController.isActive)
            {
                cell.name.text = filtredTableauPUnit[indexPath.row].label
                //description.text = filtredTableauDepartement[indexPath.row].description
                //insuredBy.text = filtredTableauDesk[indexPath.row].insuredBy
                
            }
            else
            {
                cell.name.text = tableauPUnit[indexPath.row].label
               // description.text = tableauDesk[indexPath.row].description
                //insuredBy.text = tableauDesk[indexPath.row].insuredBy
                
            }
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if searchController.isActive {
                UserDefaults.standard.setValue(filtredTableauPUnit[indexPath.row].id, forKey: "idPU")
                UserDefaults.standard.setValue(filtredTableauPUnit[indexPath.row].responsible, forKey: "respPU")
                UserDefaults.standard.setValue(filtredTableauPUnit[indexPath.row].label, forKey: "labelPU")
                UserDefaults.standard.setValue(filtredTableauPUnit[indexPath.row].description, forKey: "descPU")
            }else{
                UserDefaults.standard.setValue(tableauPUnit[indexPath.row].id, forKey: "idPU")
                UserDefaults.standard.setValue(tableauPUnit[indexPath.row].responsible, forKey: "respPU")
                UserDefaults.standard.setValue(tableauPUnit[indexPath.row].label, forKey: "labelPU")
                UserDefaults.standard.setValue(tableauPUnit[indexPath.row].description, forKey: "descPU")

            }
                //self.performSegue(withIdentifier: "segueTeacher", sender: nil)
            self.performSegue(withIdentifier: "segueTest", sender: nil)
        }


    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        //let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText)
    }
    
    func filterForSearchTextAndScopeButton(searchText: String)
    {
        filtredTableauPUnit = tableauPUnit.filter
        {
            shape in
            if(searchController.searchBar.text != "")
            {
                let searchTextMatch = shape.label.lowercased().contains(searchText.lowercased())
                
                return searchTextMatch
            }
            return true
        }
        PUnitTableView.reloadData()
    }
    
     func loadPUToTableview (tableau:UITableView){
         PedagogicalUnityService().getPUbyDep (id: UserDefaults.standard.string(forKey: "idDep")!, callback: {succes, reponse in
            if succes {
                for desk in reponse!{
                    self.tableauPUnit.append(desk)
                    DispatchQueue.main.async {
                        tableau.reloadData()
                                }
                }
            }else{
                self.tableauPUnit.removeAll()
                self.PUnitTableView.reloadData()
            }
        })
    }

}
