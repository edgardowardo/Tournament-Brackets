//
//  ViewController.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 07/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tourneyEntities : [TournamentEntity]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tourneyEntities = TournamentEntity.MR_findAll() as? [TournamentEntity]
        
        for t in tourneyEntities {
            print("\(t.name!)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

