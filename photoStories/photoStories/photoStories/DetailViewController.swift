//
//  DetailViewController.swift
//  photoStories
//
//  Created by Sasho Hadzhiev on 2/21/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit
import Leanplum

class DetailViewController: UIViewController {

    @IBOutlet weak var largerImageView: UIImageView!    
    @IBOutlet weak var whatsNewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func whatsNewButtonPressed(_ sender: UIButton) {
        Leanplum.track("News")
    }
}
