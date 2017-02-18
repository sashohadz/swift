//
//  LogsTableViewController.swift
//  examPrep
//
//  Created by Sasho Hadzhiev on 2/16/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class LogsTableViewController: UITableViewController {

    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    var items:[String]! = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DBCommunication.instance.getAllInfo()
        
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
        return self.items.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogItemTableViewController") as! LogItemTableViewController
        detailViewController.itemId = self.items[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogCellIdentifier", for: indexPath) as! LogsTableViewCell

        cell.setupCell(withInfo: self.items[indexPath.row])
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func loadData(){
        self.items = DBCommunication.instance.allDataItems.sorted()
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(false, forKey: UserDefaultKeys.autoLoginEnabled.rawValue)
        self.modalTransitionStyle = .crossDissolve
        self.present(UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()!, animated: true, completion: nil)
        
    }
    
    

}
