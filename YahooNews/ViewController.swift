//
//  ViewController.swift
//  YahooNews
//
//  Created by Trung Do on 4/13/16.
//  Copyright © 2016 TrungDo. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var newsTableView: UITableView!
    let data = DataCenterClass()

    override func viewDidLoad() {
        super.viewDidLoad()

        let seconds = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.newsTableView.reloadData()
        })
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (data.empty()) {
            return 0;
        } else {
            return data.allArticleArray.count;
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        
        let cell = self.newsTableView.dequeueReusableCellWithIdentifier("customCell") as! CustomNewsTVCell
      
        let anArticle:OneArticle =  data.allArticleArray[indexPath.row]
        let url = NSURL(string: anArticle.imgURL )
        cell.newsImage.sd_setImageWithURL(url)
        cell.loadItem(anArticle.title, imgURL: anArticle.imgURL, summary: anArticle.summary,webURL: anArticle.webURL,time: anArticle.time)
        
        //reach to the end of the UI Table View
        if (indexPath.row == data.allArticleArray.count-1 ){
            self.reloadData()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let newsVC = self.storyboard?.instantiateViewControllerWithIdentifier("NewsContentVC") as? NewsContentWebViewController
        newsVC?.webURL = data.allArticleArray[indexPath.row].webURL
        self.navigationController?.pushViewController(newsVC!, animated: true)
    }
    func reloadData(){
        self.data.reloadDatabase()
        let seconds = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            self.newsTableView.reloadData()
            for i in 0...self.data.allArticleArray.count-1{
                print ("\(i) : \(self.data.allArticleArray[i].imgURL)")
            }
            
        })
    }

}

