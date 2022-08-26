//
//  TeachersView.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 22/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation
import Foundation
import UIKit

class TeachersView: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate {
    
    @IBOutlet weak var stackPU: UIStackView!
    @IBOutlet weak var selectedPU: UILabel!
    @IBOutlet weak var responsiblePU: UILabel!
    @IBOutlet weak var descResponsible: UILabel!
    @IBOutlet weak var listTeachersUP: UILabel!
    var tableauTeachers = [Teacher]()
    var filtredTableauTeachers = [Teacher]()
    let searchController = UISearchController()
    @IBOutlet weak var tableViewTeachers: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTeacher",for: indexPath)
           let cv = cell.contentView
           let titre = cv.viewWithTag(5) as! UILabel
           let button = cv.viewWithTag(6) as! UILabel
   
        if(searchController.isActive)
        {
            titre.text = filtredTableauTeachers[indexPath.row].lastName.uppercased() + " " + filtredTableauTeachers[indexPath.row].firstName
            //description.text = filtredTableauDepartement[indexPath.row].description
            //insuredBy.text = filtredTableauDesk[indexPath.row].insuredBy
            
        }
        else
        {
            titre.text = tableauTeachers[indexPath.row].lastName.uppercased() + " " + tableauTeachers[indexPath.row].firstName               // description.text = tableauDesk[indexPath.row].description
            //insuredBy.text = tableauDesk[indexPath.row].insuredBy
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            if (searchController.isActive){
                    return filtredTableauTeachers.count
                }
                return tableauTeachers.count
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetailTeacher" {

            let destination = segue.destination as! TeacherDetailView
            let index = sender as! IndexPath
            destination.teacher = tableauTeachers[index.row]
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(tableauTeachers[indexPath.row])
        performSegue(withIdentifier: "segueDetailTeacher", sender: indexPath)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        selectedPU.text = UserDefaults.standard.string(forKey: "descPU")!
        responsiblePU.text = UserDefaults.standard.string(forKey: "respPU")!
        descResponsible.text = UserDefaults.standard.string(forKey: "descPU")!
        listTeachersUP.text = "Enseignants "+UserDefaults.standard.string(forKey: "descPU")!
        loadArticleToTableview(tableau:self.tableViewTeachers)
        SearchBarConfiguration().initSearchController(searchController: searchController, result: self, delegate: self, view: self)
        filtredTableauTeachers = tableauTeachers
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        //let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText)
    }
    
    func filterForSearchTextAndScopeButton(searchText: String)
    {
        filtredTableauTeachers = tableauTeachers.filter
        {
            shape in
            if(searchController.searchBar.text != "")
            {
                let searchTextMatch = (shape.lastName.lowercased().contains(searchText.lowercased())) || (shape.firstName.lowercased().contains(searchText.lowercased()))
                
                return searchTextMatch
            }
            return true
        }
        tableViewTeachers.reloadData()
    }
    
     func loadArticleToTableview (tableau:UITableView){
         TeacherService().getTeachersByPU (id: UserDefaults.standard.string(forKey: "idPU")!, callback: {succes, reponse in
            if succes {
                for desk in reponse!{
                    self.tableauTeachers.append(desk)
                    DispatchQueue.main.async {
                        self.tableViewTeachers.reloadData()
                                }
                }
            }else{
                self.tableauTeachers.removeAll()
                self.tableViewTeachers.reloadData()
            }
        })
    }

}
