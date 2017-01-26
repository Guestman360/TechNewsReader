//
//  FavoriteCell.swift
//  TechNewsReader
//
//  Created by The Guest Family on 1/15/17.
//  Copyright © 2017 AlphaApplications. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    
    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var favTitle: UILabel!
    @IBOutlet weak var favSubtitle: UILabel!
    @IBOutlet weak var favAuthor: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
