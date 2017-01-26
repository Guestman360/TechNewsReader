//
//  ArticleCell.swift
//  TechNewsReader
//
//  Created by The Guest Family on 12/15/16.
//  Copyright © 2016 AlphaApplications. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    //Later used to display the data to the cells
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var author: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
