//
//  FavoritesController.swift
//  TechNewsReader
//
//  Created by The Guest Family on 1/13/17.
//  Copyright © 2017 AlphaApplications. All rights reserved.
//

import UIKit
import CoreData

class FavoritesController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate { //possibly chnage later to uiviewcontroler, make sure to add badges
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var favTableView: UITableView!
    
    //To hold the favorites
    var favoritesArray: [Article]?
    //Responsible for holding filtered search results for favoritesArray
    var filteredArray: [Article] = []
    
    //Saving favorites into Core Data?
    var savedArticles: [NSManagedObject] = []
    
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.favTableView.delegate = self
        self.favTableView.dataSource = self
        
        self.searchBar.delegate = self

        
        /*
         1. add core data saving to action, or button in this case
         2. have button take the current indexpath.row's Article class data and save it to Core Data
         3. That article is then put into the favoritedArray?
         
         setValue forkey name, article, title etc... of [indexpath.row]
         save data in webview vc and fetch data here?
         */
        
        
        
        
        
    }
    
    // MARK: - SearchBar methods
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
    }
    //filter by headline, which is of type string, filtered array would still have image, headline, subtitle, author
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if favoritesArray != nil {
            filteredArray = (favoritesArray?.filter({ (Article) -> Bool in
                let range = Article.headline!.range(of: searchText, options: .caseInsensitive, range: Article.headline?.range(of: searchText), locale: Locale.current)
                return (range != nil)
            }))!
        }
        if(filteredArray.count == 0) {
            isSearching = false
        } else {
            isSearching = true
        }
        favTableView.reloadData()
    }
    //http://stackoverflow.com/questions/34832019/filtering-arrays-for-use-with-uisearchbar
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredArray = testArray.filter({ (text) -> Bool in
//            let tmp: String = text
//            let range = tmp.range(of: searchText, options: .caseInsensitive, range: tmp.range(of: searchText), locale: Locale.current)
//            return (range != nil)
//        })
//        if(filteredArray.count == 0) {
//            isSearching = false
//        } else {
//            isSearching = true
//        }
//        favTableView.reloadData()
//    }
    

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        //return favoritesArray!.count
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(isSearching){
            return filteredArray.count
        } else {
            return savedArticles.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! ArticleCell
        
        if(isSearching){
            
            /*
            cell.title.text = filteredArray[indexPath.row]
            cell.desc.text = self.favoritesArray?[indexPath.item].desc
            cell.author.text = self.favoritesArray?[indexPath.item].author
            cell.articleImage.downloadImage(from: (self.favoritesArray?[indexPath.item].imageURL!)!)
             */
        } else {
            
            /*
            cell.title.text = testArray[indexPath.row]
            cell.desc.text = self.favoritesArray?[indexPath.item].desc
            cell.author.text = self.favoritesArray?[indexPath.item].author
            cell.articleImage.downloadImage(from: (self.favoritesArray?[indexPath.item].imageURL!)!)
            //add all the outlets used in the cell
            */
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let removeArticle = UITableViewRowAction(style: .destructive, title: "Remove") { (action, indexPath) in
            //Removes article from core data
        }
        
        removeArticle.backgroundColor = UIColor.red
        
        return [removeArticle]
    }
}











