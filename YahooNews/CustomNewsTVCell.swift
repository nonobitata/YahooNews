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
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func loadItem(title: String, imgURL: String, summary: String, webURL: String,time: String) {
        
        self.titleLabel.text = title
        self.summaryLabel.text = summary
        self.webURL = webURL
        let date = time.substringWithRange(Range<String.Index>(start: time.startIndex, end: time.startIndex.advancedBy(10)))
        let hour = time.substringWithRange(Range<String.Index>(start: time.startIndex.advancedBy(11), end: time.endIndex.advancedBy(-1)))
        
        self.timeLabel.text = String(format: "\(date) at  \(hour)")
    }
}