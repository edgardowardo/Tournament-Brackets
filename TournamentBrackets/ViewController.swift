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
        TournamentEntity.commit()
        printTourneys()
    }
    
    private func printTourneys() {
        print("tourneysCount==\(TournamentEntity.MR_countOfEntities())")
        tourneyEntities = TournamentEntity.MR_findAll() as? [TournamentEntity]
        for t in tourneyEntities {
            t.name! += ",\(tourneyEntities.count)"
            let g = t.groupsRelation!.allObjects.first as! GroupEntity
            let teams = g.teamsRelation!.allObjects
            let teamsRelationCount = teams.count
            print("\(t.name!) groupCount(\(t.groupsRelation!.count)) groupName(\(g.name!)) teamCount(\(g.teamCount)) teamsRelationCount(\(teamsRelationCount))")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        printTourneys()
        TournamentEntity.create()
        TournamentEntity.commit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

