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

class ViewController: UIViewController, UITextFieldDelegate {

//    var tourneyEntities : [TournamentEntity]!
    @IBOutlet weak var textfieldIndex: UITextField!
    
    @IBAction func truncate(sender: AnyObject) {
        TournamentEntity.MR_truncateAll()
        TournamentEntity.commit()
        print("Tournament truncated")
    }
    
    @IBAction func newTournament(sender: AnyObject) {
        DataManager.sharedInstance.newTournament()
        print("Added new tournament")
    }
    
    @IBAction func printTournaments(sender: AnyObject) {
        print("-------------")
        if let tournaments = DataManager.sharedInstance.tournaments {
            print("Count of Tournaments(\(tournaments.count))")
            for t in tournaments {
                print("\(t.name!)")
            }
        }
    }
        
    func textFieldDidEndEditing(textField: UITextField) {
        if let text = textfieldIndex.text, index = Int(text), tournaments = DataManager.sharedInstance.tournaments where index < tournaments.count {
            DataManager.sharedInstance.currentTournament = tournaments[index]
            print("Current set to (\(index)) == \(tournaments[index].name!)")
        }
    }
    
    @IBAction func didEndEditing(sender: AnyObject) {
        
    }
    
    @IBAction func printCurrent(sender: AnyObject) {
        print("-------------")
        if let t = DataManager.sharedInstance.currentTournament {
            print("CurrentTournament == \(t.name!)")
        }
        textfieldIndex.resignFirstResponder()
    }
    
    @IBAction func generateSchedule(sender: AnyObject) {
        if let t = DataManager.sharedInstance.currentTournament, g = t.currentGroupRelation {
            g.createGames()
            print("Games generated")
        }
    }
    
//    private func printTourneys() {
//        print("-------------")
//        print("tourneysCount==\(TournamentEntity.MR_countOfEntities())")
//        tourneyEntities = TournamentEntity.MR_findAll() as? [TournamentEntity]
//        for t in tourneyEntities {
//            t.name! += ",\(tourneyEntities.count)"
//            let g = t.groupsRelation!.allObjects.first as! GroupEntity
//            let teams = g.teamsRelation!.allObjects
//            let teamsRelationCount = teams.count
//            let games = g.gamesRelation!.allObjects
//            print("\(t.name!) groupCount(\(t.groupsRelation!.count)) groupName(\(g.name!)) teamsRelationCount(\(teamsRelationCount)) gamesRelationCount=\(games.count)")
//            g.createGames()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.textfieldIndex.delegate = self
        
//        printTourneys()
//        TournamentEntity.create()
//        TournamentEntity.commit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}