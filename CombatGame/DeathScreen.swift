//
//  DeathScreen.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/17/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct DeathScreen: View {
    @ObservedObject var mainCurrencies:currencies
    var currentIndex: Int
    var level: Int
    @State var size:CGFloat = 0
    @Binding var showing:Bool
    var firstTimeWin:Bool
    var beatMasterKenny:Bool
    @State private var showingLevelUp = false
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.brown2,.white,.white,.brown2]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all)
            Text(currentIndex == 12 && self.beatMasterKenny ? "LEVEL\nCLEARED" : "DEFEAT").font(.system(size:currentIndex != 12 ?  80 : 65)).fontWeight(.bold).foregroundColor(.black).offset(y:-230).multilineTextAlignment(.center)
            VStack(spacing:50){
                //if self.currentIndex != 12{
                
                    ZStack{
                        
                        Circle().frame(width:350,height:350).foregroundColor(Color.gray2.opacity(0.7))
                        Text("Fights Won").font(.system(size: 40)).multilineTextAlignment(.center).foregroundColor(.white).offset(y:-70)
                        if self.beatMasterKenny && self.currentIndex == 12{
                            Text("12/12").fontWeight(.black).foregroundColor(.white).font(.system(size: 100)).offset(y:10)
                        }
                        else{
                            Text(currentIndex == 12 && self.beatMasterKenny == false ? "11/12" : "\((self.currentIndex-1))/12" ).fontWeight(.black).foregroundColor(.white).font(.system(size: 100)).offset(y:10)
                        }
                    }.offset(y:30)
                
                //}
                HStack(spacing:50){
                    HStack(spacing:20){
                        Text("XP").fontWeight(.black).font(.system(size: 90)).foregroundColor(.blue).shadow(color: .white, radius: 5, x: 0, y: 0)
                        Text("\(self.getXPGain())").font(.system(size: 60)).fontWeight(.black)
                    }.fixedSize()
                    HStack(spacing:25){
                        Image("Diamond").resizable().frame(width:110,height: 110).shadow(color: .black, radius: 5, x: 1, y: 1)
                        Text("\(self.getDiamondGain())").font(.system(size: 70)).fontWeight(.black)
                    }.fixedSize()
                }
                if self.firstTimeWin{
                    VStack{
                        HStack{
                            Image(systemName: "star.fill").foregroundColor(.yellow).offset(y:6)
                            Image(systemName: "star.fill").foregroundColor(.yellow).offset(y:3)
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                            Text("FIRST WIN BONUS").font(.system(size: 30))
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                            Image(systemName: "star.fill").foregroundColor(.yellow).offset(y:3)
                            Image(systemName: "star.fill").foregroundColor(.yellow).offset(y:6)
                        }
                        HStack{
                            Image("Diamond").resizable().frame(width:50,height:50)
                            Text("\((self.level+1)*10)").font(.system(size: 30))
                        }
                    }
                }
            }.offset(y: self.firstTimeWin ? 45 : 0).scaleEffect(self.size)
            if self.showingLevelUp{
                LevelUpScreen(mainCurrencies: self.mainCurrencies, showing: self.$showingLevelUp).onDisappear{
                    self.showing = false
                }
            }
            
        }.onAppear{
            withAnimation(Animation.linear(duration: 0.7)){
                self.size += 0.65
            }
        }
        .onTapGesture {
            if self.firstTimeWin{
                self.mainCurrencies.gems += (10)+((self.level+1)*(5))
            }
            self.mainCurrencies.gems += self.getDiamondGain()
            if (self.mainCurrencies.xpBound - self.mainCurrencies.xp) > (self.getXPGain())
            {
                self.mainCurrencies.xp += self.getXPGain()
                self.showing = false
            }
            else{
                self.mainCurrencies.xp = self.getXPGain() - (self.mainCurrencies.xpBound - self.mainCurrencies.xp)
                self.mainCurrencies.xpBound += Int.random(in: 200...250)
                self.mainCurrencies.xpLevel += 1
                self.showingLevelUp = true
            }
        }
        
    }
    func getXPGain()->Int{
        var temp = 0
        if self.currentIndex == 1{
            temp = 0
        }
        else{
            for i in 1...(self.currentIndex-1){
                temp += i
            }
        }
        if self.currentIndex == 12{
            temp += 15 + (4*self.level)
        }
        
        return ((3+(4*(self.level)))*(self.currentIndex) + temp) - (self.currentIndex == 1 ? 0 : (3+(4*(self.level))))
    }
    func getDiamondGain()->Int{
        return getXPGain()/49
    }
}

struct DeathScreen_Previews: PreviewProvider {
    static var previews: some View {
        DeathScreen(mainCurrencies: currencies(treasuryLevel: 0, coinsStored: 0, xp: 50, xpBound: 100, xpLevel: 0, gems: 0, energy: 0),currentIndex: 12, level: 0,showing: Binding.constant(true),firstTimeWin:false,beatMasterKenny:false)
    }
}
