//
//  ViewController.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 07/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

import UIKit
import MagicalRecord
import CoreData

class ViewController: UIViewController {

    var tourneyEntities : [TournamentEntity]!
    
    @IBAction func truncate(sender: AnyObject) {
        TournamentEntity.MR_truncateAll()
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        printTourneys()
    }
    
    private func printTourneys() {
        print("tourneysCount==\(TournamentEntity.MR_countOfEntities())")
        tourneyEntities = TournamentEntity.MR_findAll() as? [TournamentEntity]
        for t in tourneyEntities {
            print("\(t.name!)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        printTourneys()
        
        // Insert a record!
        let t = TournamentEntity.MR_createEntity()! as TournamentEntity
        t.name = "Tournament \(tourneyEntities.count + 1)"
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

