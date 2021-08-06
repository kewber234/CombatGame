//
//  ShopConfirmationView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 4/23/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct ShopConfirmationView: View {
    @Binding var tf:Bool
    @Binding var stat:Int
    @Binding var cash:Int
    @Binding var price:Double
    @State private var purchaseAmt = 0.0
    @ObservedObject var main:fighter
    @State private var showingAlert = false
    @State private var statText = ""
    //@State private var showprice = 0.0
    @State private var sliderBound = 100.0
    @State private var sliderStep = 1.0
    var body: some View {
        GeometryReader{geo in
            ZStack{
                
                AlertView(bodyColors: [.maroon,.brown2,.maroon], headerColors: [.white,.greyWhite,.white])
                
                VStack(spacing:geo.size.height*0.025){
                    Text("\(self.price, specifier: "%.2f") GOLD / PT").font(.custom("HiraKakuProN-W6", size: 22)).bold().foregroundColor(.gray2).offset(y:-geo.size.height*0.05)
                    
                    Text("+ \(Int(self.purchaseAmt)) \(self.statText)").foregroundColor(.white).font(.custom("HiraKakuProN-W6", size: 35))
                    Slider(value:self.$purchaseAmt, in:0...self.sliderBound/*self.getRange()*/, step: self.sliderStep).frame(width:geo.size.width*0.7).background(Color.maroon.opacity(0.5)).cornerRadius(20).accentColor(Color.white)
                    HStack(spacing:0){
                        Image("Coin").resizable().aspectRatio(contentMode: .fit).frame(width:geo.size.width*0.07)
                        Text("  \(Int(self.purchaseAmt*self.price+0.5)/*self.getTotal()*/)").foregroundColor(.white).font(.custom("HiraKakuProN-W6", size: 30))
                    }
                    Button(action: {
                        if Int(self.purchaseAmt*self.price)/*self.getTotal()*/ <= self.main.money
                        {
                            if self.stat==0{
                                self.main.attack += Int(self.purchaseAmt)
                                self.cash -= Int(self.purchaseAmt*self.price+0.5)
                                self.tf = false
                            }
                            else if self.stat==1{
                                self.main.health += Int(self.purchaseAmt)
                                self.cash -= Int(self.purchaseAmt*self.price+0.5)
                                self.tf = false
                            }
                            else if self.stat==2{
                                self.main.accuracy += Int(self.purchaseAmt)
                                self.cash -= Int(self.purchaseAmt*self.price+0.5)
                                self.tf = false
                            }
                            else if self.stat==3{
                                self.main.armour += Int(self.purchaseAmt)
                                self.cash -= Int(self.purchaseAmt*self.price+0.5)
                                self.tf = false
                            }
                            else if self.stat==4{
                                if (Int(self.purchaseAmt)+(self.main.block)) <= 70{
                                    self.main.block += Int(self.purchaseAmt)
                                    self.cash -= Int(self.purchaseAmt*self.price+0.5)
                                    self.tf = false
                                }
                                else{
                                    self.showingAlert = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        self.showingAlert = false
                                        self.tf = false
                                    }
                                }
                            }
                            else{
                                self.main.regens += Int(self.purchaseAmt)
                                self.cash -= Int(self.purchaseAmt*self.price+0.5)
                                self.tf = false
                            }
                        }
                        else{
                            withAnimation{
                                self.showingAlert = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    self.showingAlert = false
                                    self.tf = false
                                }
                            }
                        }
                        
                    }) {
                        Text("CONFIRM").foregroundColor(.gray2).font(.system(size: 20)).fontWeight(.bold).padding(12).padding(.horizontal,5).background(Color.greyWhite).cornerRadius(40)
                        }.offset(y:geo.size.height*0.04).buttonStyle(animatedButton())
                }.blur(radius: self.showingAlert ? 3.0 : 0.0).opacity(self.showingAlert ? 0.5 : 1.0)
                if self.showingAlert{
                    Text(((Int(self.purchaseAmt))+(self.main.block)) <= 70 ? "INSUFFICIENT FUNDS" : "MAX BLOCK REACHED").bold().foregroundColor(.red).font(.system(size:33))
                }
                
            }
                .onAppear{
                if self.stat==0{
                    self.price = 1.0
                    self.statText = "ATK"
                    self.sliderBound = 100.0
                    self.sliderStep = 1.0
                }
                else if self.stat==1{
                    self.price = 0.5
                    self.statText = "HTH"
                    self.sliderBound = 200.0
                    self.sliderStep = 2.0
                }
                else if self.stat==2{
                    if self.main.accuracy <= 70{
                        self.price = 2.0
                    }
                    else if self.main.accuracy <= 90{
                        self.price = 3.0
                    }
                    else{
                        self.price = 4.0
                    }
                    self.statText = "ACC"
                    self.sliderBound = 50.0
                    self.sliderStep = 1.0
                }
                else if self.stat==3{
                    self.price = 1.0
                    self.statText = "ARM"
                    self.sliderBound = 100.0
                    self.sliderStep = 1.0
                }
                else if self.stat==4{
                    if self.main.block <= 20{
                        self.price = 4.0
                    }
                    else if self.main.block <= 40{
                        self.price = 5.0
                    }
                    else{
                        self.price = 6.0
                    }
                    self.statText = "BLK"
                    self.sliderBound = 25.0
                    self.sliderStep = 1.0
                }
                else{
                    self.price = 50.0
                    self.statText = "RGNS"
                    self.sliderBound = 5.0
                    self.sliderStep = 1.0
                }
            }
            
        }
        
    }
    func getRange()->Double{
        return Double(self.main.money)/self.price
    }
    /*func getTotal()->Int{
        if self.stat == 2 && self.purchaseAmt != 0{
            var t = 0
            for i in 1...Int(self.purchaseAmt){
                if (self.main.accuracy + i) > 0 && (self.main.accuracy + i) < 70{
                    self.showprice = 2.0
                    t += 2
                }
                else if (self.main.accuracy + i) >= 70 && (self.main.accuracy + i) < 90{
                    self.showprice = 3.0
                    t += 3
                }
                else{
                    self.showprice = 4.0
                    t += 4
                }
            }
            return t
        }
        else if self.stat == 4 && self.purchaseAmt != 0{
            var t2 = 0
            for i in 1...Int(self.purchaseAmt){
                if (self.main.block + i) < 20{
                    self.showprice = 4.0
                    t2 += 4
                }
                else if (self.main.block + i) < 40{
                    self.showprice = 5.0
                    t2 += 5
                }
                else{
                    self.showprice = 6.0
                    t2 += 6
                }
            }
            return t2
        }
        else{
            return Int(self.purchaseAmt*self.price+0.5)
        }
    }*/
}

struct ShopConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ShopConfirmationView(tf: Binding.constant(false),stat: Binding.constant(0),cash:Binding.constant(2),price: Binding.constant(3.0),main: fighter(health: 2, attack: 2, accuracy: 2, block: 2, armour: 2, money: 200, regens: 2))
    }
}
