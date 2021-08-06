//
//  FightView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 4/25/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI
import AVKit

struct FightView: View {
    let f1 = fighter(health: 100, attack: 60, accuracy: 60, block: 6, armour: 45, money: 0, regens: 0)
    let f2 = fighter(/*name: "Goblin Warrior", */health: 140, attack: 90, accuracy: 70, block: 9, armour: 50, money: 0, regens: 0)
    let f3 = fighter(/*name: "Archer Queen", */health: 160, attack: 120, accuracy: 100, block: 10, armour: 50, money: 0, regens: 0)
    let f4 = fighter(/*name: "Takuman", */health: 200, attack: 225, accuracy: 45, block: 5, armour: 85, money: 0, regens: 0)
    let f5 = fighter(/*name: "Mountain Giant", */health: 450, attack: 150, accuracy: 70, block: 18, armour: 60, money: 0, regens: 0)
    let f6 = fighter(/*name: "Golden Knight", */health: 325, attack: 190, accuracy: 78, block: 22, armour: 140, money: 0, regens: 0)
    let f7 = fighter(/*name: "Assasin", */health: 300, attack: 375, accuracy: 95, block: 5, armour: 105, money: 0, regens: 0)
    let f8 = fighter(/*name: "Mage Ward", */health: 550, attack: 230, accuracy: 75, block: 37, armour: 200, money: 0, regens: 0)
    let f9 = fighter(/*name: "Bubbles", */health: 600, attack: 320, accuracy: 85, block: 35, armour: 250, money: 0, regens: 0)
    let f10 = fighter(/*name: "Ninja Trio", */health: 3, attack: 650, accuracy: 100, block: 35, armour: 0, money: 0, regens: 0)
    let f11 = fighter(/*name: "Guardian Angel", */health: 600, attack: 400, accuracy: 90, block: 75, armour: 0, money: 0, regens: 0)
    let f12 = fighter(/*name: "Master Kenny", */health: 999, attack: 499, accuracy: 99, block: 39, armour: 409, money: 0, regens: 0)
    
    let sf1 = fighter(health: 150, attack: 80, accuracy: 70, block: 9, armour: 60, money: 0, regens: 0)
    let sf2 = fighter(/*name: "Goblin Warrior", */health: 200, attack: 120, accuracy: 80, block: 15, armour: 70, money: 0, regens: 0)
    let sf3 = fighter(/*name: "Archer Queen", */health: 220, attack: 170, accuracy: 100, block: 18, armour: 70, money: 0, regens: 0)
    let sf4 = fighter(/*name: "Takuman", */health: 280, attack: 260, accuracy: 58, block: 10, armour: 100, money: 0, regens: 0)
    let sf5 = fighter(/*name: "Mountain Giant", */health: 625, attack: 200, accuracy: 80, block: 28, armour: 85, money: 0, regens: 0)
    let sf6 = fighter(/*name: "Golden Knight", */health: 480, attack: 230, accuracy: 88, block: 30, armour: 170, money: 0, regens: 0)
    let sf7 = fighter(/*name: "Assasin", */health: 400, attack: 425, accuracy: 97, block: 10, armour: 145, money: 0, regens: 0)
    let sf8 = fighter(/*name: "Mage Ward", */health: 650, attack: 290, accuracy: 85, block: 48, armour: 270, money: 0, regens: 0)
    let sf9 = fighter(/*name: "Bubbles", */health: 760, attack: 400, accuracy: 90, block: 40, armour: 310, money: 0, regens: 0)
    let sf10 = fighter(/*name: "Ninja Trio", */health: 3, attack: 800, accuracy: 100, block: 42, armour: 0, money: 0, regens: 0)
    let sf11 = fighter(/*name: "Guardian Angel", */health: 850, attack: 460, accuracy: 94, block: 75, armour: 0, money: 0, regens: 0)
    let sf12 = fighter(/*name: "Master Kenny", */health: 1299, attack: 699, accuracy: 99, block: 39, armour: 609, money: 0, regens: 0)
    
