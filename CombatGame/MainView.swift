//
//  MainView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 4/25/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI
import AVKit

struct MainView: View {
    @ObservedObject var main:fighter
    @ObservedObject var mainCurrencies:currencies
    @ObservedObject var mainAbilities:abilities
    @ObservedObject var extraVariables:extras
    @Binding var showing:Bool
    @State private var tickets = 0
    //@Binding var highScores:[Int]
    @State private var endLessWavesMode = false
    @State private var tabBarHidden = false
    var level:Int
    var musicOn:Bool
    var body: some View {
        GeometryReader{geo in
        ZStack{
            TabView{
                if self.level == 5 {
                    EndlessWavesView(main: self.main, mainCurrencies: self.mainCurrencies,mainAbilities: self.mainAbilities,extraVariables: self.extraVariables,show: self.$showing, tickets: self.$tickets,tabBarHidden: self.$tabBarHidden,musicOn: self.musicOn)
                        .tabItem{
                            Text("FIGHT")
                            Image(systemName: "pencil.slash")
                    }
                }
                else{
                    FightView(main: self.main,mainCurrencies: self.mainCurrencies,mainAbilities: self.mainAbilities,extraVariables: self.extraVariables,show: self.$showing,tickets:self.$tickets,level: self.level,tabBarHidden: self.$tabBarHidden,musicOn: self.musicOn)
                        .tabItem{
                            Text("FIGHT")
                            Image(systemName: "pencil.slash")
                    }
                }
                WheelView(main: self.main,mainAbilities: self.mainAbilities ,tickets: self.$tickets)
                    .tabItem{
                        Text("WHEEL")
                        Image(systemName: "asterisk.circle")
                }
                ShopView(main: self.main,tickets:self.tickets)
                    .tabItem{
                        Text("SHOP")
                        Image(systemName:"c.circle.fill")
                }
                RealTreasuryView(main: self.main,mainCurrencies: self.mainCurrencies)
                    .tabItem{
                        Text("TREASURY")
                        Image(systemName:"suit.diamond.fill")
                }
            }.onAppear{
                UITabBar.appearance().backgroundColor = .gray
            }.navigationBarTitle("",displayMode: .inline)
            if self.tabBarHidden{
                Rectangle().foregroundColor(.gray2).frame(maxWidth:.infinity).frame(height:99).position(x:geo.size.width/2,y:geo.size.height)
            }
        }
        
    }
    }
    
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(main: fighter(health: 125, attack: 98, accuracy: 76, block: 14, armour: 78, money: 100, regens: 2),mainCurrencies: currencies(treasuryLevel: 2, coinsStored: 2, xp: 2,xpBound: 100, xpLevel: 0,gems: 2, energy: 2),mainAbilities: abilities(pierce: 0, crit: 0, heal: 0, magnet: 0, poison: 0, wheel: 0),extraVariables: extras(),showing: Binding.constant(true), level: 2,musicOn: true)
    }
}
