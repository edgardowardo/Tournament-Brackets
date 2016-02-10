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
    lazy var setting : SettingEntity = DataManager.sharedInstance.initialiseSetting()
    var currentTournament : TournamentEntity? {
        set {
            setting.currentTournamentRelation = newValue
        }
        get {
            return setting.currentTournamentRelation
        }
    }
    
    init () {
    }
    
    func initialiseSetting() -> SettingEntity {
        if let setting = SettingEntity.MR_findFirst() {
            return setting
        } else {
            let setting = SettingEntity.MR_createEntity()
            SettingEntity.commit()
            return setting!
        }
    }
    
    func newTournament() {
        DataManager.sharedInstance.currentTournament = TournamentEntity.create()
        TournamentEntity.commit()
    }
}

