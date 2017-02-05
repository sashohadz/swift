//
//  PodTableViewController.swift
//  CustomTableViewCell
//
//  Created by Sasho Hadzhiev on 2/4/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit


enum podsDataType{
    case podImage, podName, podLink, podDescription, isBookmarked
}

class PodTableViewController: UITableViewController, PodsTableViewCellDelegate {

    let podsData:[[podsDataType:String]] = [
        [.podImage:"leanplum.png",
         .podName:"Leanplum",
         .podLink:"https://cocoapods.org/pods/Leanplum-iOS-SDK",
         .podDescription:"Messaging, Automation, App Editing, Personalization, A/B Testing, and Analytics",
         .isBookmarked:"false"],
        [.podImage:"dynamicButton.png",
         .podName:"DynamicButton",
         .podLink:"https://cocoapods.org/pods/DynamicButton",
         .podDescription:"Flat design button written in Swift",
         .isBookmarked:"false"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.podsData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = self.podsData[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PodTableViewCellIdentifier", for: indexPath) as! PodTableViewCell
        cell.podNameLabel.text = data[.podName]
        cell.podDetailLabel.text = data[.podDescription]
        cell.podImageView.image = UIImage(named: data[.podImage]!)
        return cell
    }
    
    
    func didPressBookmarkButton(inCell:PodTableViewCell) {
        inCell.isBookmarked = !inCell.isBookmarked
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PodDetailViewController{
            let destination = segue.destination as! PodDetailViewController
            destination.loadViewIfNeeded()
            destination.podNameLabel.text = self.podsData[self.tableView.indexPathForSelectedRow!.row][.podName]
            destination.podDetailsLabel.text = self.podsData[self.tableView.indexPathForSelectedRow!.row][.podDescription]
        }
    }
}
