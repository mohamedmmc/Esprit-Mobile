//
//  cellPU.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 22/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import UIKit

class cellPU: UITableViewCell {

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
        contentView.layer.backgroundColor = UIColor(named: "cellColor")?.cgColor

    }
    @IBOutlet weak var name: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
