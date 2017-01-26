//
//  FavoritesController.swift
//  TechNewsReader
//
//  Created by The Guest Family on 1/13/17.
//  Copyright © 2017 AlphaApplications. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController, UITableViewDelegate, UITableViewDataSource { //possibly chnage later to uiviewcontroler, make sure to add badges
    
    //To hold the favorites
    var favoritesArray: [Article]?
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //For Userdefaults, saving the favorites
        favoritesArray = defaults.object(forKey: "favoritesArray") as? [Article]
        
        //Adding the title
        self.navigationItem.title = "Favorites"
        
        
    }
    

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return favoritesArray!.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavoriteCell
        
        

        //let savedFavorites = favoritesArray?[indexPath.row]
        
        //let savedTitle = savedFavorites[]
        
        cell.favTitle.text = self.favoritesArray?[indexPath.item].headline
        cell.favSubtitle.text = self.favoritesArray?[indexPath.item].desc
        cell.favAuthor.text = self.favoritesArray?[indexPath.item].author
        cell.favImage.downloadImage(from: (self.favoritesArray?[indexPath.item].imageURL!)!)

        return cell
    }
    
    func deleteFavoriteItem(index: Int) -> Void {
    
        var array = defaults.object(forKey: "favoritesArray") as? [Article]
        array?.remove(at: index)
        defaults.set(array, forKey: "favoritesArray")
    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
//        if editingStyle == UITableViewCellEditingStyle.Delete{
//            favoritesList.removeAtIndex(indexPath.row)
//            NSUserDefaults.standardUserDefaults().setObject(favoritesList, forKey: "favoritesList")
//            toDoListTable.reloadData()
//        } http://stackoverflow.com/questions/35155381/saving-and-removing-nsuserdefaults-from-one-viewcontroller-to-another-swift-2


}


















