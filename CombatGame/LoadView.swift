//
//  LoadView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/3/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct LoadView: View {
    @ObservedObject var mainCurrencies:currencies
    @Binding var showing:Bool
    @Binding var level:Int
    @State private var showingConfirmation = false
    @ObservedObject var extraVariables:extras
    
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Image("Temple").resizable().edgesIgnoringSafeArea(.all).opacity(0.75).onTapGesture {
                    self.showingConfirmation = false
                }
                Text("SPIRIT OF COMBAT").fontWeight(.black).font(.custom("Zapfino", size: geo.size.width*0.058)).position(x: geo.size.width/2, y: geo.size.height*0.13).onTapGesture {
                    self.showingConfirmation = false
                }
                
                LevelView(lvl: "TRAINEE", levelsPassed: self.extraVariables.highScores[0],completed: self.extraVariables.highScores[0]==12,locked: false).onTapGesture {
                        //self.showing = false
                        self.level = 0
                        self.showingConfirmation = true
                }.position(x: geo.size.width/1.93, y: geo.size.height*0.66)
                    LevelView(lvl: "NOVICE", levelsPassed: self.extraVariables.highScores[1],completed: self.extraVariables.highScores[1]==12,locked: self.extraVariables.highScores[0] != 12).onTapGesture {
                        if self.extraVariables.highScores[0] == 12{
                            //self.showing = false
                            self.level = 1
                            self.showingConfirmation = true
                        }
                    }.position(x: geo.size.width/1.93, y: geo.size.height*0.8)
                    LevelView(lvl: "COMBATANT", levelsPassed: self.extraVariables.highScores[2],completed: self.extraVariables.highScores[2]==12,locked: self.extraVariables.highScores[1] != 12).onTapGesture {
                        if self.extraVariables.highScores[1] == 12{
                            //self.showing = false
                            self.level = 2
                            self.showingConfirmation = true
                        }
                    }.position(x: geo.size.width/1.93, y: geo.size.height*0.94)
                    LevelView(lvl: "EXPERT", levelsPassed: self.extraVariables.highScores[3],completed: self.extraVariables.highScores[3]==12,locked: self.extraVariables.highScores[2] != 12).onTapGesture {
                        if self.extraVariables.highScores[2] == 12 {
                            //self.showing = false
                            self.level = 3
                            self.showingConfirmation = true
                        }//master then grandmaster
                    }.position(x: geo.size.width/1.93, y: geo.size.height*1.08)
                LevelView(lvl: "MASTER", levelsPassed: self.extraVariables.highScores[4],completed: self.extraVariables.highScores[4]==12,locked: self.extraVariables.highScores[3] != 12).onTapGesture {
                    if self.extraVariables.highScores[3] == 12 {
                        //self.showing = false
                        self.level = 4
                        self.showingConfirmation = true
                    }//master then grandmaster
                }.position(x: geo.size.width/1.93, y: geo.size.height*1.22)
                VStack{
                    Text("ENDLESS WAVES").font(.system(size: geo.size.height*0.05)).bold()
                    Text("HIGH SCORE: \(self.extraVariables.highScores[self.extraVariables.highScores.count-1]) | NEXT CHECKPOINT: \(self.getNextCheckPoint())").font(.system(size: geo.size.height*0.024)).bold()
                    //Text("HIGH SCORE: \(self.extraVariables.highScores[self.extraVariables.highScores.count-1])").font(.system(size: geo.size.height*0.024)).bold()
                }.frame(width:geo.size.width*0.96,height:geo.size.height*0.13).background(LinearGradient(gradient: Gradient(colors: [.maroon,.pinkMaroon,.maroon]), startPoint: .top, endPoint: .bottom)).cornerRadius(20).foregroundColor(.greyWhite).position(x: geo.size.width/2, y: geo.size.height*0.92).onTapGesture {
                    //self.showing = false
                    self.level = self.extraVariables.highScores.count-1
                    self.showingConfirmation = true
                }
                ZStack{
                    XPBarView(mainCurrencies: self.mainCurrencies).position(x: geo.size.width*0.44, y: 0)
                    CurrencyView(image: "Diamond", number: self.mainCurrencies.gems).position(x: geo.size.width*1.2, y:geo.size.height*0.46)
                    CurrencyView(image: "Lightning", number: self.mainCurrencies.energy)
                        .position(x: geo.size.width*0.85, y: geo.size.height*0.46)
                    if self.mainCurrencies.energy < 20{
                        Text("\(self.extraVariables.minutes):\(self.extraVariables.seconds1)\(self.extraVariables.seconds2)").position(x: geo.size.width*0.97, y: geo.size.height*0.02).foregroundColor(.white).font(.system(size: 13))
                    }
                }.scaleEffect(0.92)
                if self.showingConfirmation{
                    ZStack{
                    ConfirmationView(mainCurrencies: self.mainCurrencies, level: self.level, showing: self.$showing, showingThisScreen: self.$showingConfirmation)
                        Image(systemName: "xmark.square.fill").font(.system(size: 30)).position(x:geo.size.width*0.17,y:geo.size.height*0.26).foregroundColor(.red).onTapGesture {
                            self.showingConfirmation = false
                        }
                    }
                }
            }
        }
        
    }
    func getNextCheckPoint()->Int{
        let mod = self.extraVariables.highScores[self.extraVariables.highScores.count-1]%5
        let d = 5 - mod
        return (self.extraVariables.highScores[self.extraVariables.highScores.count-1]+d)
    }
}

struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView(mainCurrencies: currencies(treasuryLevel: 0, coinsStored: 0, xp: 179, xpBound: 547,xpLevel: 0, gems: 3, energy: 18),showing: Binding.constant(false),level: Binding.constant(2),extraVariables:extras())
    }
}
