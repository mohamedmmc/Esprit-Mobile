//
//  SecondTabViewController.swift
//  HamburgerMenu
//
//  Created by Prathamesh Salvi on 24/10/18.
//  Copyright © 2018 Big Rattle Technologies Private Limited. All rights reserved.
//

import UIKit
import Lottie
class CalendarView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var animationView: AnimationView!
    var tableauEvent = [Evenement]()
    var tableauEventDate = [Evenement]()
    let formaterDateString = DateFormatter()
    let formaterStringToDate = DateFormatter()
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formaterDateString.dateFormat = "yyyy-MM-dd"
        formaterStringToDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if #available(iOS 14.4, *){
            datePicker.preferredDatePickerStyle = .inline
        }
        loadArticleToTableview(tableau:self.eventCollectionView)
        checkEvent(date: Date.now)
        //let name = Notification.Name("updateTable")
        //NotificationCenter.default.addObserver(self, selector: #selector(loadArticle), name: name, object: nil)
    }
    @objc func loadArticle(){
        tableauEventDate.removeAll()
        tableauEvent.removeAll()
        loadArticleToTableview(tableau:self.eventCollectionView)
        }
    
    func loadArticleToTableview (tableau:UICollectionView){
        tableauEventDate.removeAll()
        tableauEvent.removeAll()
       EvenementService().getEvenement { succes, reponse in
           if succes {
               for article in reponse!{
                   self.tableauEvent.append(article)
                   DispatchQueue.main.async {
                       tableau.reloadData()
                    }
               }
           }else{
               self.tableauEvent.removeAll()
               self.eventCollectionView.reloadData()
           }
       }
   }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableauEventDate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell",for: indexPath)
        cell.layer.cornerRadius = 20
        let cv = cell.contentView
        let titre = cv.viewWithTag(1) as! UILabel
        let description = cv.viewWithTag(2) as! UILabel
        let dateDebut = cv.viewWithTag(3) as! UILabel
        let dateFin = cv.viewWithTag(4) as! UILabel
        let date1 = formaterStringToDate.date(from: tableauEventDate[indexPath.row].startDate)
        let date2 = formaterStringToDate.date(from: tableauEventDate[indexPath.row].endDate)
        titre.text = tableauEventDate[indexPath.row].title
        description.text = tableauEventDate[indexPath.row].description
        dateDebut.text = "Debut : " + formaterDateString.string(from: date1!)
        dateFin.text = "Fin : " + formaterDateString.string(from: date2!)
        return cell
    }
    
    @IBAction func hamburgerBtnAction(_ sender: UIBarButtonItem) {
        HamburgerMenu().triggerSideMenu()
    }
    
    func checkEvent(date: Date) {
        tableauEventDate.removeAll()
        
        for event in tableauEvent {
            let dateDebut = formaterStringToDate.date(from: event.startDate)
            let dateEnd = formaterStringToDate.date(from: event.endDate)
            let pickedDate = date
            if (pickedDate > dateDebut!){
                if (pickedDate < dateEnd!) {
                    tableauEventDate.append(event)
                }
                else if (NSCalendar.current.isDate(pickedDate, inSameDayAs: dateEnd!)){
                    tableauEventDate.append(event)
                }
            }else if (NSCalendar.current.isDate(pickedDate, inSameDayAs: dateDebut!)){
                tableauEventDate.append(event)
            }
        }
        if tableauEventDate.count > 0 {
            eventCollectionView.reloadData()
            animationView.isHidden = true
            eventCollectionView.isHidden = false
        }else{
            animationView.isHidden = false
            eventCollectionView.isHidden = true
            animationView.contentMode = .scaleAspectFit
            animationView.animationSpeed = 0.5
            animationView.play()
            animationView.loopMode = .loop
        }
    }
    
    
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        checkEvent(date: sender.date)
    }
    
}
