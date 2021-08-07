//
//  EndlessDeathScreen.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/22/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct EndlessDeathScreen: View {
    @ObservedObject var mainCurrencies:currencies
    @ObservedObject var extraVariables:extras
    var numWins: Int
    @State var size:CGFloat = 0
    @Binding var showing:Bool
    @State private var showingLevelUp = false
    var previousHighScore:Int
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.brown2,.white,.white,.brown2]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all)
            Text("GAME OVER").font(.system(size:60)).fontWeight(.bold).foregroundColor(.black).offset(y:-250).multilineTextAlignment(.center)
            /*VStack(spacing:90){
                HStack(spacing:20){
                    Text("XP").fontWeight(.black).font(.system(size: 90)).foregroundColor(.blue).shadow(color: .white, radius: 5, x: 0, y: 0)
                    Text("\(self.getXPGain())").font(.system(size: 60)).fontWeight(.black)
                }
                HStack(spacing:25){
                        Image("Diamond").resizable().frame(width:110,height: 110).shadow(color: .black, radius: 5, x: 1, y: 1)
                        Text("\(self.getDiamondGain())").font(.system(size: 70)).fontWeight(.black)
                }
                Text("Fights Won \n\(self.numWins-1)").font(.system(size: 50)).multilineTextAlignment(.center)
            
                
                }.scaleEffect(self.size).offset(y: 20)*/
            VStack(spacing:50){
                //if self.currentIndex != 12{
                
                    ZStack{
                        
                        Circle().frame(width:350,height:350).foregroundColor(Color.gray2.opacity(0.7))
                        Text("Fights Won").font(.system(size: 40)).multilineTextAlignment(.center).foregroundColor(.white).offset(y:-70)
                        Text("\((self.numWins-1))").fontWeight(.black).foregroundColor(.white).font(.system(size: 140)).offset(y:10)
                    }.offset(y:30)
                
                //}
                HStack(spacing:50){
                    HStack(spacing:20){
                        Text("XP").fontWeight(.black).font(.system(size: 90)).foregroundColor(.blue).shadow(color: .white, radius: 5, x: 0, y: 0)
                        Text("\(self.getXPGain())").font(.system(size: 60)).fontWeight(.black)
                    }.fixedSize()
                    HStack(spacing:25){
                        Image("Diamond").resizable().frame(width:90,height: 90).shadow(color: .black, radius: 5, x: 1, y: 1)
                        Text("\(self.getDiamondGain())").font(.system(size: 70)).fontWeight(.black)
                    }.fixedSize()
                }
                if self.getBonusReward() > 0{
                    VStack{
                        HStack{
                            Image(systemName: "star.fill").foregroundColor(.yellow).offset(y:6)
                            Image(systemName: "star.fill").foregroundColor(.yellow).offset(y:3)
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                            Text("CHECKPOINT BONUS").font(.system(size: 30)).fixedSize()
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                            Image(systemName: "star.fill").foregroundColor(.yellow).offset(y:3)
                            Image(systemName: "star.fill").foregroundColor(.yellow).offset(y:6)
                        }
                        HStack{
                            Image("Diamond").resizable().frame(width:50,height:50)
                            Text("\(self.getBonusReward())").font(.system(size: 30))
                        }
                    }
                }
            }.offset(y: self.getBonusReward() > 0 ? 40 : 0).scaleEffect(self.size)
            if self.showingLevelUp{
                LevelUpScreen(mainCurrencies: self.mainCurrencies, showing: self.$showingLevelUp).onDisappear{
                    self.showing = false
                }
            }
            
        }.onAppear{
            withAnimation(Animation.linear(duration: 0.7)){
                self.size += 0.7
            }
        }
        .onTapGesture {
            self.mainCurrencies.gems += self.getDiamondGain()
            self.mainCurrencies.gems += self.getBonusReward()
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
        return 3*(self.numWins-1)//numwins is just oppIndex
    }
    func getDiamondGain()->Int{
        return getXPGain()/20
    }
    func getBonusReward()->Int{
        if self.previousHighScore < (self.numWins-1){
            var count = 0
            for i in (self.previousHighScore)...(self.numWins-1){
                if i%5 == 0 && i != 0{
                    count += 1
                }
            }
            return count*5
        }
        else{
            return 0
        }
    }
}

struct EndlessDeathScreen_Previews: PreviewProvider {
    static var previews: some View {
        EndlessDeathScreen(mainCurrencies: currencies(treasuryLevel: 0, coinsStored: 0, xp: 0, xpBound: 0, xpLevel: 0, gems: 0, energy: 0),extraVariables:extras()  ,numWins: 6, showing: Binding.constant(true),previousHighScore: 3)
    }
}
