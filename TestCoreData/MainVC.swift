//
//  MainVC.swift
//  TestCoreData
//
//  Created by sok channy on 12/1/16.
//  Copyright © 2016 channy-origin. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var foodTable: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var controller : NSFetchedResultsController<Food>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodTable.delegate = self
        foodTable.dataSource = self
        attempFetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections{
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodID", for: indexPath) as! FoodCell
        let food = controller.object(at: indexPath)
        cell.configuration(food: food)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections{
            return sections.count
        }
        return 0
    }
    
    func attempFetch(){
        
        let fetchRequest:NSFetchRequest<Food> = Food.fetchRequest()
        
        var sortedData:NSSortDescriptor!
        
        //fetchRequest.predicate = NSPredicate(format: "name contains[cd] %@", "a")
        
        if segment.selectedSegmentIndex == 0 {
            sortedData = NSSortDescriptor(key: "create", ascending: false)
        }
        if segment.selectedSegmentIndex == 1{
            sortedData = NSSortDescriptor(key: "price", ascending: true)
        }
        
        
        fetchRequest.sortDescriptors = [sortedData]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.controller = controller
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("***** ERROR : ****** \(error)")
        }
    }
    
    @IBAction func segmentChangedValue(_ sender: Any) {
        attempFetch()
        foodTable.reloadData()
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        foodTable.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        foodTable.endUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
        case.insert:
                foodTable.insertRows(at: [newIndexPath!], with: .fade)
        case.delete:
            if let indexPath = indexPath {
                foodTable.deleteRows(at: [indexPath], with: .fade)
            }
        case.update:
            if let indexPath = indexPath {
                //let cell = foodTable.cellForRow(at: indexPath) as! FoodCell
                print(indexPath)
            }
        
        case.move:
            if let indexPath = indexPath {
                foodTable.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                foodTable.insertRows(at: [indexPath], with: .fade)
            }
       
            break
        }
    }
    
    func generateTestData(){
        let food1 = Food(context: appContext)
        food1.name = "ABC DE"
        food1.price = 5.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects, objs.count > 0 {
            let food = objs[indexPath.row]
            performSegue(withIdentifier: "editFoodID", sender: food)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editFoodID" {
            if let destination = segue.destination as? FoodDetailVC {
                if let food = sender as? Food {
                    destination.foodToEdit = food
                }
            }
        }
    }
}

