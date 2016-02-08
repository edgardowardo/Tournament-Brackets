//
//  GameEntity+CoreDataProperties.swift
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

extension GameEntity {

    @NSManaged var awayIncident: Int16
    @NSManaged var awayScore: Int64
    @NSManaged var homeIncident: Int16
    @NSManaged var homeScore: Int64
    @NSManaged var name: String?
    @NSManaged var groupRelation: GroupEntity?

}
