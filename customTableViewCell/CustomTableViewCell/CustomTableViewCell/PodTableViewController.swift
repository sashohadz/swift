//
//  PodTableViewController.swift
//  CustomTableViewCell
//
//  Created by Sasho Hadzhiev on 2/4/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//
import UIKit

enum podsDataType{
    case podImage, podName, neededTime, podDescription, isBookmarked
}

class PodTableViewController: UITableViewController, PodsTableViewCellDelegate {

    let podsData:[[podsDataType:String]] = [
        [.podImage:"Tarator",
         .podName:"Tarator",
         .neededTime:"10 min",
         .podDescription:"300 ml water\n300 ml youghurt\n1 cucumber"],
        [.podImage:"airan",
         .podName:"Airan",
         .neededTime:"5 min",
         .podDescription:"300 ml water\n300 ml youghurt"],
        [.podImage:"fish",
         .podName:"Fish",
         .neededTime:"50 min",
         .podDescription:"500 gr sea salt\n1 fish"],
        [.podImage:"chicken",
         .podName:"Chicken",
         .neededTime:"55 min",
         .podDescription:"500 gr sea salt\n1 chicken"],
        [.podImage:"musaka",
         .podName:"Musaka",
         .neededTime:"60 min",
         .podDescription:"5400 gr potatos\n400 gr kaima, salt"],
        [.podImage:"krem",
         .podName:"krem karamel",
         .neededTime:"35 min",
         .podDescription:"Krem Karamel\nI have no idea how to cook it. :))"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.podsData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = self.podsData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PodTableViewCellIdentifier",
                                                 for: indexPath) as! PodTableViewCell
        cell.podNameLabel.text = data[.podName]
        cell.podDetailLabel.text = data[.neededTime]
        cell.podImageView.image = UIImage(named: data[.podImage]!)
        return cell
    }
    
    func didPressBookmarkButton(inCell:PodTableViewCell) {
        inCell.isBookmarked = !inCell.isBookmarked
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PodDetailViewController{
            let destination = segue.destination as! PodDetailViewController
            let imageName = self.podsData[self.tableView.indexPathForSelectedRow!.row][.podImage]
            destination.loadViewIfNeeded()
            destination.podNameLabel.text = self.podsData[self.tableView.indexPathForSelectedRow!.row][.podName]
            destination.podDetailsLabel.text = self.podsData[self.tableView.indexPathForSelectedRow!.row][.podDescription]
            destination.detailImageView.image = UIImage(named: imageName!)
            destination.timeLabel.text = self.podsData[self.tableView.indexPathForSelectedRow!.row][.neededTime]
        }
    }
}
