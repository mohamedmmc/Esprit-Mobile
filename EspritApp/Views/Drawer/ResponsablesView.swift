//
//  ResponsableView.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 26/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation
import UIKit

class ResponsablesView: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate {
    
    var tableauPU = [Teacher]()
    @IBOutlet weak var PUTableView: UITableView!
    var filtredTableauPU = [Teacher]()
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        loadResponsableToTableview(tableau:self.PUTableView)
        SearchBarConfiguration().initSearchController(searchController: searchController, result: self, delegate: self, view: self)
        super.viewDidLoad()
        filtredTableauPU = tableauPU
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        //let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText)
    }
    
    func filterForSearchTextAndScopeButton(searchText: String)
    {
        filtredTableauPU = tableauPU.filter
        {
            shape in
            if(searchController.searchBar.text != "")
            {
                let searchTextMatch = (shape.firstName.lowercased().contains(searchText.lowercased())) || (shape.lastName.lowercased().contains(searchText.lowercased()))
                
                return searchTextMatch
            }
            return true
        }
        PUTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableauPU.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPU",for: indexPath)
           let cv = cell.contentView
           let titre = cv.viewWithTag(1) as! UILabel
           let description = cv.viewWithTag(2) as! UILabel
   
        if(searchController.isActive)
        {
            titre.text = filtredTableauPU[indexPath.row].firstName.uppercased() + " " + filtredTableauPU[indexPath.row].lastName.uppercased()
            description.text = filtredTableauPU[indexPath.row].description
            //insuredBy.text = filtredTableauDesk[indexPath.row].insuredBy
            
        }
        else
        {
            titre.text = tableauPU[indexPath.row].firstName.uppercased() + " " + tableauPU[indexPath.row].lastName.uppercased()
            description.text = tableauPU[indexPath.row].description
            //insuredBy.text = tableauDesk[indexPath.row].insuredBy
            
        }
        return cell
        
    }

    @IBAction func retour(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadResponsableToTableview (tableau:UITableView){
        TeacherService().getResponsiblePU (callback: {succes, reponse in
           if succes {
               for desk in reponse!{
                   self.tableauPU.append(desk)
                   DispatchQueue.main.async {
                       self.PUTableView.reloadData()
                               }
               }
           }else{
               self.tableauPU.removeAll()
               self.PUTableView.reloadData()
           }
       })
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailPUTeacher" {

            let destination = segue.destination as! TeacherDetailView
            let index = sender as! IndexPath
            destination.teacher = tableauPU[index.row]
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "detailPUTeacher", sender: indexPath)
    }
    
}
