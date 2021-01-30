//
//  PlantTableViewCell.swift
//  WaterThePlants
//
//  Created by EKATERINA  KUKARTSEVA on 26.01.2021.
//

import UIKit

class PlantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var plantImageView: UIImageView! {
        didSet {
            plantImageView.layer.borderWidth = 7
            plantImageView.layer.borderColor = UIColor(named: "LightGreenColor")?.cgColor
        }
    }
    @IBOutlet weak var namePlantLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
