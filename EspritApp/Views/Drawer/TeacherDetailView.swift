//
//  TeacherDetail.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 24/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation
import UIKit

class TeacherDetailView: UIViewController {
    
    @IBOutlet weak var ping: UIStackView!
    @IBOutlet weak var moreStackView: UIStackView!
    @IBOutlet weak var textAreaTeacher: UITextView!
    @IBOutlet weak var imageViewTeacher: UIImageView!
    @IBOutlet weak var nomTeacher: UILabel!
    @IBOutlet weak var aProposDe: UILabel!
    var teacher : Teacher?
    @IBOutlet weak var responsibleLabel: UILabel!
    @IBOutlet weak var pingLabel: UILabel!
    @IBOutlet weak var contactButton: UIButton!

    override func viewDidLoad() {
        contactButton.layer.cornerRadius = 15
        ping.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(placeStackviewClicked)))
        moreStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moreStackviewClicked)))
        nomTeacher.text = teacher!.firstName + " " + teacher!.lastName
        responsibleLabel.text = teacher!.responsibleOf
        pingLabel.text = teacher!.pedagogicalUnit.office.label
        aProposDe.text = "A propos de "+teacher!.firstName + " " + teacher!.lastName
        super.viewDidLoad()
    }
    
    @objc func placeStackviewClicked() {
         print("place")
    }
    
    @objc func moreStackviewClicked() {
         print("more")
    }
    
    
    @IBAction func contactClick(_ sender: Any) {
    }
}
