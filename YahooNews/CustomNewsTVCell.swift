//
//  CustomNewsTVCell.swift
//  Gymmate
//
//  Created by Trung Do on 4/13/16.
//  Copyright © 2016 TrungDo. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

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
        if (imgURL != ""){
            let url = NSURL(string: imgURL )
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                dispatch_async(dispatch_get_main_queue(), {
                    self.newsImage.image = UIImage(data: data!)
                })
            }
//            let data = NSData(contentsOfURL: url!)
//            newsImage.image = UIImage(data: data!)
        }
        self.webURL = webURL
        
    }
}