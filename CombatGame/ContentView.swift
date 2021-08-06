//
//  ContentView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 4/14/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI
import AVKit
import Combine

struct ContentView: View {
    @State private var musicOn = true
    @State private var level = 2
    
    @State private var showingMenu = true
    @State private var showingForm = true
    @State private var showingStats = true
    @State private var showingMain = true
    @State private var showingMain2 = true
    
    @State private var secondsPassed = 0.0
    
    @ObservedObject var extraVariables = extras()
    @ObservedObject var main = fighter(health: 0, attack: 0, accuracy: 0, block: 0, armour: 0, money: 0, regens: 0)//SAVE only name
    @ObservedObject var mainCurrencies = currencies(treasuryLevel: 1, coinsStored: 0, xp: 0, xpBound: 100,xpLevel: 1,gems: 200, energy: 100)//SAVE
    @ObservedObject var mainAbilities = abilities(pierce: 0, crit: 0, heal: 0, magnet: 0, poison: 0, wheel: 1)//SAVE
    //let timer = Timer.publish(every: 300, on: .main, in: .common).autoconnect()
    let timer2 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
            VStack{
                /*if self.showingIntro{
                    IntroView(showing: $showingIntro)
                }*/
                if showingForm && self.main.name == "n/a"{
                    FormView(main: main, showing: $showingForm)
                }
                else if showingMenu{
                    MenuView(main: main, mainCurrencies: mainCurrencies,mainAbilities:mainAbilities,extraVariables: self.extraVariables ,showing: $showingMenu, level: $level,musicOn:$musicOn).onAppear{
                        if self.musicOn{
                            Sounds.playDojo()
                        }
                    }
                }
                else if showingStats{
                    StatView(level: level, main: main,extraVariables: self.extraVariables,showing: $showingStats)
                }
                else if showingMain2{
                    MainView(main: main, mainCurrencies: mainCurrencies,mainAbilities: mainAbilities,extraVariables: self.extraVariables,showing: $showingMain.didSet(execute: { _ in
                            self.showingMenu = true
                            self.showingStats = true
                            
                    }),level: level,musicOn: musicOn)
                }
                
            }.onAppear{
                //self.mainCurrencies.gems = 200//getrid of
                self.mainCurrencies.energy = 20//get rid of
                //self.extraVariables.highScores = [0,0,0,0,0,0]
                self.secondsPassed = Date().timeIntervalSince(self.extraVariables.time)
                if self.secondsPassed >= 1{
                    for _ in 1...Int(self.secondsPassed){
                        self.incrementTime()
                    }
                }
            }.onReceive(self.timer2){time in
                //if self.mainCurrencies.energy != 20{
                    //self.mainCurrencies.energy += 1
                //}
                self.extraVariables.time = time
                if self.mainCurrencies.energy < 20{
                    self.incrementTime()
                }
            }
    }
    func incrementTime(){
        if extraVariables.minutes == 0 && extraVariables.seconds1 == 0 && extraVariables.seconds2 == 0{
            if self.mainCurrencies.energy < 20{
                self.mainCurrencies.energy += 1
            }
            extraVariables.minutes = 5
        }
        else if extraVariables.seconds1 == 0 && extraVariables.seconds2 == 0{
            extraVariables.minutes -= 1
            extraVariables.seconds1 = 5
            extraVariables.seconds2 = 9
        }
        else if extraVariables.seconds2 == 0{
            extraVariables.seconds1 -= 1
            extraVariables.seconds2 = 9
        }
        else{
            extraVariables.seconds2 -= 1
        }
    }
}
extension Binding {

    func didSet(execute: @escaping (Value) ->Void) -> Binding {
        return Binding(
            get: {
                return self.wrappedValue
            },
            set: {
                execute($0)
                self.wrappedValue = $0
            }
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(main: fighter(health: 0, attack: 0, accuracy: 0, block: 0, armour: 0, money: 0, regens: 0))
    }
}
