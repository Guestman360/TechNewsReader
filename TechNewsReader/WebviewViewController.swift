//
//  WebviewViewController.swift
//  TechNewsReader
//
//  Created by The Guest Family on 1/11/17.
//  Copyright © 2017 AlphaApplications. All rights reserved.
//

import UIKit

class WebviewViewController: UIViewController {
    
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var favBtn: UIBarButtonItem!
    
    
    var url: String?
    var isFavorite = true
    
    //var urlsArray: [String]?
    
    let defaults = UserDefaults.standard
    var webItem: [Article]? //perhaps use dict and use objectforkey to store methods and references to specific elements

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadRequest(URLRequest(url: URL(string: url!)!))
        
        //make sure to add alert after favortie button is hit

    }

    
    func theAlert() {
        
        if (isFavorite) {
        
            //Display the alert for what happens
            let alertController = UIAlertController(title: "Saved", message: "This article has been added to the favorites tab", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)

            
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
    
    func saveToFavorites() {

        if var array = defaults.object(forKey: "favoritesArray") as? [Article] {
        
            
        }
    }
    
    
    @IBAction func favoriteBtn(_ sender: UIBarButtonItem) {
        //save the article details to a "favoritesArray", present i another talbeivew
        theAlert()
        
        
    }
    
    @IBAction func dismissButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
