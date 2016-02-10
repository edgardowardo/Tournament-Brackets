//
//  AppEntity.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 10/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

import Foundation
import CoreData


class AppEntity: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    func addTournament(tournament:TournamentEntity) {
        let list = self.mutableSetValueForKey("tournamentsRelation")
        list.addObject(tournament)
    }
    
}
