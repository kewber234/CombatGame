//
//  currencies.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/15/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import Foundation
import Combine

class currencies:ObservableObject{
    @Published var treasuryLevel:Int{
        didSet {
            UserDefaults.standard.set(treasuryLevel, forKey: "treasuryLevel")
        }
    }
    @Published var coinsStored:Int
    @Published var xp:Int{
        didSet {
            UserDefaults.standard.set(xp, forKey: "xp")
        }
    }
    @Published var xpBound:Int{
        didSet {
            UserDefaults.standard.set(xpBound, forKey: "xpBound")
        }
    }
    @Published var xpLevel:Int{
        didSet {
            UserDefaults.standard.set(xpLevel, forKey: "xpLevel")
        }
    }
    @Published var gems:Int{
        didSet {
            UserDefaults.standard.set(gems, forKey: "gems")
        }
    }
    @Published var energy:Int{
        didSet {
            UserDefaults.standard.set(energy, forKey: "energy")
        }
    }
    
    init(treasuryLevel:Int, coinsStored:Int, xp:Int, xpBound: Int,xpLevel:Int ,gems:Int, energy:Int){
        //self.treasuryLevel = treasuryLevel
        self.coinsStored = coinsStored
        //self.xp = xp
        //self.xpBound = xpBound
        //self.xpLevel = xpLevel
        //self.gems = gems
        //self.energy = energy
        self.treasuryLevel = UserDefaults.standard.object(forKey: "treasuryLevel") as? Int ?? 1
        self.xp = UserDefaults.standard.object(forKey: "xp") as? Int ?? 0
        self.xpBound = UserDefaults.standard.object(forKey: "xpBound") as? Int ?? 300
        self.xpLevel = UserDefaults.standard.object(forKey: "xpLevel") as? Int ?? 1
        self.gems = UserDefaults.standard.object(forKey: "gems") as? Int ?? 0
        self.energy = UserDefaults.standard.object(forKey: "energy") as? Int ?? 20
    }
    func getTreasuryRate()->Double{
        
        let base = ((treasuryLevel*15) + 20)//change rate increase here
        let rand = Int.random(in: (base-5)...(base+5))
        let rate = Double(rand)/100.0
        return (rate+1.0)
    }
    func treasuryRange(upgraded:Bool)->String{
        let base = ((treasuryLevel*15) + 20)
        let baseU = (((treasuryLevel+1)*15) + 20)
        if upgraded{
            return "\(baseU-5)%-\(baseU+5)%"
        }
        return "\(base-5)%-\(base+5)%"
    }
}
