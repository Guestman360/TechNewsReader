//
//  ViewController.swift
//  TechNewsReader
//
//  Created by The Guest Family on 12/15/16.
//  Copyright © 2016 AlphaApplications. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIcon: UIActivityIndicatorView!
    
    var articles: [Article]? = []
    var source = "techcrunch"
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIcon.color = UIColor(red: 25/255.0, green: 163/255.0, blue: 255/255.0, alpha: 1.0)
        activityIcon.autoresizesSubviews = true
        
        tableView.reloadData()
        
        refreshControl.addTarget(self, action: #selector(ViewController.refreshData), for: UIControlEvents.valueChanged)
        refreshControl.backgroundColor = UIColor(red: 25/255.0, green: 163/255.0, blue: 255/255.0, alpha: 1.0)
        refreshControl.tintColor = UIColor.white
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        fetchArticles(fromSource: source)
        
        activityIcon.stopAnimating()
        activityIcon.isHidden = true
    }
    
    func refreshData() { //For the refreshControl action
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func fetchArticles(fromSource provider: String) { //All the JSON parsing is done in this one class
        
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v1/articles?source=\(provider)&sortBy=top&apiKey=6d74864190b84e68b3fba9b1ff20a50f")!)
        //Use string interpolation to allow feed to display articles other than techcrunch
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            self.articles = [Article]()
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                
                if let articlesFromJSON = json["articles"] as? [[String: AnyObject]] { //This line receives the key "article" part of JSON
                    
                    for articleFromJSON in articlesFromJSON { //Loops through the previous constant, since it is a dictionary and retrieves all the items in the "articles" dictionary
                        
                        let article = Article()
                        
                        if let title = articleFromJSON["title"] as? String, let author = articleFromJSON["author"] as? String, let desc = articleFromJSON["description"] as? String, let url = articleFromJSON["url"] as? String, let urlToImage = articleFromJSON["urlToImage"] as? String {
                            
                            article.author = author
                            article.desc = desc
                            article.headline = title
                            article.url = url
                            article.imageURL = urlToImage
                            
                        }
                        
                        self.articles?.append(article) //After parsing article, append new info into array
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error{
                print(error)
            }
            
        }
        
        task.resume()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as? WebviewViewController
        
        webVC?.url = self.articles?[indexPath.item].url
        
        self.present(webVC!, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.articles?.count ?? 0 //Essentially means if articles aren't there then just use 0, similar to if statements
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell //allows cell to access properties of ArticleCell class
        
        //populate tableview with the parsed articles and display the approprte data to the labels
        cell.title.text = self.articles?[indexPath.item].headline
        cell.desc.text = self.articles?[indexPath.item].desc
        cell.author.text = self.articles?[indexPath.item].author
        cell.articleImage.downloadImage(from: (self.articles?[indexPath.item].imageURL!)!) //Uses function from extension
        
        return cell
    }
    
    func saveArticle() {
    
        //let favCell = tableView.cellForRow(at: IndexPath.index(cell))
    }
    
    
    
    
    var menumanager = MenuManager() //Remember to create instance of class in other file
    
    @IBAction func menuPressed(_ sender: AnyObject) {
        
        menumanager.openMenu()
        menumanager.mainVC = self
    }
    
    
}


extension UIImageView { //Must create a new urlSession for the image, code is similar to JSON parsing code

    func downloadImage(from url: String) {
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
            
        }
        task.resume()
    }
}

















