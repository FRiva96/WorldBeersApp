//
//  BeerTableViewCell.swift
//  WorldBeersApp
//
//  Created by Francesco Riva on 26/11/21.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    
    // Label name Table View Cell
    @IBOutlet weak var nameLabelCell: UILabel!
    
    // Label description Table View Cell
    @IBOutlet weak var descriptionLabelCell: UILabel!
    
    // Label abv Table View Cell
    @IBOutlet weak var abvLabelCell: UILabel!
    
    // Label ibu Table View Cell
    @IBOutlet weak var ibuLabelCell: UILabel!
    
    // ImageView Beer Table View Cell
    @IBOutlet weak var imageViewCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        descriptionLabelCell.numberOfLines = 0
        descriptionLabelCell.adjustsFontSizeToFitWidth = true
        descriptionLabelCell.minimumScaleFactor = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
