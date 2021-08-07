//
//  ShopView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 4/23/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct ShopView: View {
    @ObservedObject var main:fighter
    @State private var showingConfirmation = false
    @State var ID = -1
    @State private var p = 0.0
    @State private var buttonsDisabled:[Bool] = [false,false,false,false,false,false]
    var tickets:Int
    var body: some View {
        GeometryReader{geo in
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [.brown2,.pinkMaroon,.brown2]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
                        CurrencyView(image: "Ticket", number: self.tickets).position(x: geo.size.width*0.67, y: geo.size.height*0.5)
                    CurrencyView(image: "Coin", number: self.main.money).position(x: geo.size.width*1.1, y: geo.size.height*0.5)
                    VStack{
                        VStack(spacing:geo.size.height*0.02){
                        
                            HStack(spacing:geo.size.width*0.07){
                                ShopElementView(proxyID: 0,image: "Swords", attribute: "Attack", price: 1.0,tapped: self.$showingConfirmation,ID: self.$ID,disabled: self.buttonsDisabled[0],buttonsDisabled: self.$buttonsDisabled)
                                ShopElementView(proxyID: 1,image: "Heart", attribute: "Health", price: 0.5,tapped: self.$showingConfirmation,ID: self.$ID,disabled: self.buttonsDisabled[1],buttonsDisabled: self.$buttonsDisabled)
                            }.padding(.horizontal,geo.size.width*0.06)
                            HStack(spacing:geo.size.width*0.07){
                                ShopElementView(proxyID: 2,image: "Target", attribute: "Accuracy", price: 2.0,tapped: self.$showingConfirmation,ID: self.$ID,disabled: self.buttonsDisabled[2],buttonsDisabled: self.$buttonsDisabled)
                                ShopElementView(proxyID: 3,image: "Helmet", attribute: "Armour", price: 1.0,tapped: self.$showingConfirmation,ID: self.$ID,disabled: self.buttonsDisabled[3],buttonsDisabled: self.$buttonsDisabled)
                            }.padding(.horizontal,geo.size.width*0.06)
                            HStack(spacing:geo.size.width*0.07){
                                ShopElementView(proxyID: 4,image: "Shield", attribute: "Block", price: 4.0,tapped: self.$showingConfirmation,ID: self.$ID,disabled: self.buttonsDisabled[4],buttonsDisabled: self.$buttonsDisabled)
                                ShopElementView(proxyID: 5,image: "Regen", attribute: "Regen", price: 50.0,tapped: self.$showingConfirmation,ID: self.$ID,disabled: self.buttonsDisabled[5],buttonsDisabled: self.$buttonsDisabled)
                            }.padding(.horizontal,geo.size.width*0.06)
                            
                        }.padding(.top,geo.size.height/10.6).padding(.vertical,10)//.shadow(color: .black, radius: 15, x: 1, y: 1)
                        mainStatsView(size:geo.size.height*0.045,height: geo.size.height*0.2, width: geo.size.width, hth: self.main.health, atk: self.main.attack, acc: self.main.accuracy, arm: self.main.armour, blk: self.main.block, rgn: self.main.regens)
                    }.blur(radius: self.showingConfirmation ? 3 : 0).onTapGesture {
                        self.showingConfirmation = false
                        self.allButtonsAble()
                    }
                    
                    if(self.showingConfirmation){
                        ZStack{
                            ShopConfirmationView(tf: self.$showingConfirmation, stat: self.$ID, cash: self.$main.money, price: self.$p,main: self.main).onDisappear{
                                self.allButtonsAble()
                            }
                            Image(systemName: "xmark.square.fill").font(.system(size: 30)).position(x:geo.size.width*0.17,y:geo.size.height*0.26).foregroundColor(.red).onTapGesture {
                                self.showingConfirmation = false
                                self.allButtonsAble()
                            }
                        }
                    }
                }
        }
    }
    func allButtonsAble(){
        self.buttonsDisabled[0] = false
        self.buttonsDisabled[1] = false
        self.buttonsDisabled[2] = false
        self.buttonsDisabled[3] = false
        self.buttonsDisabled[4] = false
        self.buttonsDisabled[5] = false
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView(main: fighter(health: 343, attack: 127, accuracy: 100, block: 27, armour: 45, money: 126, regens: 7),tickets:3)
    }
}
