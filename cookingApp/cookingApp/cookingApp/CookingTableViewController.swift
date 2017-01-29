//
//  CookingTableViewController.swift
//  cookingApp
//
//  Created by Sasho Hadzhiev on 1/29/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class CookingTableViewController: UITableViewController {

    enum DataType {
        case image, name, timeToCook, recipe, isFavourite, numberOfClicks
    }
    // Sample data.
    var meals:[[DataType: Any]] = [[.image:"Tarator",
                                    .name:"Tarator",
                                    .timeToCook:10,
                                    .recipe:"300 ml water, 300 ml youghurt, 1 cucumber",
                                    .isFavourite:false,
                                    .numberOfClicks:0],
                                        [.image:"airan", .name:"Airan",
                                         .timeToCook:5, .recipe:"300 ml water, 300 ml youghurt",
                                         .isFavourite:false, .numberOfClicks:0],
                                        [.image:"chicken", .name:"Chicken",
                                         .timeToCook:60, .recipe:"500 gr sea salt, 1 chicken",
                                         .isFavourite:false, .numberOfClicks:0],
                                        [.image:"fish", .name:"Fish", .timeToCook:10,
                                         .recipe:"500 gr sea salt, 1 fish",
                                         .isFavourite:false, .numberOfClicks:0],
                                        [.image:"musaka", .name:"Musaka", .timeToCook:10,
                                         .recipe:"400 gr potatos, 400 gr kaima, salt",
                                         .isFavourite:false, .numberOfClicks:0],
                                        [.image:"shopska", .name:"Shopska", .timeToCook:10,
                                         .recipe:"300 gr cucumber,300 gr tomatoes,cheese, etc",
                                         .isFavourite:false, .numberOfClicks:0],
                                        [.image:"krem", .name:"Krem Karamel", .timeToCook:10,
                                         .recipe:"Krem - dommy recipe,ran out of ideas",
                                         .isFavourite:false, .numberOfClicks:0],
                                        [.image:"pyrjenitsa", .name:"Pyrzhenica", .timeToCook:10,
                                         .recipe:"Pyrzhenica - dommy recipe,ran out of ideas",
                                         .isFavourite:false, .numberOfClicks:0],
                                        [.image:"tikvi", .name:"Tikvichki", .timeToCook:10,
                                         .recipe:"Tikvichki - dommy recipe,ran out of ideas",
                                         .isFavourite:false, .numberOfClicks:0],
                                        [.image:"dummy", .name:"Dummy1", .timeToCook:10,
                                         .recipe:"Dummy1 recipe - ran out of ideas",
                                         .isFavourite:false, .numberOfClicks:0],
                                        [.image:"ice", .name:"Ice cream", .timeToCook:10,
                                         .recipe:"You can buy ice cream fro the shop faster.",
                                         .isFavourite:false, .numberOfClicks:0],
                                        [.image:"dummy", .name:"Dummy2", .timeToCook:10,
                                         .recipe:"Dummy2 recipe - ran out of ideas",
                                         .isFavourite:false, .numberOfClicks:0],
                                        [.image:"dummy", .name:"Dummy3", .timeToCook:10,
                                         .recipe:"Dummy3 recipe - ran out of ideas",
                                         .isFavourite:false, .numberOfClicks:0],
                                        [.image:"dummy", .name:"Dummy4", .timeToCook:10,
                                         .recipe:"Dummy4 recipe - ran out of ideas",
                                         .isFavourite:false, .numberOfClicks:0],
                                        [.image:"dummy", .name:"Dummy5", .timeToCook:10,
                                         .recipe:"Dummy5 recipe - ran out of ideas",
                                         .isFavourite:false, .numberOfClicks:0]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Wait for view to disappear to realod the data in the tableview.
    // Reload is needed to order by number of clicks.
    override func viewDidDisappear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = self.meals.count
        return numberOfRows
    }

    // Sort the array and set the images, time and text for the tableview.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        meals.sort {
            item1, item2 in
            let numberOfClicks1 = item1[.numberOfClicks] as? Int
            let numberOfClicks2 = item2[.numberOfClicks] as? Int
            return numberOfClicks1! > numberOfClicks2!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "CookingTableViewCell", for: indexPath)
        cell.textLabel?.text = meals[indexPath.row][.name] as? String
        let time = meals[indexPath.row][.timeToCook] as? Int
        cell.detailTextLabel?.text = (time?.description)! + " min"
        let imageName = meals[indexPath.row][.image] as? String
        cell.imageView?.image = UIImage(named: imageName!)
        return cell
    }

    // Increase the number of clicks for the item that was selected.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let currentClicks = meals[indexPath.row][.numberOfClicks] as? Int
        meals[indexPath.row][.numberOfClicks] = currentClicks! + 1
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Pass the data to the DetailsViewCtonroller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailViewController {
            let destination = segue.destination as! DetailViewController
            let selectedIndex = self.tableView.indexPathForSelectedRow?.row
            let time = meals[selectedIndex!][.timeToCook] as? Int
            let imageName = meals[selectedIndex!][.image] as? String
            
            destination.loadViewIfNeeded()
            destination.nameLabel.text = meals[selectedIndex!][.name] as? String
            destination.timeLabel.text = (time?.description)! + " min"
            destination.recipeLabel.text = meals[selectedIndex!][.recipe] as? String
            destination.mealImage.image = UIImage(named: imageName!)
        }
    }
}
