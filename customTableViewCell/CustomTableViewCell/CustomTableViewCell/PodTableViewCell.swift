//
//  PodTableViewCell.swift
//  CustomTableViewCell
//
//  Created by Sasho Hadzhiev on 2/4/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class PodTableViewCell: UITableViewCell {

    @IBOutlet weak var podImageView: UIImageView!
    @IBOutlet weak var podNameLabel: UILabel!
    @IBOutlet weak var podDetailLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.podImageView.layer.cornerRadius = self.podImageView.frame.width / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func bookmarkSelected(_ sender: UIButton) {
    }
}
