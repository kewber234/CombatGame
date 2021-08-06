//
//  ConfirmationView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/23/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct ConfirmationView: View {
    @ObservedObject var mainCurrencies:currencies
    var level:Int
    @Binding var showing:Bool//showing load view
    @Binding var showingThisScreen:Bool
    let levelNames = ["Trainee","Novice","Combatant","Expert","Master","Endless Waves"]
    let costs = [5,5,5,5,5,3]
    var body: some View {
        GeometryReader{geo in
            ZStack{
                AlertView(bodyColors: [.greyWhite,.white,.greyWhite], headerColors: [.greyWhite,.gray2,.greyWhite])
                Text(self.levelNames[self.level]).foregroundColor(.white).font(.system(size: geo.size.height*0.065)).position(x: geo.size.width/2, y: geo.size.height*0.285)
                HStack{
                    Image("Lightning").resizable().aspectRatio(contentMode: .fit).frame(width:geo.size.width*0.2)
                    Text("\(self.costs[self.level])").bold().font(.system(size: geo.size.height*0.08))
                }
                Button(action: {
                    if self.mainCurrencies.energy >= self.costs[self.level]{
                        self.mainCurrencies.energy -= self.costs[self.level]
                        self.showingThisScreen = false
                        self.showing = false
                    }
                }) {
                    Text("PLAY").bold().font(.system(size: geo.size.height*0.04)).padding(10).padding(.horizontal,30).background(Color.green).foregroundColor(.white).cornerRadius(20).position(x: geo.size.width/2, y: geo.size.height*0.7)
                }.buttonStyle(animatedButtonNoShadow())
            }
        }
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(mainCurrencies:currencies(treasuryLevel: 0, coinsStored: 0, xp: 0, xpBound: 0, xpLevel: 0, gems: 0, energy: 0),level: 4, showing: Binding.constant(true),showingThisScreen: Binding.constant(true))
    }
}