    let tf1 = fighter(health: 250, attack: 115, accuracy: 80, block: 15, armour: 80, money: 0, regens: 0)
    let tf2 = fighter(/*name: "Goblin Warrior", */health: 320, attack: 170, accuracy: 88, block: 20, armour: 100, money: 0, regens: 0)
    let tf3 = fighter(/*name: "Archer Queen", */health: 300, attack: 220, accuracy: 100, block: 22, armour: 90, money: 0, regens: 0)
    let tf4 = fighter(/*name: "Takuman", */health: 380, attack: 320, accuracy: 64, block: 12, armour: 120, money: 0, regens: 0)
    let tf5 = fighter(/*name: "Mountain Giant", */health: 750, attack: 270, accuracy: 85, block: 32, armour: 120, money: 0, regens: 0)
    let tf6 = fighter(/*name: "Golden Knight", */health: 600, attack: 300, accuracy: 92, block: 32, armour: 210, money: 0, regens: 0)
    let tf7 = fighter(/*name: "Assasin", */health: 500, attack: 485, accuracy: 99, block: 14, armour: 190, money: 0, regens: 0)
    let tf8 = fighter(/*name: "Mage Ward", */health: 800, attack: 360, accuracy: 90, block: 50, armour: 330, money: 0, regens: 0)
    let tf9 = fighter(/*name: "Bubbles", */health: 850, attack: 460, accuracy: 93, block: 42, armour: 360, money: 0, regens: 0)
    let tf10 = fighter(/*name: "Ninja Trio", */health: 3, attack: 1000, accuracy: 100, block: 42, armour: 0, money: 0, regens: 0)
    let tf11 = fighter(/*name: "Guardian Angel", */health: 1150, attack: 560, accuracy: 95, block: 75, armour: 0, money: 0, regens: 0)
    let tf12 = fighter(/*name: "Master Kenny", */health: 1499, attack: 899, accuracy: 99, block: 39, armour: 809, money: 0, regens: 0)
    let sizes:[CGFloat] = [1.5,1.5,1.5,1.0,1.0,1.0,1.1,1.3,1.2,1.0,1.0,1.0]
    @ObservedObject var main:fighter
    @ObservedObject var mainCurrencies:currencies
    @ObservedObject var mainAbilities: abilities
    @ObservedObject var extraVariables:extras
    @State private var copy:fighter = fighter(health: 0, attack: 0, accuracy: 0, block: 0, armour: 0, money: 0, regens: 0)
    @State private var copyHealth = 200
    @State private var copyHealth2 = 200
    @State private var currentOpponent = fighter(health: 0, attack: 0, accuracy: 0, block: 0, armour: 0, money: 0, regens: 0)
    @State private var currentIndex = -1
    @State private var currentName = ""
    @State private var textShowingH = ""
    @State private var textShowing11 = ""
    @State private var textShowing12 = ""
    @State private var textShowing13 = ""
    @State private var textShowing21 = ""
    @State private var textShowing22 = ""
    @State private var textShowingP = ""
    @State private var showingShowdown = true
    @State private var copyOppHealth = 0
    //let timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()
    @State private var timer:Timer?
    @State private var showingRewards = false
    @State private var showingDeath = false
    @State private var goldAdded = 0
    @State private var regenActivated = false
    @State private var ninjaIndex = 1
    @State private var magnetGain = 0
    @State private var firstTimeWin = false
    @State private var beatMasterKenny = false
    let levelAddends = [16,9,3,3,1,0]
    @Binding var show : Bool
    @Binding var tickets:Int
    var level:Int
    //@Binding var highScores:[Int]
    @Binding var tabBarHidden:Bool
    var musicOn:Bool
    var body: some View {
        GeometryReader{geo in
            VStack{
                if self.showingDeath{
                    DeathScreen(mainCurrencies: self.mainCurrencies, currentIndex: self.currentIndex == 12 ? self.currentIndex : self.currentIndex+1, level: self.level, showing: self.$showingDeath,firstTimeWin:self.firstTimeWin,beatMasterKenny: self.beatMasterKenny).onDisappear{
                        self.show = false
                    }
                }
                else if self.showingRewards{
                    RewardScreen(coinNumber: self.goldAdded,currentIndex: self.currentIndex+1,level: self.level,endless: false,coinMagnet: self.magnetGain,showingRewards: self.$showingRewards)
                }
                else if self.showingShowdown{
                    ShowdownView(oppImage: self.currentName,image: "Boy", opp: self.currentOpponent,oppName: self.currentName ,showing: self.$showingShowdown, main: self.main).onTapGesture {
                            self.showingShowdown = false
                        self.tabBarHidden = true
                            if self.musicOn{
                                Sounds.pauseDojo()
                                Sounds.playBattle()
                            }
                        self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
                            
                            
                            if self.copy.health <= 0 || self.currentOpponent.health <= 0 {
                                if self.copy.health <= 0{
                                    if self.main.regens >= 1{// activate regen
                                        Sounds.playSoundWAV(soundName: "regen")
                                        self.regenerate()
                                        self.main.regens -= 1
                                        self.copy.health = self.copyHealth/2
                                        //self.timer.upstream.autoconnect()
            
                                    }
                                    else{// player dies
                                        self.timer?.invalidate()
                    
                                        self.showingDeath = true
                                        self.tabBarHidden = false
                                        self.tickets = 0
                                        self.main.money = 0
                                        self.mainCurrencies.coinsStored = 0
                                        self.main.regens = 0
                                        if self.currentIndex > self.extraVariables.highScores[self.level]{
                                            self.extraVariables.highScores[self.level] = self.currentIndex
                                        }
                                        if self.musicOn{
                                            Sounds.stopBattle()
                                            Sounds.resumeDojo()
                                        }
                                        // add xp + alert here
                                        //self.show = false
                                    }
                                }
                                else if self.currentOpponent.health <= 0{
                                    if self.currentIndex == 12 || self.currentIndex == 11 {// if you won the whole game
                                        self.timer?.invalidate()
                                        self.beatMasterKenny = true
                                        self.showingDeath = true
                                        self.tabBarHidden = false
                                        self.tickets = 0
                                        self.main.money = 0
                                        self.main.regens = 0
                                        self.mainCurrencies.coinsStored = 0
                                        if self.extraVariables.highScores[self.level] != 12{
                                            self.firstTimeWin = true
                                            self.extraVariables.highScores[self.level] = 12
                                        }
                                        else{
                                            self.firstTimeWin = false
                                            self.extraVariables.highScores[self.level] = 12
                                        }
                                        
                                        if self.musicOn{
                                            Sounds.stopBattle()
                                            Sounds.resumeDojo()
                                        }
                                        //self.show = false
                                    }
                                    // typical win
                                    else{
                                        /*if self.currentIndex == 9 /*&& self.ninjaIndex < 3*/{//if facing ninja trio
                                            //self.ninjaIndex += 1
                                            self.currentOpponent.health = 1
                                            self.timer.upstream.autoconnect()
                                        }*/
                                        //else{
                                            self.timer?.invalidate()
                                            self.showingRewards = true
                                            self.tabBarHidden = false
                                            self.clearText()
                                            self.copyMain()
                                            self.copy.health =  self.copyHealth
                                            self.addGold()
                                            self.main.money += self.goldAdded
                                            self.main.money += self.magnetGain
                                            self.newOpponent()
                                            self.copyOppHealth = self.currentOpponent.health
                                            self.showingShowdown = true
                                            self.tickets += 1
                                        self.mainCurrencies.coinsStored = Int(self.mainCurrencies.getTreasuryRate()*Double(self.mainCurrencies.coinsStored))
                                        if self.musicOn{
                                            Sounds.stopBattle()
                                            Sounds.resumeDojo()
                                        }
                                    //}
                                    }
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
                            
                            Image(self.currentName).resizable().frame(width:geo.size.width,height:geo.size.height/2).opacity(0.2).edgesIgnoringSafeArea(.all)
                            Image("Boy").resizable().frame(width:geo.size.width,height:geo.size.height/2).opacity(0.2)
                            
                        }.edgesIgnoringSafeArea(.all).offset(y:3).opacity(self.regenActivated ? 0.5 : 1.0).blur(radius: self.regenActivated ? 5 : 0)/*.onReceive(self.timer) { _ in
                            if self.copy.health <= 0 || self.currentOpponent.health <= 0 {
                                self.timer.upstream.connect().cancel()
                                if self.copy.health <= 0{
                                    if self.main.regens >= 1{// activate regen
                                        Sounds.playSoundWAV(soundName: "regen")
                                        self.regenerate()
                                        self.main.regens -= 1
                                        self.copy.health = self.copyHealth/2
                                        //self.timer.upstream.autoconnect()
                                    }
                                    else{// player dies
                                        self.showingDeath = true
                                        self.tabBarHidden = false
                                        self.tickets = 0
                                        self.main.money = 0
                                        self.mainCurrencies.coinsStored = 0
                                        if self.currentIndex > self.extraVariables.highScores[self.level]{
                                            self.extraVariables.highScores[self.level] = self.currentIndex
                                        }
                                        if self.musicOn{
                                            Sounds.stopBattle()
                                            Sounds.resumeDojo()
                                        }
                                        // add xp + alert here
                                        //self.show = false
                                    }
                                }
                                else if self.currentOpponent.health <= 0{
                                    if self.currentIndex == 12 || self.currentIndex == 11 {// if you won the whole game
                                        self.showingDeath = true
                                        self.tabBarHidden = false
                                        self.tickets = 0
                                        self.main.money = 0
                                        self.mainCurrencies.coinsStored = 0
                                        if self.extraVariables.highScores[self.level] != 12{
                                            self.firstTimeWin = true
                                            self.extraVariables.highScores[self.level] = 12
                                        }
                                        else{
                                            self.firstTimeWin = false
                                            self.extraVariables.highScores[self.level] = 12
                                        }
                                        
                                        if self.musicOn{
                                            Sounds.stopBattle()
                                            Sounds.resumeDojo()
                                        }
                                        //self.show = false
                                    }
                                    // typical win
                                    else{
                                        /*if self.currentIndex == 9 /*&& self.ninjaIndex < 3*/{//if facing ninja trio
                                            //self.ninjaIndex += 1
                                            self.currentOpponent.health = 1
                                            self.timer.upstream.autoconnect()
                                        }*/
                                        //else{
                                            self.showingRewards = true
                                            self.tabBarHidden = false
                                            self.clearText()
                                            self.copyMain()
                                            self.copy.health =  self.copyHealth
                                            self.addGold()
                                            self.main.money += self.goldAdded
                                            self.main.money += self.magnetGain
                                            self.newOpponent()
                                            self.copyOppHealth = self.currentOpponent.health
                                            self.showingShowdown = true
                                            self.tickets += 1
                                        self.mainCurrencies.coinsStored = Int(self.mainCurrencies.getTreasuryRate()*Double(self.mainCurrencies.coinsStored))
                                        if self.musicOn{
                                            Sounds.stopBattle()
                                            Sounds.resumeDojo()
                                        }
                                    //}
                                    }
                                }
                            }
                            else{
                                self.clearText()
                                self.hit()
                            }
                        }*/
                        ZStack{
                            HealthBarView(name: self.currentName, originalHealth: self.copyOppHealth, health: self.currentOpponent.health).position(x:geo.size.width/2,y:geo.size.height*0.1)
                            Text("\(self.textShowingH)").bold().font(.system(size: geo.size.height*0.04)).multilineTextAlignment(.leading).padding(.horizontal,5).position(x:geo.size.width/2,y:geo.size.height*0.26).foregroundColor(.blue)
                            Text("\(self.textShowing11)").bold().font(.system(size: geo.size.height*0.03)).multilineTextAlignment(.leading).padding(.horizontal,5).position(x:geo.size.width/2,y:geo.size.height*0.34)
                            Text("\(self.textShowing12)").bold().font(.system(size: geo.size.height*0.03)).multilineTextAlignment(.leading).padding(.horizontal,5).position(x:geo.size.width/2,y:geo.size.height*0.39)
                            Text("\(self.textShowing13)").bold().font(.system(size: geo.size.height*0.03)).multilineTextAlignment(.leading).padding(.horizontal,5).position(x:geo.size.width/2,y:geo.size.height*0.44)
                            Text("\(self.textShowing21)").bold().font(.system(size: geo.size.height*0.03)).multilineTextAlignment(.leading).padding(.horizontal,5).position(x:geo.size.width/2,y:geo.size.height*0.55)
                            Text("\(self.textShowing22)").bold().font(.system(size: geo.size.height*0.03)).multilineTextAlignment(.leading).padding(.horizontal,5).position(x:geo.size.width/2,y:geo.size.height*0.6)
                            Text("\(self.textShowingP)").bold().font(.system(size: geo.size.height*0.04)).multilineTextAlignment(.leading).padding(.horizontal,5).position(x:geo.size.width/2,y:geo.size.height*0.68).foregroundColor(.darkGreen)
                            HealthBarView(name: self.main.name, originalHealth: self.copyHealth, health: self.copy.health)
                            .position(x:geo.size.width/2,y:geo.size.height*0.9)
                        }.blur(radius: self.regenActivated ? 5 : 0).opacity(self.regenActivated ? 0.5 : 1.0)
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
    
            self.copy = self.main
            self.copyHealth = self.main.health
            if self.currentIndex == -1{
                self.newOpponent()
            }
            self.copyOppHealth = self.currentOpponent.health
            
        }
        //search up fight( to find the fighting algorithm
    }
    func regenerate()->Void{
        self.regenActivated = true
        Sounds.playSound(soundName: "regen")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.regenActivated = false
        }
    }
    func copyMain()->Void{
        self.copy = self.main
    }
    func hit()->Void{
        let pierced = self.mainAbilities.pierced()
        let crit = self.mainAbilities.critical()
        let poison = self.mainAbilities.poison()
        var goOn1 = true
        var goOn2 = true
        var arm = 0
        var d = 0
        /*self.textShowing13 = "CRITICAL STRIKE"
        self.textShowingH = "HEALING AURA healed 40!"
        self.textShowingP = "POISON DAGGER dealt 47!"
        self.textShowing13 = "CRITICAL STRIKE"*/ //for testing purposes
        if self.mainAbilities.healingAuraLevel > 0{
            let h = self.mainAbilities.healed(currentHealth: copy.health, originalHealth: self.copyHealth)
            copy.health += h
            self.textShowingH = "HEALING AURA healed \(h)!"
        }
        if copy.hitLanded(num: Int.random(in: 1...100))==false{
            self.textShowing11 = "\(main.name) missed!"
            goOn1 = false
        }
        else if currentOpponent.blockSuccesful(num: Int.random(in: 1...100))==true{
            self.textShowing11 = "\(self.currentName) blocked \(main.name)!"
            goOn1 = false
        }
        if currentOpponent.hitLanded(num: Int.random(in: 1...100))==false{
            self.textShowing21 = "\(self.currentName) missed!"
            goOn2 = false
        }
        else if main.blockSuccesful(num: Int.random(in: 1...100))==true{
            self.textShowing21 = "\(main.name) blocked \(self.currentName)!"
            goOn2 = false
        }
        if goOn2==true{
            d = Int.random(in: currentOpponent.attack/3...currentOpponent.attack)
            arm = Int.random(in: /*main.armour/3*/1...main.armour)
            if arm == 0{
                self.textShowing21 = "\(self.currentName) landed a direct hit for \(d)!"
            }
            else{
                self.textShowing21 = "\(self.currentName) landed a hit for \(d)"
                self.textShowing22 = "(\(main.name)'s armour shielded \(arm))"
            }
            if arm<d{
                
                    copy.health -= d-arm
                
            }
        }
        if goOn1==true{
            d = Int.random(in: copy.attack/3...copy.attack)
            if crit{
                d *= 2
            }
            arm = Int.random(in: /*currentOpponent.armour/3*/1...currentOpponent.armour)
            if arm == 0{
                self.textShowing11 = "\(copy.name) landed a direct hit for \(d)!"
            }
            else if pierced{
                self.textShowing11 = "\(copy.name) landed a PIERCING SHOT for \(d)!"
            }
            else{
                self.textShowing11 = "\(copy.name) landed a hit for \(d)!"
                self.textShowing12 = "(\(self.currentName)'s armour shielded \(arm))"
            }
            self.textShowing13 = crit ? "(CRITICAL STRIKE)" : ""
            if pierced{
                if self.currentIndex == 9{
                    currentOpponent.health -= 1
                }
                else{
                    currentOpponent.health -= d
                }
            }
            else if arm<d{
                if self.currentIndex == 9{
                    currentOpponent.health -= 1
                }
                else{
                    currentOpponent.health -= d-arm
                }
            }
        }
        if poison > 0{
            if self.currentIndex != 9{
                currentOpponent.health -= poison
                self.textShowingP = "\nPOISON DAGGER dealt \(poison)!"
            }
        }
    }
    func newOpponent()->Void{
        var opponents = [f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f1]
        if self.level == 3{
            opponents = [sf1,sf2,sf3,sf4,sf5,sf6,sf7,sf8,sf9,sf10,sf11,sf12,sf1]
        }
        else if self.level == 4{
            opponents = [tf1,tf2,tf3,tf4,tf5,tf6,tf7,tf8,tf9,tf10,tf11,tf12,tf1]
        }
        else{
            opponents = [f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f1]
        }
        let opponentsNames: [String] = ["Sparring Partner","Goblin Warrior","Archer Queen","Takuman","Mountain Giant","Golden Knight","Assassin","Mage Ward","Bubbles","Ninja Trio","Guardian Angel","Master Kenny"]
        self.currentIndex += 1
        self.currentOpponent = opponents[self.currentIndex]
        self.currentName = opponentsNames[self.currentIndex]
    }
    func addGold()->Void{
        self.goldAdded = Int.random(in:(25+(self.levelAddends[self.level] * self.currentIndex))...(55+(self.levelAddends[self.level] * self.currentIndex)))
        if self.mainAbilities.coinMagnetLevel > 0{
            self.magnetGain = self.mainAbilities.magnet()
        }
        
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

struct FightView_Previews: PreviewProvider {
    static var previews: some View {
        FightView(main: fighter(health: 420, attack: 60, accuracy: 58, block: 30, armour: 130, money: 0, regens: 0),mainCurrencies: currencies(treasuryLevel: 0, coinsStored: 0, xp: 0,xpBound: 100,xpLevel:0 ,gems: 0, energy: 0),mainAbilities: abilities(pierce: 0, crit: 0, heal: 0, magnet: 0, poison: 0, wheel: 0),extraVariables: extras(),show: Binding.constant(true),tickets: Binding.constant(3),level: 2,tabBarHidden: Binding.constant(true),musicOn: true)
    }
}
