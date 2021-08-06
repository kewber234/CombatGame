//
//  StatView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 4/16/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct StatView: View {
    var level:Int
    @State private var attack = 0
    @State private var health = 0
    @State private var accuracy = 0
    @State private var armour = 0
    @State private var block = 0
    @State private var type = 0
    @State private var points = 5
    @ObservedObject var main:fighter
    @ObservedObject var extraVariables:extras
    //let baselines = [1000,1000,1000,50,1000]
    //let baselines = [10,30,25,4,10]// first guy: 40, 100, 65, 2 ,25
    //var baselines:[Int]
    @Binding var showing:Bool{
        didSet{
            self.type = 0
            self.health = 2
            self.attack = 4
            self.accuracy = 4
            self.block = 1
            self.armour = 1
        }
    }
    let types = ["Offense","Defense","Balanced"]
    let levelPoints = [10, 5, 1, 3,3,5]//last one is endless waves
    let startingStats: [[Int]] = [[1,4,4,1,1],[4,1,0,3,3],[2,2,2,2,2]]
    let increments = [16,32,7,4,16]//attack,health,accuracy,block,armour
    var body: some View {
        GeometryReader{geo in
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.pinkMaroon,.white,.white,.white,.pinkMaroon]), startPoint: .topTrailing, endPoint: .bottomLeading).edgesIgnoringSafeArea(.all).opacity(0.8)
                VStack{

                    Picker(selection: self.$type.onChange(self.setStats), label: Text("Desired starting attribute type")) {
                        ForEach(0..<3){
                            Text((self.types[$0]))
                        }
                    }.pickerStyle(SegmentedPickerStyle()).border(Color.black, width: 1).offset(y:-geo.size.height*0.04)
                    VStack(spacing:geo.size.height*0.03){
                        
                        Text("Upgrade Points Remaining: \(self.points)").font(.custom("HiraKakuProN-W6", size: geo.size.height*0.029))
                        HStack(spacing:geo.size.height*0.08){
                            HStack{
                                Text("Health: \(self.extraVariables.baselines[1])").fixedSize()
                                Text("+\(self.health*self.increments[1])").foregroundColor(.green).fixedSize()
                            }
                            HStack{
                                Text("Attack: \(self.extraVariables.baselines[0])").fixedSize()
                                Text("+\(self.attack*self.increments[0])").foregroundColor(.green).fixedSize()
                            }
                        }.font(.custom("HiraKakuProN-W6", size: geo.size.height*0.02))
                        HStack(spacing:geo.size.height*0.08){
                            HStack{
                                Text("Block: \(self.extraVariables.baselines[3])").fixedSize()
                                Text("+\(self.block*self.increments[3])").foregroundColor(.green).fixedSize()
                            }
                            HStack{
                                Text("Armour: \(self.extraVariables.baselines[4])").fixedSize()
                                Text("+\(self.armour*self.increments[4])").foregroundColor(.green).fixedSize()
                            }
                        }.font(.custom("HiraKakuProN-W6", size: geo.size.height*0.02))
                        HStack{
                            HStack{
                                Text("Accuracy: \(self.extraVariables.baselines[2])").fixedSize()
                                Text("+\(self.accuracy*self.increments[2])").foregroundColor(.green).fixedSize()
                            }
                        }.font(.custom("HiraKakuProN-W6", size: geo.size.height*0.02))
                    }
                    ZStack{
                        Image(self.types[self.type]).resizable().frame(width:geo.size.width,height:geo.size.height*0.6).opacity(0.1)
                        VStack(spacing:30){
                            SingleStatView(statAmount: self.$health,points: self.$points, stat: "HTH ", image: "heart.fill", color: .red, start: self.startingStats[self.type][0],base: self.startingStats[self.type][0])
                            SingleStatView(statAmount: self.$attack,points: self.$points, stat: "ATK ", image: "eyedropper", color: .gray, start: self.startingStats[self.type][1],base: self.startingStats[self.type][1])
                            SingleStatView(statAmount: self.$accuracy,points: self.$points, stat: "ACC ", image: "smallcircle.fill.circle", color: .red,start: self.startingStats[self.type][2],base: self.startingStats[self.type][2])
                            SingleStatView(statAmount: self.$block,points: self.$points, stat: "BLK  ", image: "shield.fill", color: .blue, start: self.startingStats[self.type][3],base: self.startingStats[self.type][3])
                            SingleStatView(statAmount: self.$armour,points: self.$points, stat: "ARM ", image: "tray.2.fill", color: .gray, start: self.startingStats[self.type][4],base: self.startingStats[self.type][4])
                        }
                    }
                    
                    Text("CONFIRM").bold().font(.system(size: 20)).foregroundColor(.greyWhite).padding(14).padding(.horizontal,40).background(Color.gray2.opacity(0.8)).cornerRadius(20).onTapGesture {
                        Sounds.playSoundWAV(soundName: "gong")
                        self.main.attack = self.attack*self.increments[0]+self.extraVariables.baselines[0]
                        self.main.health = self.health*self.increments[1]+self.extraVariables.baselines[1]
                        self.main.accuracy = self.accuracy*self.increments[2]+self.extraVariables.baselines[2]
                        self.main.block = self.block*self.increments[3]+self.extraVariables.baselines[3]
                        self.main.armour = self.armour*self.increments[4]+self.extraVariables.baselines[4]
                        self.showing = false
                    }.offset(y:geo.size.height*0.0)
                    
                }
            }.onAppear{
                self.type = 0
                self.health = 1
                self.attack = 4
                self.accuracy = 4
                self.block = 1
                self.armour = 1
                self.points = self.levelPoints[self.level]
                self.main.regens = 0
            }
        }
    }
    func setStats(_ newValue: Int) {
        self.points = self.levelPoints[self.level]
        if self.type == 0{
            self.health = 1
            self.attack = 4
            self.accuracy = 4
            self.block = 1
            self.armour = 1
        }
        else if self.type == 1{
            self.health = 4
            self.attack = 1
            self.accuracy = 0
            self.block = 3
            self.armour = 3
        }
        else{
            self.health = 2
            self.attack = 2
            self.accuracy = 2
            self.block = 2
            self.armour = 2
        }
        
    }
}
extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView(level:0,main: fighter(health: 0, attack: 0, accuracy: 0, block: 0, armour: 0, money: 0, regens: 0),extraVariables: extras(),showing: Binding.constant(true))
    }
}
