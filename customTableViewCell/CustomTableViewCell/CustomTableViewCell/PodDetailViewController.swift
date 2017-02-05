//
//  PodDetailViewController.swift
//  CustomTableViewCell
//
//  Created by Sasho Hadzhiev on 2/5/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class PodDetailViewController: UIViewController {

    @IBOutlet weak var podNameLabel: UILabel!
    @IBOutlet weak var podDetailsLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func linkButtonPressed(_ sender: UIButton) {
        let url = NSURL(string: linkButton.currentTitle!)!
        UIApplication.shared.openURL(url as URL)
    }
}
