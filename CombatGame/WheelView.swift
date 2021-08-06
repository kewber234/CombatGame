//
//  WheelView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 4/15/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI
import AVKit

struct animatedButton: ButtonStyle{
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .shadow(color: .black, radius: configuration.isPressed ? 5 : 15, x: 1, y: 1)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            
    }
}
struct WheelView: View {
    @State private var angle = 0.0
    @State private var timeInt = 0.02
    @State private var t:Timer?
    @ObservedObject var main:fighter
    @ObservedObject var mainAbilities:abilities
    @State private var showingAlert = false
    @State private var tempStr = ""
    @State private var showingInsufficientFunds = false
    @Binding var tickets:Int
    @State private var wonSomething = true
    @State private var buttonDisabled = false
    let cost = 25
    var body: some View {
        GeometryReader{geo in
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.maroon,.brown2,.pinkMaroon,.pinkMaroon,.brown2,.maroon]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
                CurrencyView(image: "Ticket", number: self.tickets).position(x: geo.size.width*0.67, y: geo.size.height*0.52)
                CurrencyView(image: "Coin", number: self.main.money).position(x: geo.size.width*1.1, y: geo.size.height*0.52)
                mainStatsView(height: 100, width: geo.size.width, hth: self.main.health, atk: self.main.attack, acc: self.main.accuracy, arm: self.main.armour, blk: self.main.block, rgn: self.main.regens).position(x:geo.size.width/2,y:geo.size.height*0.75)
                
                Image("Test Wheel").resizable().frame(width:geo.size.width*0.85,height:geo.size.width*0.85)/*.rotationEffect(Angle(degrees: self.angle))*/
                    .rotationEffect(Angle(degrees: self.angle), anchor: .center)
                    .animation(Animation.default).shadow(color: .black, radius: 15, x: 0, y: 6)
                    .position(x: geo.size.width/2, y: geo.size.height*0.39)
                
                Button(action: {
                    self.buttonDisabled = true
                    Sounds.playSound(soundName:"click")
                    /*self.main.health = 1
                    self.main.attack = 1
                    self.main.armour = 1
                    self.main.accuracy = 1
                    self.main.block = 1*/
                    if self.tickets >= 1
                    {
                        self.tickets -= 1
                        self.t = Timer.scheduledTimer(withTimeInterval: self.timeInt,repeats: true, block: {_ in
                            
                            self.angle += 17
                            self.timeInt += 0.01
                            if self.timeInt >= Double.random(in: 1.0...2.0){
                                self.t?.invalidate()
                                self.buttonDisabled = false
                                self.angle=0
                                self.timeInt = 0.02
                                self.tempStr = self.reward()
                                self.showingAlert = true
                            }
                            
                        })
                    }
                    else{
                        withAnimation{
                            self.showingInsufficientFunds = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.buttonDisabled = false
                                self.showingInsufficientFunds = false
                            }
                        }
                        
                    }
                    
                })
                {
                    Text("SPIN").bold().padding(15).padding(.horizontal,15).foregroundColor(.black).font(.system(size: 25)).background(LinearGradient(gradient: Gradient(colors: [.white,.greyWhite,.greyWhite,.white,.greyWhite,.greyWhite,.white]), startPoint: .topTrailing, endPoint: .bottomLeading)).cornerRadius(120)
                }.position(x:geo.size.width/2,y:geo.size.height*0.9)
                    .buttonStyle(animatedButton())
            }.blur(radius: self.showingInsufficientFunds ? 3.0 : 0.0).opacity(self.showingInsufficientFunds ? 0.5 : 1.0).alert(isPresented: self.$showingAlert) {
                Alert(title: Text(self.wonSomething ? "YOU WON" : "SORRY"), message: Text("\(self.tempStr)"), dismissButton: .default(Text("continue")))
            }.disabled(self.buttonDisabled)
            if self.showingInsufficientFunds{
                Text("INSUFFICIENT FUNDS").bold().foregroundColor(.red).font(.system(size:33)).position(x:geo.size.width/2,y:geo.size.height/2)
            }
        }
        
    }
    func reward()->String{
        let num = Int.random(in: 0..<100)
        let num2 = Int.random(in: 0..<100)
        var str = ""
        var temp = 0
        if num>25{
            if num2 <= 16{
                self.wonSomething = true
                temp = mainAbilities.healthReward()
                main.health += temp
                str = "\(temp) HEALTH!"
            }
            else if num2 > 16 && num2 <= 32{
                self.wonSomething = true
                temp = mainAbilities.attackReward()
                main.attack += temp
                str = "\(temp) ATTACK!"
            }
            else if num2 > 32 && num2 <= 48{
                self.wonSomething = true
                temp = mainAbilities.accuracyReward()
                if (self.main.accuracy + temp) <= 100{
                    main.accuracy += temp
                }
                else{
                    main.accuracy = 100
                }
                str = "\(temp) ACCURACY!"
            }
            else if num2 > 48 && num2 <= 64{
                self.wonSomething = true
                temp = mainAbilities.blockReward()
                if (self.main.block + temp) <= 70{
                    main.block += temp
                }
                else{
                    main.block = 70
                }
                str = "\(temp) BLOCK!"
            }
            else if num2 > 64 && num2 <= 80{
                self.wonSomething = true
                temp = mainAbilities.armourReward()
                main.armour += temp
                str = "\(temp) ARMOUR!"
            }
            else if num2 > 80 && num2 <= 96{
                self.wonSomething = true
                temp = mainAbilities.goldReward()
                main.money += temp
                str = "\(temp) GOLD!"
            }
            else {
                self.wonSomething = true
                main.regens += 1
                str = "A REGEN!"
            }
        }
        else{
            self.wonSomething = false
            str = "you won nothing"
        }
        return str
    }
}

struct WheelView_Previews: PreviewProvider {
    static var previews: some View {
        WheelView(main: fighter(health: 200, attack: 200, accuracy: 200, block: 20, armour: 200, money:100, regens:5),mainAbilities: abilities(pierce: 0, crit: 0, heal: 0, magnet: 0, poison: 0, wheel: 9),tickets: Binding.constant(3))
    }
}
