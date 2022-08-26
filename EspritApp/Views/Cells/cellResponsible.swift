//
//  cellResponsible.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 22/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import UIKit

class cellResponsible: UITableViewCell {

    var cornerRadius: CGFloat = 20.0
    
    override func awakeFromNib() {
       super.awakeFromNib()
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 1.0)
        layer.shadowRadius = 2
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
    }
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
