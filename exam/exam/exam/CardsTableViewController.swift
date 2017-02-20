//
//  CardsTableViewController.swift
//  exam
//
//  Created by Sasho Hadzhiev on 2/18/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class CardsTableViewController: UITableViewController {
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!

    var allCardItems:[String]! = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataCommunication.instance.getAllOrdersShallowInfo()
        
        NotificationCenter.default.addObserver(forName: .DataReloaded, object: nil, queue: nil) { (notification) in
            self.loadData()
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allCardItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardsCellId", for: indexPath) as! CardTableViewCell
        cell.setupCell(withInfo: self.allCardItems[indexPath.row])
        return cell
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(false, forKey: UserDefaultKeys.autoLoginEnabled.rawValue)
        self.modalTransitionStyle = .crossDissolve
        self.present(UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()!, animated: true, completion: nil)
    }
    
    private func loadData(){
        self.allCardItems = DataCommunication.instance.allDataItems.sorted()
    }
}
