//
//  LevelUpScreen.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/17/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct LevelUpScreen: View {
    @ObservedObject var mainCurrencies:currencies
    @Binding var showing:Bool
    let gemIncrement = 15//gems per level up
    let maxEnergy = 20
    var body: some View {
        GeometryReader{geo in
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.blue,.white,.white,.white,.white,.blue]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all)
                Text("\(self.mainCurrencies.xpLevel)").bold().foregroundColor(.blue).shadow(color: .white, radius: 5, x: 0, y: 0).font(.system(size: 550)).opacity(0.2)
                Text("LEVEL UP").bold().font(.system(size: 60)).position(x: geo.size.width/2, y: geo.size.height*0.1)
                VStack(spacing:geo.size.height*0.12){
                    HStack(spacing:15){
                            Image("Diamond").resizable().frame(width:geo.size.height*0.15,height: geo.size.height*0.15).shadow(color: .black, radius: 5, x: 1, y: 1)
                        Text("\(self.gemIncrement)").font(.system(size: geo.size.height*0.08)).fontWeight(.black)
                    }
                    HStack(spacing:15){
                        Image("Lightning").resizable().aspectRatio(contentMode: .fit).frame(width:geo.size.height*0.15)
                            Text("\(self.maxEnergy)").font(.system(size: geo.size.height*0.08)).fontWeight(.black)
                    }
                }
                
            }.onAppear{
                self.mainCurrencies.gems += self.gemIncrement
                self.mainCurrencies.energy = self.maxEnergy
            }
            .onTapGesture {
                self.showing = false
            }
        }
    }
}

struct LevelUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        LevelUpScreen(mainCurrencies: currencies(treasuryLevel: 0, coinsStored: 0, xp: 0, xpBound: 0, xpLevel: 2, gems: 0, energy: 0), showing: Binding.constant(true))
    }
}
