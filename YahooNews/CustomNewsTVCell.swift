//
//  CustomNewsTVCell.swift
//  Gymmate
//
//  Created by Trung Do on 4/13/16.
//  Copyright © 2016 TrungDo. All rights reserved.
//

import Foundation
import UIKit

class CustomNewsTVCell: UITableViewCell{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    var webURL = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func loadItem(title: String, imgURL: String, summary: String, webURL: String) {
        
        self.titleLabel.text = title
        self.summaryLabel.text = summary
        self.webURL = webURL
        
    }
}