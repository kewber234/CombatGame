//
//  extras.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 6/1/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import Foundation
import Combine

class extras:ObservableObject{
    @Published var baselines:[Int]{
        didSet {
            UserDefaults.standard.set(baselines, forKey: "baselines")
        }
    }
    @Published var highScores:[Int]{
        didSet {
            UserDefaults.standard.set(highScores, forKey: "highScores")
        }
    }
    @Published var time:Date{
        didSet {
            UserDefaults.standard.set(time, forKey: "time")
        }
    }
    @Published var minutes:Int{
        didSet {
            UserDefaults.standard.set(minutes, forKey: "minutes")
        }
    }
    @Published var seconds1:Int{
        didSet {
            UserDefaults.standard.set(seconds1, forKey: "seconds1")
        }
    }
    @Published var seconds2:Int{
        didSet {
            UserDefaults.standard.set(seconds2, forKey: "seconds2")
        }
    }
    init(){
        self.baselines = UserDefaults.standard.object(forKey: "baselines") as? [Int] ?? [10,30,25,4,10]
        self.highScores = UserDefaults.standard.object(forKey: "highScores") as? [Int] ?? [0,0,0,0,0,0]
        self.time = UserDefaults.standard.object(forKey: "time") as? Date ?? Date()
        self.minutes = UserDefaults.standard.object(forKey: "minutes") as? Int ?? 5
        self.seconds1 = UserDefaults.standard.object(forKey: "seconds1") as? Int ?? 0
        self.seconds2 = UserDefaults.standard.object(forKey: "seconds2") as? Int ?? 0
    }
}
