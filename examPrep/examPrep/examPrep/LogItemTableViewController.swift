//
//  LogItemTableViewController.swift
//  examPrep
//
//  Created by Sasho Hadzhiev on 2/16/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class LogItemTableViewController: UITableViewController {

    var itemId: String!
    var data: [String:Any?]! = [String:Any?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DBCommunication.instance.getInfoForItem(itemId: itemId) { (receivedData) in
            guard receivedData != nil else {return}
            self.data = receivedData
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
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogItemCellId", for: indexPath)

        switch indexPath.row {
        case 0:
            cell.textLabel?.text = DataNames.deviceId.rawValue
            cell.detailTextLabel?.text = self.data[DataNames.deviceId.rawValue] as? String
        case 1:
            cell.textLabel?.text = DataNames.deviceNmae.rawValue
            cell.detailTextLabel?.text = self.data[DataNames.deviceNmae.rawValue] as? String
        case 2:
            cell.textLabel?.text = DataNames.ledWorking.rawValue
            cell.detailTextLabel?.text = String(self.data[DataNames.ledWorking.rawValue] as! Bool)
        case 3:
            cell.textLabel?.text = DataNames.displayWorking.rawValue
            cell.detailTextLabel?.text = String(self.data[DataNames.displayWorking.rawValue] as! Bool)
        case 4:
            cell.textLabel?.text = DataNames.buzzerWorking.rawValue
            cell.detailTextLabel?.text = String(self.data[DataNames.buzzerWorking.rawValue] as! Bool)
        case 5:
            cell.textLabel?.text = DataNames.buttonWorking.rawValue
            cell.detailTextLabel?.text = String(self.data[DataNames.buttonWorking.rawValue] as! Bool)
        case 6:
            cell.textLabel?.text = DataNames.value1.rawValue
            cell.detailTextLabel?.text = String(self.data[DataNames.value1.rawValue] as! Double)
        case 7:
            cell.textLabel?.text = DataNames.value2 .rawValue
            cell.detailTextLabel?.text = String(self.data[DataNames.value2.rawValue] as! Double)
        case 8:
            cell.textLabel?.text = DataNames.value3.rawValue
            cell.detailTextLabel?.text = String(self.data[DataNames.value3.rawValue] as! Double)

        default:
            break
        }
        
        return cell
    }
}
