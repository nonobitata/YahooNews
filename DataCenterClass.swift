//
//  DataCenterClass.swift
//  YahooNews
//
//  Created by Trung Do on 4/13/16.
//  Copyright © 2016 TrungDo. All rights reserved.
//

import Foundation

class DataCenterClass{
    var allArticleArray: Array = Array<OneArticle>()
    var uuid = String()
    
    init(){
        parseData()
        fetchAllUID()
    }
    func empty() -> Bool{
        return (allArticleArray.count == 0)
    }
    func printAll(){
        print("size: \(allArticleArray.count)")
        for article in self.allArticleArray{
            print("NAME: \(article.title) \n IMG URL: \(article.imgURL)\n\n")
        }
    }
    func reloadDatabase(){
        if (uuid != "END"){
            parseData()
        }
          
    }
    func parseData(){
        var urlString = String()
        if (uuid == ""){
            urlString = String("http://mhr.yql.yahoo.com/v1/newsfeed?format=json")
        }
        else{
            var arrayID = uuid.characters.split{$0 == ","}.map(String.init)
            for i in 0 ... arrayID.count-1{
                print("\(i) : \(arrayID[i]) \n")
            }

            var tempUUID = String()
            tempUUID += arrayID[0]
            arrayID.removeAtIndex(0)
            for i in 0...19{
                if (arrayID.count > 0) {
                    tempUUID += "," + arrayID[0]
                    print("\(i) : \(arrayID[0]) \n")
                    arrayID.removeAtIndex(0)
                }
                else {
                    break;
                }
            }
            print("BEFORE: \(self.uuid) .\n")
            uuid = ""
            if (arrayID.count > 0)
            {
                uuid += arrayID[0]
                arrayID.removeAtIndex(0)
                for id in arrayID{
                    uuid += "," + id
                }
            }
            else {
             uuid = "END"
            }
            print("AFTERWARD: \(self.uuid) .\n")

            urlString = String(format:"http://mhr.yql.yahoo.com/v1/newsitems?format=json&nocache=1&uuid=\(tempUUID)")
            
        }
        print (urlString)
        let requestURL: NSURL = NSURL(string: urlString)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            if (statusCode == 200) {
                
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    let query: NSDictionary = json["result"] as! NSDictionary
                    if let articleArray = query["items"] as? [[String: AnyObject]] {
                        for article in articleArray {
                            let newArticle = OneArticle(title: "",shortDescription: "",imgURL: "",webURL: "",time: "")
                            if let name = article["title"] as? String {
                                newArticle.title = name
                            }
                            if let summary = article["summary"] as? String {
                                newArticle.summary = summary
                                
                            }
                            if let image = article["_original_image"] as? String {
                                newArticle.imgURL = image
                                
                            }
                            if let webURL = article["link"] as? String {
                                newArticle.webURL = webURL
                                
                            }
                            if let time = article["published"] as? String{
                                newArticle.time = time
                            }
                            //newArticle.setImg()
                            self.allArticleArray.append(newArticle)
                            //print(self.allArticleArray.count)
                        }
                        //                    print(query)
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()

    }
    func fetchAllUID(){
        let urlString = String(format:"http://mhr.yql.yahoo.com/v1/newsfeed?format=json")
        print (urlString)
        let requestURL: NSURL = NSURL(string: urlString)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            if (statusCode == 200) {
                
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    let query: NSDictionary = json["result"] as! NSDictionary
                    if let articleArray = query["more_items"] as? [[String: AnyObject]] {
                        for article in articleArray {
                            if let id = article["id"] as? String {
                                if (self.uuid == "") {
                                    self.uuid += id
                                }
                                else{
                                    self.uuid += "," + id
                                }
                            }
                            
                        }
                        print(self.uuid)
                        
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()

    }
}