//
//  SettingsView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/23/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct CreditsView: View{
    @State private var position:CGFloat = 1.5
    var body: some View{
        GeometryReader{geo in
            ZStack{
                Image("Temple").resizable().edgesIgnoringSafeArea(.all).opacity(0.4)
                VStack(spacing:60){
                    VStack(spacing:12){
                        Text("Executive Producer").bold()
                        Text("Kenneth Yamashita")
                    }
                    VStack(spacing:12){
                        Text("Game Designer / Developer").bold()
                        Text("Kenneth Yamashita")
                    }
                    VStack(spacing:12){
                        Text("Music").bold()
                        Text("Bryan Guo")
                    }
                    VStack(spacing:12){
                        Text("Images and Assets").bold()
                        Text("Pixaby.com")
                    }
                    VStack(spacing:12){
                        Text("Sound").bold()
                        Text("freesound.org")
                    }
                }.font(.system(size: geo.size.height*0.04)).position(x: geo.size.width/2, y: geo.size.height*self.position)
            }.onAppear{
                withAnimation(Animation.linear(duration: 10)){
                    self.position = 0.4
                }
            }
        }
    }
}
struct NameView: View{
    @ObservedObject var main:fighter
    @Binding var showing:Bool
    @State private var name = ""
    @State var error = false
    var body: some View{
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.maroon,.brown2,.pinkMaroon,.maroon,.brown2]), startPoint: .topTrailing, endPoint: .bottomLeading).edgesIgnoringSafeArea(.all)
            VStack(spacing:100){
                Text("Enter new username:").font(.custom("HiraKakuProN-W6", size: 26)).bold().foregroundColor(.white)
                VStack(spacing:10){
                    TextField("", text: self.$name).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal,40)
                    
                    if self.error{
                        Text("Name should not exceed 10 characters").foregroundColor(.red)
                    }
                }
                Text("confirm").foregroundColor(.white).padding().background(Color.gray2).cornerRadius(25)
                        .font(.custom("HiraKakuProN-W6", size: 20))
                        .onTapGesture {
                            if self.name.count <= 10{
                                self.main.name = self.name
                                self.showing = false
                            }
                            else{
                                self.error = true
                            }
                }
            }.offset(y:-50)
        }
    }
}
struct SettingsView: View {
    @ObservedObject var main:fighter
    @ObservedObject var mainCurrencies:currencies
    @ObservedObject var mainAbilities:abilities
    @ObservedObject var extraVariables:extras
    @Binding var musicOn:Bool
    @State private var fakeShowing = true
    @State private var showingNameView = false
    let g = LinearGradient(gradient: Gradient(colors: [.gray2,.greyWhite,.white,.greyWhite,.gray2]), startPoint: .topTrailing, endPoint: .bottomLeading)
    var body: some View {
        NavigationView{
            GeometryReader{geo in
                ZStack{
                    Image("Temple").resizable().edgesIgnoringSafeArea(.all).opacity(0.4)
                    Text("SETTINGS").fontWeight(.black).font(.custom("Zapfino", size: geo.size.width*0.09)).position(x: geo.size.width/2, y: -geo.size.height*0.05)
                    Toggle(isOn: self.$musicOn){
                        Text("Sound FX").bold().font(.system(size: geo.size.height*0.05))
                    }.padding(.horizontal,geo.size.width*0.25).position(x: geo.size.width/2, y: geo.size.height*0.4)
                    Toggle(isOn: self.$musicOn){
                        Text("Music").bold().font(.system(size: geo.size.height*0.05))
                    }.padding(.horizontal,geo.size.width*0.3).position(x: geo.size.width*0.55, y: geo.size.height*0.26)
                    ZStack{
                        Rectangle().frame(width:geo.size.width*0.85,height:geo.size.height*0.08).foregroundColor(.gray2).cornerRadius(5)
                        HStack(spacing:20){
                            Text(self.main.name).foregroundColor(.white).font(.system(size:geo.size.height*0.05)).padding(.horizontal)
                            NavigationLink(destination: NameView(main: self.main, showing: self.$showingNameView),isActive: self.$showingNameView) {
                                Text("EDIT").foregroundColor(.blue)
                            }
                        }
                    }.position(x: geo.size.width/2, y: geo.size.height*0.113)
                    NavigationLink(destination: CreditsView()) {
                        Text("Credits").bold().frame(width:geo.size.width*0.8,height:geo.size.height*0.135).background(self.g).cornerRadius(40).foregroundColor(.gray2).font(.system(size: geo.size.height*0.06))
                    }.position(x: geo.size.width/2, y: geo.size.height*0.73)
                    NavigationLink(destination: TutorialView()) {
                        Text("How To Play").bold().frame(width:geo.size.width*0.8,height:geo.size.height*0.135).background(self.g).cornerRadius(40).foregroundColor(.gray2).font(.system(size: geo.size.height*0.06))
                    }.position(x: geo.size.width/2, y: geo.size.height*0.58)
                    Text("Reset Data").bold().frame(width:geo.size.width*0.8,height:geo.size.height*0.135).background(self.g).cornerRadius(40).foregroundColor(.gray2).font(.system(size: geo.size.height*0.06)).position(x: geo.size.width/2, y: geo.size.height*0.88).onTapGesture {
                        self.clearData()
                    }
                    
                    
                    }
            }.onDisappear{
                if self.musicOn == false{
                    Sounds.stopAll()
                }
            }
        }
    }
    func clearData(){
        
        self.mainCurrencies.treasuryLevel = 1
        self.mainCurrencies.xp = 0
        self.mainCurrencies.xpBound = 300
        self.mainCurrencies.xpLevel = 1
        self.mainCurrencies.gems = 0
        self.mainCurrencies.energy = 20
        self.mainCurrencies.coinsStored = 0
        
        self.mainAbilities.piercingShotLevel = 0
        self.mainAbilities.criticalStrikeLevel = 0
        self.mainAbilities.healingAuraLevel = 0
        self.mainAbilities.coinMagnetLevel = 0
        self.mainAbilities.poisonDaggerLevel = 0
        self.mainAbilities.wheelLevel = 1
        
        self.extraVariables.baselines = [10,30,25,4,10]
        self.extraVariables.highScores = [0,0,0,0,0,0]
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(main: fighter(health: 0, attack: 0, accuracy: 0, block: 0, armour: 0, money: 0, regens:  0),mainCurrencies: currencies(treasuryLevel: 0, coinsStored: 0, xp: 0, xpBound: 0, xpLevel: 0, gems: 0, energy: 0),mainAbilities: abilities(pierce: 0, crit: 0, heal: 0, magnet: 0, poison: 0, wheel: 0),extraVariables: extras(),musicOn: Binding.constant(true))
    }
}
