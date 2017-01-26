//
//  xibLoader.swift
//  TechNewsReader
//
//  Created by The Guest Family on 1/16/17.
//  Copyright © 2017 AlphaApplications. All rights reserved.
//

import UIKit

class xibLoader: UIView {

    
    @IBOutlet weak var view: UIView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        UINib(nibName: "FavoritesClicked", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.isHidden = false
    }
    
    
    public func overlayAppear(view: UIView) {
       
        view.center = CGPoint(x: view.center.x, y: view.center.y)
        addSubview(view)
    }

}
