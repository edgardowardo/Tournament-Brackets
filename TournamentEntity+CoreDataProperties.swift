//
//  TournamentEntity+CoreDataProperties.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 10/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TournamentEntity {

    @NSManaged var name: String?
    @NSManaged var currentGroupRelation: GroupEntity?
    @NSManaged var currentAppRelation: AppEntity?
    @NSManaged var groupsRelation: NSSet?
    @NSManaged var appRelation: AppEntity?

}
