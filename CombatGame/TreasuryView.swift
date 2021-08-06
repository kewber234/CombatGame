//
//  TreasuryView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/12/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct animatedButtonNoShadow: ButtonStyle{
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            
    }
}

struct TreasuryView: View {
    @ObservedObject var main:fighter
    @ObservedObject var mainCurrencies:currencies
    @State private var angle:Double = 0
    @State private var width:CGFloat = 0.7
    @State private var height:CGFloat = 40
    @State private var coinY:CGFloat = 0.47// pos of coin
    @State private var coinSize:CGFloat = 1.0
    @State private var timer:Timer?
    @State private var timerCount = -1
    @State private var coinOpacity = 1.0
    @State private var emblemOpacity = 1.0
    @State private var textSize:CGFloat = 1.0
    var body: some View {
        GeometryReader{geo in
            
            Button(action: {

                self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
                    self.timerCount+=1
                    if self.timerCount == 13{
                        self.timer?.invalidate()
                        withAnimation{
                            self.coinOpacity = 0
                        }
                            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                                withAnimation(Animation.linear){
                                    self.height = 40
                                    self.width = 0.7
                                    self.angle = 0
                                    self.coinY = 0.47
                                    self.coinSize = 1
                                    self.emblemOpacity = 1
                                }
                            }
                        
                        self.main.money += self.mainCurrencies.coinsStored
                        self.mainCurrencies.coinsStored = 0
                    }
                    else if self.timerCount >= 0 && self.timerCount <= 3{
                        if self.timerCount == 0{
                            withAnimation{
                                self.angle += 22.5
                                self.emblemOpacity -= 1
                            }
                        }
                        else{
                            withAnimation{
                                self.angle += 22.5
                                self.width += 0.045
                                self.height += 16
                            }
                        }
                    }
                    else if self.timerCount < 9 && self.timerCount > 4 {
                        withAnimation(Animation.linear){
                            self.coinSize += 0.2
                            self.coinY -= 0.0525
                        }
                        
                    }
                    else if self.timerCount < 13 && self.timerCount != 4{
                        withAnimation(Animation.linear){
                    
                            self.coinSize -= 0.2
                            self.coinY -= 0.0525
                        }
                    }
                    if self.timerCount==9{
                        Sounds.playSound(soundName: "coin")
                    }
                })
            }
            
                
            ) {
                ZStack{
                    
                        Rectangle().frame(width:geo.size.width*self.width,height:self.height).cornerRadius(25).foregroundColor(.black).position(x:geo.size.width*0.5,y:geo.size.height*0.47)
                    
                        ZStack{
                            Image("Coin").resizable().aspectRatio(contentMode: .fit).frame(width:geo.size.width*0.15)
                            Text("\(self.mainCurrencies.coinsStored)").bold()
                        }.position(x:geo.size.width/2,y:geo.size.height*self.coinY).scaleEffect(self.coinSize).opacity(self.coinOpacity)
                    if self.mainCurrencies.coinsStored > 0{
                        Text("TAP TO COLLECT").position(x:geo.size.width/2,y:geo.size.height*0.66)
                            .scaleEffect(self.textSize)
                    }
                    
                    VStack(spacing:2){
                            Image("Chest Top").renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width:geo.size.width*0.90).rotation3DEffect(Angle(degrees: self.angle), axis: (x: 1, y: 0, z: 0))
                        Image("Chest Bottom").renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width:geo.size.width*0.90)
                    }.frame(width:geo.size.width*0.95)
                    Image("Coin").resizable().aspectRatio(contentMode: .fit).frame(width:geo.size.width*0.12).position(x:geo.size.width*0.506,y:geo.size.height*0.486).saturation(0.3).opacity(self.emblemOpacity)
                }
            }.position(x:geo.size.width/2,y:geo.size.height*0.5).buttonStyle(animatedButtonNoShadow())
        
        }.onAppear{
            withAnimation(Animation.linear.repeatCount(12,autoreverses: true)){
                if self.textSize == 1.0{
                    self.textSize = 0.96
                }
                else{
                    self.textSize = 1.0
                }
            }
        }
    }
}

struct TreasuryView_Previews: PreviewProvider {
    static var previews: some View {
        TreasuryView(main: fighter(health: 0, attack: 0, accuracy: 0, block: 0, armour: 0, money: 0, regens: 0),mainCurrencies: currencies(treasuryLevel: 0, coinsStored: 1, xp: 0,xpBound: 100,xpLevel:0 ,gems: 0, energy: 0))
    }
}

