//
//  ListTableViewCell.swift
//  beers
//
//  Created by Jihoi Kang on 2021/06/09.
//

import UIKit
import SDWebImage

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(beer: Beer) {
        if let url = URL(string: beer.imageUrl) {
            thumbImageView.sd_setImage(with: url, completed: nil)
        }
        
        nameLabel.text = beer.name
        descriptionLabel.text = beer.description
    }

}
