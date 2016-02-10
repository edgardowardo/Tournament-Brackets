//
//  DataManager.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 10/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

import Foundation

class DataManager {
    
    internal struct Notification {
        internal struct Identifier {
            internal static let DidSetCurrentTournament = "NotificationIdentifierOf_DidSetCurrentTournament"
        }
    }
    
    // MARK:- Properties -
    
    static let sharedInstance = DataManager()
    lazy var appRecord : AppEntity = DataManager.sharedInstance.initialiseAppRecord()
    var currentTournament : TournamentEntity? {
        set {
            appRecord.currentTournamentRelation = newValue
            TournamentEntity.commit()
        }
        get {
            return appRecord.currentTournamentRelation
        }
    }
    var tournaments : [TournamentEntity]? {
        get {
            return appRecord.tournamentsRelation?.allObjects as? [TournamentEntity]
        }
    }
    
    init () {
    }
    
    func initialiseAppRecord() -> AppEntity {
        if let appRecord = AppEntity.MR_findFirst() {
            return appRecord
        } else {
            let appRecord = AppEntity.MR_createEntity()
            AppEntity.commit()
            return appRecord!
        }
    }
    
    func newTournament() {
        let t = TournamentEntity.create()
        appRecord.addTournament(t)
        TournamentEntity.commit()
    }
}

