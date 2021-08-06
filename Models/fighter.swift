//
//  fighter.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 4/14/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import Foundation
import Combine

class fighter:ObservableObject{
    @Published var name:String{
        didSet {
            UserDefaults.standard.set(name, forKey: "name")
        }
    }
    @Published var health:Int
    @Published var attack:Int
    @Published var accuracy:Int
    @Published var block:Int
    @Published var armour:Int
    @Published var money:Int
    @Published var regens:Int
    
    init(/*name:String,*/health:Int, attack:Int, accuracy:Int, block:Int, armour:Int, money:Int, regens:Int){
        //self.name = name
        self.name = UserDefaults.standard.object(forKey: "name") as? String ?? "n/a"
        self.health=health
        self.attack=attack
        self.accuracy=accuracy
        self.block=block
        self.armour=armour
        self.money = money
        self.regens = regens
    }
    
    func blockSuccesful(num:Int) -> Bool{
        if num<=self.block{
            return true
        }
        return false
    }
    func hitLanded(num:Int) -> Bool{
        if num<=self.accuracy{
            return true
        }
        return false
    }
}

