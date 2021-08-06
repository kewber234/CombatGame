//
//  abilities.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/25/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import Foundation
import Combine

class abilities:ObservableObject{
    @Published var piercingShotLevel:Int{
        didSet {
            UserDefaults.standard.set(piercingShotLevel, forKey: "piercingShotLevel")
        }
    }
    @Published var criticalStrikeLevel:Int{
        didSet {
            UserDefaults.standard.set(criticalStrikeLevel, forKey: "criticalStrikeLevel")
        }
    }
    @Published var healingAuraLevel:Int{
        didSet {
            UserDefaults.standard.set(healingAuraLevel, forKey: "healingAuraLevel")
        }
    }
    @Published var coinMagnetLevel:Int{
        didSet {
            UserDefaults.standard.set(coinMagnetLevel, forKey: "coinMagnetLevel")
        }
    }
    @Published var poisonDaggerLevel:Int{
        didSet {
            UserDefaults.standard.set(poisonDaggerLevel, forKey: "poisonDaggerLevel")
        }
    }
    @Published var wheelLevel:Int{
        didSet {
            UserDefaults.standard.set(wheelLevel, forKey: "wheelLevel")
        }
    }
    
    init(pierce:Int,crit:Int,heal:Int,magnet:Int,poison:Int,wheel:Int)
    {
        self.piercingShotLevel = UserDefaults.standard.object(forKey: "piercingShotLevel") as? Int ?? 0
        self.criticalStrikeLevel = UserDefaults.standard.object(forKey: "criticalStrikeLevel") as? Int ?? 0
        self.healingAuraLevel = UserDefaults.standard.object(forKey: "healingAuraLevel") as? Int ?? 0
        self.coinMagnetLevel = UserDefaults.standard.object(forKey: "coinMagnetLevel") as? Int ?? 0
        self.poisonDaggerLevel = UserDefaults.standard.object(forKey: "poisonDaggerLevel") as? Int ?? 0
        self.wheelLevel = UserDefaults.standard.object(forKey: "wheelLevel") as? Int ?? 1
    }
    //PIERCE
    func pierced()->Bool{
        let r = Int.random(in: 1...100)
        return r<=(5*piercingShotLevel)//change 5
    }
    func pierceChance(upgraded:Bool)->String{
        if upgraded{
            return String(5*(self.piercingShotLevel+1))
        }
        return String(5*(self.piercingShotLevel))
    }
    //CRIT
    func critical()->Bool{
        let r = Int.random(in: 1...100)
        return r<=(5*criticalStrikeLevel)
    }
    func criticalChance(upgraded:Bool)->String{
        if upgraded{
            return String(5*(self.criticalStrikeLevel+1))
        }
        return String(5*(self.criticalStrikeLevel))
    }
    //HEAL
    func healed(currentHealth:Int,originalHealth:Int)->Int{//change 10
        let ratio = Double(currentHealth)/Double(originalHealth)
        let realRatio = 1.0-ratio
        let c = 10.0*Double(healingAuraLevel)
        return Int(realRatio*c)
    }
    func maxHeal(upgraded:Bool)->String{
        if upgraded{
            return String(10*(self.healingAuraLevel+1))
        }
        return String(10*self.healingAuraLevel)
    }
    //MAGNET
    func magnet()->Int{
        let a = 3*coinMagnetLevel
        return Int.random(in: a/2...a)
    }
    func magnetRange(upgraded:Bool)->String{
        let a = 3*(coinMagnetLevel+1)
        let b = 3*(coinMagnetLevel)
        if upgraded{
            return "\(a/2)-\(a)"
        }
        return "\(b/2)-\(b)"
    }
    //POISON
    func poison()->Int{
        let a = 5*poisonDaggerLevel
        return Int.random(in: a/3...a)
    }
    func poisonRange(upgraded:Bool)->String{
        let a = 5*(poisonDaggerLevel+1)
        let b = 5*poisonDaggerLevel
        if upgraded{
            return "\(a/3)-\(a)"
        }
        return "\(b/3)-\(b)"
    }
    //WHEEL
    func wheelRange(upgraded:Bool)->String{
        let lowerBound1 = (wheelLevel+1)*2
        let upperBound1 = 10 + (5*(wheelLevel+1))
        let lowerBound2 = wheelLevel*2
        let upperBound2 = 10 + (5*wheelLevel)
        if upgraded{
            return "\(lowerBound1)-\(upperBound1)"
        }
        return "\(lowerBound2)-\(upperBound2)"
    }
    func wheelCoinValue()->Int{
        let lowerBound = wheelLevel*2
        let upperBound = 10 + (10*wheelLevel)
        return Int.random(in: (lowerBound)...(upperBound))
    }
    
    func healthReward()->Int{
        return wheelCoinValue()*2
    }
    func attackReward()->Int{
        return wheelCoinValue()
    }
    func accuracyReward()->Int{
        return wheelCoinValue()/3
    }
    func armourReward()->Int{
        return wheelCoinValue()
    }
    func blockReward()->Int{
        return wheelCoinValue()/5
    }
    func goldReward()->Int{
        return wheelCoinValue()
    }
}
