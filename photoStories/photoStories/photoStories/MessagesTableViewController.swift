//
//  MessagesTableViewController.swift
//  photoStories
//
//  Created by Sasho Hadzhiev on 3/17/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit
import Leanplum

class MessagesTableViewController: UITableViewController {

    var newsfeedMessages = [LPNewsfeedMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Leanplum.newsfeed().onChanged() {
            self.newsfeedMessages = Leanplum.newsfeed().allMessages() as! [LPNewsfeedMessage]
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsfeedMessages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        let row = indexPath.row
        let message: LPNewsfeedMessage = self.newsfeedMessages[row]
        let title = message.title()
        cell.textLabel?.text = title
        let subtitle = message.subtitle()
        cell.detailTextLabel?.text = subtitle
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.newsfeedMessages[indexPath.row].read()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            self.newsfeedMessages[indexPath.row].remove()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
