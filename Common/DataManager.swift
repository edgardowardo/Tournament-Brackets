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
    lazy var app : AppEntity = DataManager.sharedInstance.initialiseSetting()
    var currentTournament : TournamentEntity? {
        set {
            app.currentTournamentRelation = newValue
        }
        get {
            return app.currentTournamentRelation
        }
    }
    
    init () {
    }
    
    func initialiseSetting() -> AppEntity {
        if let setting = AppEntity.MR_findFirst() {
            return setting
        } else {
            let setting = AppEntity.MR_createEntity()
            AppEntity.commit()
            return setting!
        }
    }
    
    func newTournament() {
        DataManager.sharedInstance.currentTournament = TournamentEntity.create()
        TournamentEntity.commit()
    }
}

