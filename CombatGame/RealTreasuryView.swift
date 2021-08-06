//
//  RealTreasuryView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/14/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct RealTreasuryView: View {
    @ObservedObject var main:fighter
    @ObservedObject var mainCurrencies:currencies
    @State private var sliderVal = 0.0
    @State private var showingInside = false
    var body: some View {
        GeometryReader{geo in
            
            LinearGradient(gradient: Gradient(colors: [.maroon,.brown2,.pinkMaroon,.white,.white,.pinkMaroon,.brown2,.maroon]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            ZStack{
                CurrencyView(image: "Coin", number: self.main.money).position(x: geo.size.width*0.88, y: geo.size.height*0.5)
                TreasuryView(main: self.main, mainCurrencies:self.mainCurrencies).colorMultiply(self.showingInside ? .black : .white).onLongPressGesture(minimumDuration: 1) {
                    self.showingInside.toggle()
                }
                Text("Treasury lvl \(self.mainCurrencies.treasuryLevel)").bold().font(.system(size: 40)).position(x:geo.size.width/2,y:geo.size.height*0.16)
                Text("Growth Rate: \(self.mainCurrencies.treasuryRange(upgraded: false))")
                    .position(x:geo.size.width/2,y:geo.size.height*0.22).foregroundColor(.green)
                ZStack{
                    Image("Coin").resizable().aspectRatio(contentMode: .fit).frame(width:geo.size.width*0.15)
                    Text("\(self.mainCurrencies.coinsStored)").bold()
                }.position(x:geo.size.width/2,y:geo.size.height*0.46).opacity(self.showingInside ? 1.0 : 0)
                //Text("Gold Stored: \(self.mainCurrencies.coinsStored)").bold().padding(geo.size.height*0.05).background(Color.brown2.opacity(0.5)).position(x: geo.size.width/2, y: geo.size.height*0.36)
            }
            ZStack{
                Slider(value: self.$sliderVal, in: 0...Double(self.main.money)).padding(geo.size.height*0.04).padding(.bottom,geo.size.height*0.06).background(LinearGradient(gradient: Gradient(colors: [.greyWhite,.pinkMaroon]), startPoint: .top, endPoint: .bottom)).accentColor(.black).offset(y:geo.size.height*0.03)
                HStack{
                    Image("Coin").resizable().aspectRatio(contentMode: .fit).frame(width:30)
                    Text("\(Int(self.sliderVal))").font(.system(size: 35))
                }.offset(y:-geo.size.height*0.03)
                Button(action: {
                    self.main.money -= Int(self.sliderVal)
                    self.mainCurrencies.coinsStored += Int(self.sliderVal)
                    self.sliderVal = 0//Double(self.main.money)
                    /*self.main.health = 1500
                    self.main.attack = 1500
                    self.main.accuracy = 1500
                    self.main.block = 1500
                    self.main.armour = 1500*/
                }) {
                    Text("DEPOSIT").foregroundColor(.greyWhite).font(.system(size: 20)).padding(5).background(Color.gray2).cornerRadius(10).offset(y:geo.size.height*0.07)
                    }.buttonStyle(animatedButtonNoShadow()).shadow(radius: 5)
            }.position(x:geo.size.width/2,y:geo.size.height*0.88)
        }
    }
}

struct RealTreasuryView_Previews: PreviewProvider {
    static var previews: some View {
        RealTreasuryView(main: fighter(health: 0, attack: 0, accuracy: 0, block: 0, armour: 0, money: 234, regens: 0),mainCurrencies: currencies(treasuryLevel: 1, coinsStored: 1, xp: 3,xpBound: 100,xpLevel:0 ,gems: 3, energy: 3))
    }
}
