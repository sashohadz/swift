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

    var inboxMessages = [LPInboxMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Leanplum.inbox().onChanged {
            self.inboxMessages = Leanplum.inbox().allMessages() as! [LPInboxMessage]
            self.tableView.reloadData()
            print("Inbox onChanged")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // not really needed - Push segue is used to present the tableViewController
        // so viewDidLoad is called every time.
        self.tableView.reloadData()
        print("view will appear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.inboxMessages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        let row = indexPath.row
        let message: LPInboxMessage = self.inboxMessages[row]
        let title = message.title()
        cell.textLabel?.text = title
        let subtitle = message.subtitle()
        cell.detailTextLabel?.text = subtitle
        print(message.messageId())
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.inboxMessages[indexPath.row].read()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            self.inboxMessages[indexPath.row].remove()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
