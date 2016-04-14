//
//  OneArticle.swift
//  YahooNews
//
//  Created by Trung Do on 4/13/16.
//  Copyright © 2016 TrungDo. All rights reserved.
//

import UIKit
import Foundation

class OneArticle{
    var title = String()
    var summary = String()
    var imgURL = String()
    var img = UIImage()
    var webURL = String()
    init(){
        
    }
    init(title: String, shortDescription: String, imgURL: String,webURL: String  ){
        self.title = title
        self.summary = shortDescription
        self.imgURL = imgURL
        self.webURL = webURL
    }
    
    
}