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
    @NSManaged var awayKey: String?
    @NSManaged var awayName: String?
    @NSManaged var awayScore: Int64
    @NSManaged var homeIncident: Int16
    @NSManaged var homeKey: String?
    @NSManaged var homeName: String?
    @NSManaged var homeScore: Int64
    @NSManaged var index: Int16
    @NSManaged var isBye: Bool
    @NSManaged var info: String?
    @NSManaged var round: Int16
    @NSManaged var groupRelation: GroupEntity?

}
