//
//  MenuManager.swift
//  TechNewsReader
//
//  Created by The Guest Family on 1/11/17.
//  Copyright © 2017 AlphaApplications. All rights reserved.
//

import UIKit

class MenuManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let blackView = UIView()
    let menuTableView = UITableView()
    let arrayOfSources = ["techcrunch", "techradar", "recode", "ars-technica", "engadget", "the-verge"]
    var mainVC: ViewController?
    
    public func openMenu() {
    
        if let window = UIApplication.shared.keyWindow { //Creates a faded black overlay of window
            blackView.frame = window.frame
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            //Adding a gesture recognizer to back out of the blackView
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissMenu)))
            
            let height: CGFloat = 300 //height of tableview, adjust by 50 for every news outlet added, based off "BaseCell.xib"
            let y = window.frame.height - height
            
            menuTableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            window.addSubview(blackView)
            window.addSubview(menuTableView)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 1
                self.menuTableView.frame.origin.y = y
            })
        }
    }

    public func dismissMenu() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.menuTableView.frame.origin.y = window.frame.height
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = arrayOfSources[indexPath.item]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 //height of the BaseCell.xib cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = mainVC { //This method in charge of cycling through the different news outlets other than techcrunch
            vc.source = arrayOfSources[indexPath.item].lowercased()
            vc.fetchArticles(fromSource: arrayOfSources[indexPath.item].lowercased())
            dismissMenu()
        }
    }
    
    //Must implement to override the default tableview delegate/datasource in ViewController
    override init() {
        super.init()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        menuTableView.isScrollEnabled = true
        menuTableView.bounces = false
        
        menuTableView.register(BaseViewCell.classForCoder(), forCellReuseIdentifier: "cellID")
        
    }
    
    
}
