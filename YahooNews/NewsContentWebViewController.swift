//
//  NewsContentWebViewController.swift
//  YahooNews
//
//  Created by Trung Do on 4/14/16.
//  Copyright © 2016 TrungDo. All rights reserved.
//

import Foundation
import UIKit

class NewsContentWebViewController: UIViewController{
    
    @IBOutlet weak var webContentView: UIWebView!
    var webURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL (string: self.webURL);
        let requestObj = NSURLRequest(URL: url!);
        self.webContentView.loadRequest(requestObj);
    }
}