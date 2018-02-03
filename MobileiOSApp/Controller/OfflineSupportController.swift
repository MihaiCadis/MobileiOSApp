//
//  OfflineSupportController.swift
//  MobileiOSApp
//
//  Created by Cadis Mihai on 01/02/2018.
//  Copyright © 2018 Cadis Mihai. All rights reserved.
//

import UIKit
import CoreData

class OfflineSupportController: UITableViewController {
    
    
    var people: [NSManagedObject] = []
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        cell.textLabel?.text = person.value(forKeyPath: "name") as? String
        cell.detailTextLabel?.text = person.value(forKeyPath: "email") as? String
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "People")
        
        do {
            people = try managedContext.fetch(fetchRequest)
        }  catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

}
