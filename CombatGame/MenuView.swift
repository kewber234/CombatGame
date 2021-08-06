//
//  MenuView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/24/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var main:fighter
    @ObservedObject var mainCurrencies:currencies
    @ObservedObject var mainAbilities:abilities
    @ObservedObject var extraVariables:extras
    @Binding var showing:Bool
    @Binding var level:Int
    //var highScores: [Int]
    @Binding var musicOn:Bool
    //@Binding var baselines:[Int]
    var body: some View {
        TabView{
            LoadView(mainCurrencies: mainCurrencies, showing: $showing, level: $level/*, highScores: highScores*/,extraVariables:self.extraVariables)
                .tabItem{
                    Text("Play")
                    Image(systemName: "flag.fill")
                }
            UpgradeShopView(mainCurrencies: mainCurrencies, mainAbilities: mainAbilities/*,baselines:$baselines*/,extraVariables: self.extraVariables)
                .tabItem{
                    Text("Upgrade")
                    Image(systemName: "arrow.up.square.fill")
                }
            SettingsView(main: main,mainCurrencies: mainCurrencies,mainAbilities: mainAbilities,extraVariables: extraVariables,musicOn: $musicOn)
                .tabItem{
                    Text("Settings")
                    Image(systemName: "gear")
            }.onAppear{
                UITabBar.appearance().backgroundColor = .gray
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(main: fighter(health: 0, attack: 0, accuracy: 0, block: 0, armour: 0, money: 0, regens: 0), mainCurrencies: currencies(treasuryLevel: 0, coinsStored: 0, xp: 0, xpBound: 0, xpLevel: 0, gems: 0, energy: 0),mainAbilities: abilities(pierce: 0, crit: 0, heal: 0, magnet: 0, poison: 0, wheel: 0),extraVariables: extras(),showing: Binding.constant(true),level: Binding.constant(2),musicOn:Binding.constant(true))
    }
}
