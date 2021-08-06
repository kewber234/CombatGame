//
//  TutorialView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/29/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI
struct StatsTutorial: View{
    var body: some View{
        ZStack{
            Image("Temple").resizable().edgesIgnoringSafeArea(.all).opacity(0.4)
            ScrollView(.vertical){
                Text("There are five main attributes:\n").bold()
                Text("HEALTH is the amount of damage you can take before you lose a fight.\n").padding(.horizontal,8.2)
                Text("ATTACK is the amount of damage you deal to your opponent. This is a random number from 1/3 of your attack stat to your attack stat. For example, an attack stat of 60 would yield 20-60 damage dealt to your opponent each turn.\n").padding(.horizontal)
                Text("ACCURACY is the percent chance that you will land an attack, rather than missing.\n").padding(.horizontal)
                Text("ARMOUR is the amount of damage you can negate or subtract from your opponent's attack. It is a random number from 1 to your stat amount. For example, if your armour stat was 30 you would be able to negate 1-30 damage each turn from your opponents attack.\n").padding(.horizontal)
                Text("BLOCK is simply the percent chance that you will block your opponent's succesful attack, completely negating ALL damage.").padding(.horizontal)
            }.font(.system(size: 20)).offset(y:-40)
        }
    }
}
struct FightingTutorial: View{
    var body: some View{
        ZStack{
            Image("Temple").resizable().edgesIgnoringSafeArea(.all).opacity(0.4)
            ScrollView(.vertical){
                Text("Fights work like this:\n").bold()
                Text("In every fight, combat is simulated based on the attribute amounts and special abilities that you and your opponent possess. Both combatants attack and defend simotaneously and at the same speed. The results of such actions are shown on screen every turn.\n").padding(.horizontal)
                Text("The objective of every fight is to reduce your opponent's health to zero, while maintaing your own health above zero. Likewise, if your health is reduced to zero, you lose the fight. The exception to this rule is if you possess an item known as a regen. A regen will automatically restore your health to 50% should your health reach zero, allowing you to stay in the fight.").padding(.horizontal)
            }.font(.system(size: 20)).offset(y:-40)
        }
    }
}
struct GameModesTutorial: View{
    var body: some View{
        ZStack{
            Image("Temple").resizable().edgesIgnoringSafeArea(.all).opacity(0.4)
            ScrollView(.vertical){
                Text("There are two main game modes:\n").bold()
                Text("In CAMPAIGN mode, you can progress your way through 5 levels, each one harder than the last. Each level contains of 12 different combatants that you must defeat before you pass the level. Only once you win all 12 fights in a row, will you clear the level and unlock the next one. CAMPAIGN mode also grants one-time rewards for clearing levels for the first time.\n").padding(.horizontal)
                Text("In ENDLESS WAVES mode, there is no limit to your potential. Essentially, you keep fighting opponents until you lose a fight. Each progressive opponent gets stronger, and the goal is always to overtake your previous high score. ENDLESS WAVES also grants one-time rewards at certain score checkpoints").padding(.horizontal)
            }.font(.system(size: 20)).offset(y:-40)
        }
    }
}
struct CurrenciesTutorial: View{
    var body: some View{
        ZStack{
            Image("Temple").resizable().edgesIgnoringSafeArea(.all).opacity(0.4)
            ScrollView(.vertical){
                Text("There are 4 main types of currencies:\n").bold()
                Text("COINS are used for multiple uses during campaign and endless wave runs. They are generally obtained after defeating each opponent. Coins can be used to increase your attributes, used to buy regens, or deposited in the treasury to be grown afte each fight. But it is important to note that these upgrades are NOT PERMANENT. Rather, they only apply to that particular CAMPAIGN or ENDLESS WAVES run. Afterwards, your attributes will revert to your base stats.\n").padding(.horizontal)
                Text("GEMS are obtained through leveling up in XP or playing CAMPAIGN or ENDLESS WAVES, and can only be used outside of runs. They can be used to upgrade your base stats, buy or upgrade special abilities, or upgrade key functions like the treasury or wheel. Unlike coins, upgrades purchased using gems are PERMANENT, and their effects will apply to ALL future runs.\n").padding(.horizontal)
                Text("TICKETS are obtained solely through CAMPAIGN and ENDLESS WAVES runs, and similarly to coins do NOT lead to permanent upgrades. One ticket is obtained after every succesful fight, and can be used to spin the WHEEL. The WHEEL is a key function, and after spinning will provide you with a prize (or maybe not).\n").padding(.horizontal)
                Text("ENERGY is used to play the game. Both the CAMPAIGN and ENDLESS WAVES game modes require energy to play. Energy is reset every time you level up in XP, and also increments by one every 5 minutes.").padding(.horizontal)
            }.font(.system(size: 20)).offset(y:-40)
        }
    }
}
struct TutorialView: View {
    let g = LinearGradient(gradient: Gradient(colors: [.pinkMaroon,.orange2,.pinkMaroon]), startPoint: .topLeading, endPoint: .bottom)
    var body: some View {
        NavigationView{
            ZStack{
                Image("Temple").resizable().edgesIgnoringSafeArea(.all).opacity(0.4)
                VStack{
                    NavigationLink(destination: StatsTutorial()) {
                        Text("Attributes").bold().foregroundColor(.white).font(.system(size: 40)).frame(maxWidth:.infinity).frame(height:100).background(LinearGradient(gradient: Gradient(colors: [.pinkMaroon,.orange2,.pinkMaroon]), startPoint: .topLeading, endPoint: .bottom))
                    }
                    NavigationLink(destination: FightingTutorial()) {
                        Text("Combat").bold().foregroundColor(.white).font(.system(size: 40)).frame(maxWidth:.infinity).frame(height:100).background(LinearGradient(gradient: Gradient(colors: [.orange2,.orange2,.orange2,.pinkMaroon]), startPoint: .topLeading, endPoint: .bottom))
                    }
                    NavigationLink(destination: GameModesTutorial()) {
                        Text("Game Modes").bold().foregroundColor(.white).font(.system(size: 40)).frame(maxWidth:.infinity).frame(height:100).background(LinearGradient(gradient: Gradient(colors: [.pinkMaroon,.orange2,.pinkMaroon]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
                    NavigationLink(destination: CurrenciesTutorial()) {
                        Text("Currencies").bold().foregroundColor(.white).font(.system(size: 40)).frame(maxWidth:.infinity).frame(height:100).background(LinearGradient(gradient: Gradient(colors: [.pinkMaroon,.orange2]), startPoint: .topLeading, endPoint: .bottom))
                    }
                }.offset(y:-60)
            }
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
