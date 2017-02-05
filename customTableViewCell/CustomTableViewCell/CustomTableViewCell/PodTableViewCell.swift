//
//  PodTableViewCell.swift
//  CustomTableViewCell
//
//  Created by Sasho Hadzhiev on 2/4/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

protocol PodsTableViewCellDelegate{
    func didPressBookmarkButton(inCell:PodTableViewCell)
}

class PodTableViewCell: UITableViewCell {

    @IBOutlet weak var podImageView: UIImageView!
    @IBOutlet weak var podNameLabel: UILabel!
    @IBOutlet weak var podDetailLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    var delegate: PodsTableViewCellDelegate?
    
    var isBookmarked:Bool! = false{
        didSet{
            switch isBookmarked{
            case true:
                self.podImageView.layer.borderWidth = 4.0
                self.podImageView.layer.borderColor = UIColor.yellow.cgColor
            case false:
                self.podImageView.layer.borderWidth = 0.0

            default:
                break
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.podImageView.layer.cornerRadius = self.podImageView.frame.width / 2
        self.bookmarkButton.isSelected = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func bookmarkSelected(_ sender: UIButton) {
        self.buttonWasPressed()
        if (!isBookmarked) {
            isBookmarked = true
            self.bookmarkButton.isSelected = true
        } else {
            isBookmarked = false
            self.bookmarkButton.isSelected = false
        }
    }
    
    func buttonWasPressed() {
        self.delegate?.didPressBookmarkButton(inCell: self)
    }
}
