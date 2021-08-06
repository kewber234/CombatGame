//
//  UpgradeConfirmationView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/27/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct UpgradeConfirmationView: View {
    @ObservedObject var mainCurrencies:currencies
    @ObservedObject var mainAbilities:abilities
    //@Binding var baselines:[Int]//atk,hth,acc,blk,arm
    @ObservedObject var extraVariables:extras
    var title:String
    var current:String
    var upgraded:String
    var price:Int
    var index:String
    @Binding var showing:Bool
    @State private var insufficientFunds = false
    var body: some View {
        GeometryReader{geo in
            ZStack{
                ZStack{
                AlertView(bodyColors: [.white,.greyWhite,.greyWhite,.white], headerColors: [.gray2,.gray2])
                Text(self.title).foregroundColor(.greyWhite).font(.system(size: geo.size.height*0.05)).position(x: geo.size.width/2, y: geo.size.height*0.28)
                VStack(spacing:5){
                    Text(self.current).bold().foregroundColor(.gray2)
                    Image(systemName: "arrow.down").foregroundColor(.green)
                    Text(self.upgraded).bold()
                }.font(.system(size: geo.size.height*0.065)).foregroundColor(.gray2)
                Button(action: {
                    if self.mainCurrencies.gems >= self.price{
                            self.mainCurrencies.gems -= self.price//put this into individuals
                            if self.index == "hth"{
                                self.extraVariables.baselines[1] += 10
                            }
                            else if self.index == "atk"{
                                self.extraVariables.baselines[0] += 4
                            }
                            else if self.index == "acc"{
                                self.extraVariables.baselines[2] += 2
                            }
                            else if self.index == "arm"{
                                self.extraVariables.baselines[4] += 5
                            }
                            else if self.index == "blk"{
                                if self.extraVariables.baselines[3] <= 69{
                                    self.extraVariables.baselines[3] += 1
                                }
                                else{
                                    self.activateInsufficientFunds()
                                }
                            }
                            else if self.index == "heal"{
                                self.mainAbilities.healingAuraLevel += 1
                            }
                            else if self.index == "poison"{
                                self.mainAbilities.poisonDaggerLevel += 1
                            }
                            else if self.index == "pierce"{
                                self.mainAbilities.piercingShotLevel += 1
                            }
                            else if self.index == "crit"{
                                self.mainAbilities.criticalStrikeLevel += 1
                            }
                            else if self.index == "magnet"{
                                self.mainAbilities.coinMagnetLevel += 1
                            }
                            else if self.index == "wheel"{
                                self.mainAbilities.wheelLevel += 1
                            }
                            else if self.index == "treasury"{
                                self.mainCurrencies.treasuryLevel += 1
                            }
                            self.showing = false
                        
                    }
                    else{
                        self.activateInsufficientFunds()
                    }
                }) {
                    HStack{
                        Image("Diamond").renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width:geo.size.height*0.06)
                        Text("\(self.price)").foregroundColor(.white).font(.system(size: geo.size.height*0.04)).fixedSize()
                    }.padding(8).padding(.horizontal).background(Color.gray2).cornerRadius(20)
                }.position(x: geo.size.width/2, y: geo.size.height*0.69).buttonStyle(animatedButtonNoShadow())
                }.colorMultiply(Color.white)
                if self.insufficientFunds{
                    if self.index == "blk" && self.extraVariables.baselines[3] >= 70{
                        Text("MAX BLOCK REACHED").bold().font(.title).foregroundColor(.red)
                    }
                    else{
                        Text("INSUFFICIENT FUNDS").bold().font(.title).foregroundColor(.red)
                    }
                }
            }
        }
    }
    func activateInsufficientFunds()->Void{
        self.insufficientFunds = true
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.insufficientFunds = false
            self.showing = false
        }
    }
}

struct UpgradeConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        UpgradeConfirmationView(mainCurrencies: currencies(treasuryLevel: 0, coinsStored: 0, xp: 0, xpBound: 0, xpLevel: 0, gems: 0, energy: 0), mainAbilities: abilities(pierce: 0, crit: 0, heal: 0, magnet: 0, poison: 0, wheel: 0),extraVariables: extras(), title: "Damage Range", current: "1-3", upgraded: "2-6",price: 12 ,index: "poison",showing: Binding.constant(true))
    }
}
