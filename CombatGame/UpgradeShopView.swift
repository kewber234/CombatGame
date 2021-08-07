//
//  UpgradeShopView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/23/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct UpgradeShopView: View {
    @ObservedObject var mainCurrencies:currencies
    @ObservedObject var mainAbilities:abilities
    @ObservedObject var extraVariables:extras
    //@Binding var baselines:[Int]//atk,hth,acc,blk,arm
    @State private var showingConfirmation = false
    @State private var title = ""
    @State private var current = ""
    @State private var upgraded = ""
    @State private var price = 0
    @State private var index = ""
    var body: some View {
        GeometryReader{geo in
            ZStack{
                    ScrollView(.vertical){
                        Spacer()
                        ZStack{
                            Image("Temple").resizable().frame(width:geo.size.width,height:geo.size.height*4.1).offset(y:-geo.size.height*0.03).edgesIgnoringSafeArea(.all).opacity(0.4)
                            VStack(spacing:0){
                                /*VStack(spacing:0){
                                    Text("BASE STATS").bold().frame(width:geo.size.width).background(Color.greyWhite)
                                    mainStatsView(height: geo.size.height*0.18, width: geo.size.width, hth: self.baselines[1], atk: self.baselines[0], acc: self.baselines[2], arm: self.baselines[4], blk: self.baselines[3], rgn: 0)
                                }*/
                                
                                VStack(spacing:0){
                                    Text("BASE STATS").font(.system(size: geo.size.height*0.04)).foregroundColor(.white).offset(y:-30)
                                    HStack{
                                        Button(action: {
                                            self.showingConfirmation = true
                                            self.title = "Base Health"
                                            self.current = String(self.extraVariables.baselines[1])
                                            self.upgraded = String(self.extraVariables.baselines[1]+10)
                                            self.price = 2
                                            self.index = "hth"
                                        }) {
                                            StoreElementView(name: "Health", image: "Heart", text: "Base Health: \(self.extraVariables.baselines[1])", level: -1, color: .greyWhite,sideLength: 0.5,textSize: 30)
                                        }
                                        Button(action: {
                                            self.showingConfirmation = true
                                            self.title = "Base Attack"
                                            self.current = String(self.extraVariables.baselines[0])
                                            self.upgraded = String(self.extraVariables.baselines[0]+4)
                                            self.price = 2
                                            self.index = "atk"
                                        }) {
                                            StoreElementView(name: "Attack", image: "Swords", text: "Base Attack: \(self.extraVariables.baselines[0])", level: -1, color: .greyWhite,sideLength: 0.5,textSize: 30)
                                        }
                                        
                                    }.padding(.horizontal,geo.size.height*0.03)
                                    HStack{
                                        Button(action: {
                                            self.showingConfirmation = true
                                            self.title = "Base Accuracy"
                                            self.current = String(self.extraVariables.baselines[2])
                                            self.upgraded = String(self.extraVariables.baselines[2]+2)
                                            self.price = 2
                                            self.index = "acc"
                                        }) {
                                            StoreElementView(name: "Accuracy", image: "Target", text: "Base Accuracy: \(self.extraVariables.baselines[2])", level: -1, color: .greyWhite,sideLength: 0.5,textSize: 30)
                                        }
                                        Button(action: {
                                            self.showingConfirmation = true
                                            self.title = "Base Armour"
                                            self.current = String(self.extraVariables.baselines[4])
                                            self.upgraded = String(self.extraVariables.baselines[4]+5)
                                            self.price = 2
                                            self.index = "arm"
                                        }) {
                                            StoreElementView(name: "Armour", image: "Helmet", text: "Base Armour: \(self.extraVariables.baselines[4])", level: -1, color: .greyWhite,sideLength: 0.35,textSize: 30)
                                        }
                                    }.padding(.horizontal,geo.size.height*0.03)
                                    HStack{
                                        Button(action: {
                                            self.showingConfirmation = true
                                            self.title = "Base Block"
                                            self.current = String(self.extraVariables.baselines[3])
                                            self.upgraded = String(self.extraVariables.baselines[3]+1)
                                            self.price = 2
                                            self.index = "blk"
                                        }) {
                                            StoreElementView(name: "Block", image: "Shield", text: "Base Block: \(self.extraVariables.baselines[3])", level: -1, color: .greyWhite,sideLength: 0.45,textSize: 30)
                                        }
                                    }.padding(.horizontal,geo.size.height*0.17)
                                }.padding(.vertical,geo.size.height*0.14).background(Color.maroon)
                                VStack(spacing:15){
                                    Text("SPECIAL ABILITIES").font(.system(size: geo.size.height*0.04)).foregroundColor(.white)
                                    HStack{
                                        Button(action: {
                                            self.showingConfirmation = true
                                            self.title = "Max Heal Per Turn"
                                            self.current = self.mainAbilities.maxHeal(upgraded: false)
                                            self.upgraded = self.mainAbilities.maxHeal(upgraded: true)
                                            self.price = 5
                                            self.index = "heal"
                                        }) {
                                            StoreElementView(name: "Healing Aura", image: "Aura", text: "A shroud of mystical energy heals you each turn. The more damaged you are, the more healing occurs.", level: self.mainAbilities.healingAuraLevel, color: .cyan,sideLength: 0.45,textSize: geo.size.height*0.035)
                                        }
                                        Button(action: {
                                            self.showingConfirmation = true
                                            self.title = "Damage Per Turn"
                                            self.current = self.mainAbilities.poisonRange(upgraded: false)
                                            self.upgraded = self.mainAbilities.poisonRange(upgraded: true)
                                            self.price = 5
                                            self.index = "poison"
                                        }) {
                                            StoreElementView(name: "Poison Dagger", image: "Dagger", text: "A deadly dagger capable of dealing damage every turn, ignoring enemy armour or blocks.", level: self.mainAbilities.poisonDaggerLevel, color: .cyan,sideLength: 0.5,textSize: geo.size.height*0.035)
                                        }
                                        
                                    }.padding(.horizontal,geo.size.height*0.02)
                                    HStack{
                                        Button(action: {
                                            self.showingConfirmation = true
                                            self.title = "Piercing Chance"
                                            self.current = self.mainAbilities.pierceChance(upgraded: false)
                                            self.upgraded = self.mainAbilities.pierceChance(upgraded: true)
                                            if self.mainAbilities.piercingShotLevel <= 4{
                                                self.price = 5
                                            }
                                            else if self.mainAbilities.piercingShotLevel <= 9{
                                                self.price = 6
                                            }
                                            else if self.mainAbilities.piercingShotLevel <= 14{
                                                self.price = 7
                                            }
                                            else{
                                                self.price = 8
                                            }
                                            self.index = "pierce"
                                        }) {
                                            StoreElementView(name: "Piercing Shot", image: "Bow", text: "Gives a chance at landing a piercing shot, completely ignoring your opponent's armour.", level: self.mainAbilities.piercingShotLevel, color: .cyan,sideLength: 0.45,textSize: geo.size.height*0.035)
                                        }
                                        Button(action: {
                                            self.showingConfirmation = true
                                            self.title = "Critical Chance"
                                            self.current = self.mainAbilities.criticalChance(upgraded: false)
                                            self.upgraded = self.mainAbilities.criticalChance(upgraded: true)
                                            if self.mainAbilities.criticalStrikeLevel <= 4{
                                                self.price = 5
                                            }
                                            else if self.mainAbilities.criticalStrikeLevel <= 9{
                                                self.price = 6
                                            }
                                            else if self.mainAbilities.criticalStrikeLevel <= 14{
                                                self.price = 7
                                            }
                                            else{
                                                self.price = 8
                                            }
                                            self.index = "crit"
                                        }) {
                                            StoreElementView(name: "Critical Strike", image: "Target2", text: "Gives a chance at landing a critical strike, dealing double damage to your opponent.", level: self.mainAbilities.criticalStrikeLevel, color: .cyan,sideLength: 0.5,textSize: geo.size.height*0.035)
                                        }
                                        
                                    }.padding(.horizontal,geo.size.height*0.02)
                                    
                                    Button(action: {
                                        self.showingConfirmation = true
                                        self.title = "Coins Range"
                                        self.current = self.mainAbilities.magnetRange(upgraded: false)
                                        self.upgraded = self.mainAbilities.magnetRange(upgraded: true)
                                        self.price = 5
                                        self.index = "magnet"
                                    }) {
                                        StoreElementView(name: "Coin Magnet", image: "Magnet", text: "A powerful magnet collects additional coins, ready for the taking at the end of every combat.", level: self.mainAbilities.coinMagnetLevel, color: .cyan,sideLength: 0.4,textSize: geo.size.height*0.035)
                                    }.padding(.horizontal,geo.size.height*0.17)
                                    
                                    
                                }.padding(.vertical,geo.size.height*0.12).border(Color.gray2, width: 5).background(Color.brown2)
                                VStack(spacing:30){
                                    Text("FUNCTIONS").font(.system(size: geo.size.height*0.04)).foregroundColor(.white)
                                    Button(action: {
                                        self.showingConfirmation = true
                                        self.title = "Wheel Value Range"
                                        self.current = self.mainAbilities.wheelRange(upgraded: false)
                                        self.upgraded = self.mainAbilities.wheelRange(upgraded: true)
                                        self.price = 8
                                        self.index = "wheel"
                                    }) {
                                        StoreElementView(name: "Wheel", image: "Test Wheel", text: "Upgrade to win bigger and bigger prizes!", level: self.mainAbilities.wheelLevel, color: .orange2,sideLength: 0.7,textSize: 50)
                                    }.padding(.horizontal,geo.size.height*0.02)
                                    Button(action: {
                                        self.showingConfirmation = true
                                        self.title = "Growth Percentage"
                                        self.current = self.mainCurrencies.treasuryRange(upgraded: false)
                                        self.upgraded = self.mainCurrencies.treasuryRange(upgraded: true)
                                        self.price = 8
                                        self.index = "treasury"
                                    }) {
                                        StoreElementView(name: "Treasury", image: "Chest", text: "Upgrade to increase the amount of coin growth after each combat!", level: self.mainCurrencies.treasuryLevel, color: .orange2,sideLength: 0.8,textSize: 50)
                                    }.padding(.horizontal,geo.size.height*0.02)
                                }.padding(.vertical,20).background(Color.gray2)
                                Spacer()
                            }
                        }//end of zstack
                    }//scroll
                if self.showingConfirmation{
                    ZStack{
                        UpgradeConfirmationView(mainCurrencies: self.mainCurrencies, mainAbilities: self.mainAbilities,extraVariables: self.extraVariables ,title: self.title, current: self.current, upgraded: self.upgraded, price: self.price, index: self.index,showing: self.$showingConfirmation)
                Image(systemName: "xmark.square.fill").font(.system(size: 30)).position(x:geo.size.width*0.15,y:geo.size.height*0.25).foregroundColor(.red).onTapGesture {
                    self.showingConfirmation = false
                }
                    }
                }
                ZStack{
                    Rectangle().foregroundColor(Color.black.opacity(0.8)).frame(width:geo.size.width*1.3,height:geo.size.height*0.2).position(x: geo.size.width/2, y: -geo.size.height*0.04)
                    XPBarView(mainCurrencies: self.mainCurrencies).position(x: geo.size.width*0.46, y: 0)
                    CurrencyView(image: "Diamond", number: self.mainCurrencies.gems).position(x: geo.size.width*0.9, y:geo.size.height*0.465)
                    CurrencyView(image: "Lightning", number: self.mainCurrencies.energy)
                        .position(x: geo.size.width*1.24, y: geo.size.height*0.465)
                }.scaleEffect(0.92)
            }//zstack
        }//geo
    }//body
}

struct UpgradeShopView_Previews: PreviewProvider {
    static var previews: some View {
        UpgradeShopView(mainCurrencies: currencies(treasuryLevel: 1, coinsStored: 0, xp: 0, xpBound: 0, xpLevel: 0, gems: 700, energy: 0), mainAbilities: abilities(pierce: 0, crit: 0, heal: 0, magnet: 0, poison: 0, wheel: 1),extraVariables: extras())
    }
}
