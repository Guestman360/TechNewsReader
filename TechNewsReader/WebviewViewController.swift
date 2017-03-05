//
//  WebviewViewController.swift
//  TechNewsReader
//
//  Created by The Guest Family on 1/11/17.
//  Copyright © 2017 AlphaApplications. All rights reserved.
//

import UIKit
import CoreData

class WebviewViewController: UIViewController {
    
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var favBtn: UIBarButtonItem!
    
    
    var url: String?
    var isFavorite = true
    var FavContoller = FavoritesController()

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(URLRequest(url: URL(string: url!)!))

    }
    //function that sets up the appdelegate
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveArticle() {
        if (isFavorite) {
            //Display the alert for what happens
            let alertController = UIAlertController(title: "Saved", message: "This article has been added to the favorites tab", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            //save the article here when button pressed - Core Data
            

            //Prepares the button for undoing if tapped again
            isFavorite = false
        } else {
            let alertController2 = UIAlertController(title: "Removed", message: "This article has been removed from the favorites tab", preferredStyle: .alert)
            let okAction2 = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController2.addAction(okAction2)
            self.present(alertController2, animated: true, completion: nil)
            
            isFavorite = true
        }
    }
    
    //maybe get rid of this
    func saveArticleCoreData(title: String, subTitle: String, articleURL: String, articleImage: Data, articleAuthor: String) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext //lets us access & interact with core data
        let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: context!)
        let fav = NSManagedObject(entity: entity!, insertInto: context)
        
        fav.setValue(title, forKey: "title")
        fav.setValue(subTitle, forKey: "subTitle")
        fav.setValue(articleURL, forKey: "articleURL")
        fav.setValue(articleImage, forKey: "articleImage")
        fav.setValue(articleAuthor, forKey: "articleAuthor")
        
        do {
            try context?.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error) \(error.localizedDescription)")
        }
        
    }

    @IBAction func favoriteBtn(_ sender: UIBarButtonItem) {
        //save the article details to a "favoritesArray", present i another talbeivew
        saveArticle()
    }
    
    @IBAction func dismissButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
