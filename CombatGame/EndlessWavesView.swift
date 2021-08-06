//
//  EndlessWavesView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 4/27/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct EndlessWavesView: View {
    @ObservedObject var main:fighter
    @ObservedObject var mainCurrencies:currencies
    @ObservedObject var mainAbilities: abilities
    @ObservedObject var extraVariables:extras
    @Binding var show : Bool
    @Binding var tickets:Int
    //@Binding var highScores:[Int]
    @Binding var tabBarHidden:Bool
    @State private var mainHealth = 0
    @State private var oppHealth = 0
    @State private var oppIndex = 1
    @State private var currentName = ""
    @State private var textShowingH = ""
    @State private var textShowing11 = ""
    @State private var textShowing12 = ""
    @State private var textShowing13 = ""
    @State private var textShowing21 = ""
    @State private var textShowing22 = ""
    @State private var textShowingP = ""
    @State private var showingShowdown = true
    @State private var showingRewards = false
    @State private var showingDeath = false
    @State private var goldAdded = 0
    @State private var regenActivated = false
    @State private var magnetGain = 0
    @State private var previousHighScore = 0
    @State private var opponent = fighter(/*name: "Fighter 1", */health: 100, attack: 50, accuracy: 47, block: 7, armour: 35, money: 0, regens: 0)
    var musicOn:Bool
    //let timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()
    @State private var timer:Timer?
    var body: some View {
        GeometryReader{geo in
            VStack{
                if self.showingDeath{
                    EndlessDeathScreen(mainCurrencies: self.mainCurrencies,extraVariables:self.extraVariables ,numWins: self.oppIndex, showing: self.$showingDeath,previousHighScore:self.previousHighScore).onDisappear{
                        self.show = false
                    }
                }
                else if self.showingRewards{
                    RewardScreen(coinNumber: self.goldAdded,currentIndex: 0,level: 0,endless: true,coinMagnet:self.magnetGain,showingRewards: self.$showingRewards)
                }
                else if self.showingShowdown{
                    ShowdownView(oppImage: "Ninja",image: "Boy", opp: self.opponent,oppName: self.currentName ,showing: self.$showingShowdown, main: self.main)
                        .onTapGesture {
                            self.showingShowdown = false
                            self.tabBarHidden = true
                            if self.musicOn{
                                Sounds.pauseDojo()
                                Sounds.playBattle()
                            }
                            self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
                                
                                
                                if self.oppHealth <= 0 || self.mainHealth <= 0 {
                        
                                    if self.mainHealth <= 0{
                                        if self.main.regens >= 1{// activate regen
                                            Sounds.playSoundWAV(soundName: "regen")
                                            self.regenerate()
                                            self.main.regens -= 1
                                            self.mainHealth = self.main.health/2
                                            //self.timer.upstream.autoconnect()
                                        }
                                        else{// player dies
                                            self.timer?.invalidate()
                                            self.showingDeath = true
                                            self.tickets = 0
                                            self.main.money = 0
                                            self.main.regens = 0
                                            self.mainCurrencies.coinsStored = 0
                                            self.tabBarHidden = false
                                            if (self.oppIndex-1) > self.extraVariables.highScores[self.extraVariables.highScores.count-1]{
                                                self.previousHighScore = self.extraVariables.highScores[self.extraVariables.highScores.count-1]
                                                self.extraVariables.highScores[self.extraVariables.highScores.count-1] = (self.oppIndex-1)
                                            }
                                            if self.musicOn{
                                                Sounds.stopBattle()
                                                Sounds.resumeDojo()
                                            }
                                        }
                                    }
                                    else if self.oppHealth <= 0{//typical win
                                        // typical win
                                        self.timer?.invalidate()
                                        self.showingRewards = true
                                        self.clearText()
                                        self.tabBarHidden = false
                                        self.addGold()
                                        self.main.money += self.goldAdded
                                        self.main.money += self.magnetGain
                                        self.oppIndex += 1
                                        self.newOpponent()
                                        self.mainHealth = self.main.health
                                        self.oppHealth = self.opponent.health
                                        self.showingShowdown = true
                                        self.tickets += 1
                                        self.mainCurrencies.coinsStored = Int(self.getTreasuryRate()*Double(self.mainCurrencies.coinsStored))
                                        if self.musicOn{
                                            Sounds.stopBattle()
                                            Sounds.resumeDojo()
                                        }
                                        // }
                                        
                                    }
                                }
                                else{
                                    self.clearText()
                                    self.hit()
                                }
                                
                                
                            })
                    }
                }
                else{
                    ZStack{
                        LinearGradient(gradient: Gradient(colors: [.gray2,.white,.greyWhite,.white,.gray2]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                        VStack(spacing:0){
                            
                            Image("Ninja").resizable().frame(width:geo.size.width,height:geo.size.height/2).opacity(0.2).edgesIgnoringSafeArea(.all)
                            Image("Boy").resizable().frame(width:geo.size.width,height:geo.size.height/2).opacity(0.2)
                            
                        }.edgesIgnoringSafeArea(.all).offset(y:3).opacity(self.regenActivated ? 0.5 : 1.0).blur(radius: self.regenActivated ? 5 : 0)/*.onReceive(self.timer) { _ in
                            if self.oppHealth <= 0 || self.mainHealth <= 0 {
                                self.timer.upstream.connect().cancel()
                                if self.mainHealth <= 0{
                                    if self.main.regens >= 1{// activate regen
                                        Sounds.playSoundWAV(soundName: "regen")
                                        self.regenerate()
                                        self.main.regens -= 1
                                        self.mainHealth = self.main.health/2
                                        //self.timer.upstream.autoconnect()
                                    }
                                    else{// player dies
                                        self.showingDeath = true
                                        self.tickets = 0
                                        self.main.money = 0
                                        self.mainCurrencies.coinsStored = 0
                                        self.tabBarHidden = false
                                        if (self.oppIndex-1) > self.extraVariables.highScores[self.extraVariables.highScores.count-1]{
                                            self.previousHighScore = self.extraVariables.highScores[self.extraVariables.highScores.count-1]
                                            self.extraVariables.highScores[self.extraVariables.highScores.count-1] = (self.oppIndex-1)
                                        }
                                        if self.musicOn{
                                            Sounds.stopBattle()
                                            Sounds.resumeDojo()
                                        }
                                    }
                                }
                                else if self.oppHealth <= 0{//typical win
                                    // typical win
                                    self.showingRewards = true
                                    self.clearText()
                                    self.tabBarHidden = false
                                    self.addGold()
                                    self.main.money += self.goldAdded
                                    self.main.money += self.magnetGain
                                    self.oppIndex += 1
                                    self.newOpponent()
                                    self.mainHealth = self.main.health
                                    self.oppHealth = self.opponent.health
                                    self.showingShowdown = true
                                    self.tickets += 1
                                    self.mainCurrencies.coinsStored = Int(self.getTreasuryRate()*Double(self.mainCurrencies.coinsStored))
                                    if self.musicOn{
                                        Sounds.stopBattle()
                                        Sounds.resumeDojo()
                                    }
                                    // }
                                    
                                }
                            }
                            else{
                                self.clearText()
                                self.hit()
                            }
                        }*/
                        /*Rectangle().frame(maxWidth:.infinity).frame(height:geo.size.height*0.3).foregroundColor(.white)*///idea for strip of white in middle of screen
                        ZStack{
                        HealthBarView(name: self.main.name, originalHealth: self.main.health, health: self.mainHealth)
                            .position(x:geo.size.width/2,y:geo.size.height*0.9)
                        Text("\(self.textShowingH)").bold().font(.system(size: geo.size.height*0.04)).multilineTextAlignment(.leading).padding(.horizontal,5).position(x:geo.size.width/2,y:geo.size.height*0.26).foregroundColor(.blue)
                        Text("\(self.textShowing11)").bold().font(.system(size: geo.size.height*0.03)).multilineTextAlignment(.leading).padding(.horizontal,5).position(x:geo.size.width/2,y:geo.size.height*0.34)
                        Text("\(self.textShowing12)").bold().font(.system(size: geo.size.height*0.03)).multilineTextAlignment(.leading).padding(.horizontal,5).position(x:geo.size.width/2,y:geo.size.height*0.39)
                        Text("\(self.textShowing13)").bold().font(.system(size: geo.size.height*0.03)).multilineTextAlignment(.leading).padding(.horizontal,5).position(x:geo.size.width/2,y:geo.size.height*0.44)
                        Text("\(self.textShowing21)").bold().font(.system(size: geo.size.height*0.03)).multilineTextAlignment(.leading).padding(.horizontal,5).position(x:geo.size.width/2,y:geo.size.height*0.55)
                        Text("\(self.textShowing22)").bold().font(.system(size: geo.size.height*0.03)).multilineTextAlignment(.leading).padding(.horizontal,5).position(x:geo.size.width/2,y:geo.size.height*0.6)
                        Text("\(self.textShowingP)").bold().font(.system(size: geo.size.height*0.04)).multilineTextAlignment(.leading).padding(.horizontal,5).position(x:geo.size.width/2,y:geo.size.height*0.68).foregroundColor(.darkGreen)
                        HealthBarView(name: "Fighter \(self.oppIndex)", originalHealth: self.opponent.health, health: self.oppHealth).position(x:geo.size.width/2,y:geo.size.height*0.1)
                        }.blur(radius: self.regenActivated ? 5 : 0)
                        if self.regenActivated{
                            VStack(spacing:0){
                                Image("Regen").scaleEffect(0.5)
                                Text("REGEN ACTIVATED").bold().font(.system(size: 30)).offset(y:-90)
                            }
                        }
                        
                    }
                }
            }
            
        }.onAppear{
            if self.oppIndex == 1{
                self.currentName = "Fighter 1"
            }
            self.mainHealth = self.main.health
            self.oppHealth = self.opponent.health
            
        }
        //search up fight( to find the fighting algorithm
    }
    
    
    func getTreasuryRate()->Double{
        return 1.0 + (Double(self.mainCurrencies.treasuryLevel) * 0.3)//change rate increase here
    }
    func regenerate()->Void{
        //self.regenActivated = true
        Sounds.playSound(soundName: "regen")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.regenActivated = false
        }
    }
    func hit()->Void{
        let pierced = self.mainAbilities.pierced()
        let crit = self.mainAbilities.critical()
        let poison = self.mainAbilities.poison()
        var goOn1 = true
        var goOn2 = true
        var arm = 0
        var d = 0
        if self.mainAbilities.healingAuraLevel > 0{
            let h = self.mainAbilities.healed(currentHealth: mainHealth, originalHealth: self.main.health)
            mainHealth += h
            self.textShowingH = "HEALING AURA healed \(h)!"
        }
        if main.hitLanded(num: Int.random(in: 1...100))==false{
            self.textShowing11 = "\(main.name) missed!"
            goOn1 = false
        }
        else if opponent.blockSuccesful(num: Int.random(in: 1...100))==true{
            self.textShowing11 = "\(self.currentName) blocked \(main.name)!"
            goOn1 = false
        }
        if opponent.hitLanded(num: Int.random(in: 1...100))==false{
            self.textShowing21 = "\(self.currentName) missed!"
            goOn2 = false
        }
        else if main.blockSuccesful(num: Int.random(in: 1...100))==true{
            self.textShowing21 = "\(main.name) blocked \(self.currentName)!"
            goOn2 = false
        }
        if goOn2==true{
            d = Int.random(in: opponent.attack/3...opponent.attack)
            arm = Int.random(in: /*main.armour/3*/1...main.armour)
            if arm == 0{
                self.textShowing21 = "\(self.currentName) landed a direct hit for \(d)!"
            }
            else{
                self.textShowing21 = "\(self.currentName) landed a hit for \(d)!"
                self.textShowing22 = "(\(main.name)'s armour shielded \(arm))"
            }
            if arm<d{
                mainHealth -= d-arm
            }
        }
        if goOn1==true{
            d = Int.random(in: main.attack/3...main.attack)
            if crit{
                d *= 2
            }
            arm = Int.random(in: /*opponent.armour/3*/1...opponent.armour)
            if arm == 0{
                self.textShowing11 = "\(main.name) landed a direct hit for \(d)!"
            }
            else if pierced{
                self.textShowing11 = "\(main.name) landed a PIERCING SHOT for \(d)!"
            }
            else{
                self.textShowing11 = "\(main.name) landed a hit for \(d)!"
                self.textShowing12 = "(\(self.currentName)'s armour shielded \(arm))"
            }
            self.textShowing13 = crit ? "(CRITICAL STRIKE)" : ""
            if pierced{
                oppHealth -= d
            }
            else if arm<d{
                oppHealth -= d-arm
            }
        }
        if poison > 0{
            oppHealth -= poison
            self.textShowingP += "POISON DAGGER dealt \(poison)!"
        }
    }
    func newOpponent()->Void{
        self.opponent.health += Int.random(in: 30...40)
        self.opponent.attack += Int.random(in: 18...23)
        if self.oppIndex <= 4{
            self.opponent.accuracy += Int.random(in: 5...7)
        }
        else{
            self.opponent.accuracy += Int.random(in: 4...6)
        }
        if self.opponent.accuracy > 100{
            self.opponent.accuracy = 100
        }
        self.opponent.armour += Int.random(in: 13...18)
        self.opponent.block += Int.random(in: 2...3)
        if self.opponent.block > 70{
            self.opponent.block = 70
        }
        self.currentName = "Fighter \(self.oppIndex)"
    }
    func addGold()->Void{
        self.goldAdded = Int.random(in: 30...50)
        
        self.magnetGain = self.mainAbilities.magnet()
    }
    func clearText()->Void{
        self.textShowingH = ""
        self.textShowing11 = ""
        self.textShowing12 = ""
        self.textShowing13 = ""
        self.textShowing21 = ""
        self.textShowing22 = ""
        self.textShowingP = ""
    }
}

struct EndlessWavesView_Previews: PreviewProvider {
    static var previews: some View {
        EndlessWavesView(main: fighter(health: 0, attack: 0, accuracy: 0, block: 0, armour: 0, money: 0, regens: 0), mainCurrencies: currencies(treasuryLevel: 0, coinsStored: 0, xp: 0, xpBound: 0, xpLevel: 0, gems: 0, energy: 0),mainAbilities: abilities(pierce: 0, crit: 0, heal: 0, magnet: 0, poison: 0, wheel: 0),extraVariables: extras() ,show: Binding.constant(true), tickets: Binding.constant(3),tabBarHidden: Binding.constant(true),musicOn: true)
    }
}
