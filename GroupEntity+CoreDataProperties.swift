//
//  GroupEntity+CoreDataProperties.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 08/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension GroupEntity {

    @NSManaged var isHandicap: Bool
    @NSManaged var name: String?
    @NSManaged var scheduleType: Int16
    @NSManaged var teamCount: Int16
    @NSManaged var gamesRelation: NSSet?
    @NSManaged var teamsRelation: NSSet?
    @NSManaged var tournamentRelation: TournamentEntity?

}
