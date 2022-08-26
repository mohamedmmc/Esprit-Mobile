//
//  cellBuilding.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 19/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import UIKit

class cellBuilding: UITableViewCell {
    var cornerRadius: CGFloat = 20.0
    
    override func awakeFromNib() {
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        super.awakeFromNib()
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)

    }

    @IBAction func next(_ sender: Any) {
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var bloc: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
