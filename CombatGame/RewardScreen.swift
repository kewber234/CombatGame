//
//  RewardScreen.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/11/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct RewardScreen: View {
    var coinNumber:Int
    var currentIndex: Int
    var level: Int
    var endless: Bool
    var coinMagnet:Int
    @State var size:CGFloat = 0
    @Binding var showingRewards:Bool
    var body: some View {
        GeometryReader{geo in
            ZStack{
                
                LinearGradient(gradient: Gradient(colors: [.maroon,.white,.maroon]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all)
                Text("VICTORY").font(.system(size: geo.size.width*0.2)).fontWeight(.bold).foregroundColor(.black).offset(y:-geo.size.height*0.37)
                VStack(spacing:90){
                    HStack(spacing:70){
                        ZStack{
                            Image("Ticket").resizable().aspectRatio(contentMode: .fit).frame(width:geo.size.width*0.5,height:geo.size.height*0.2).shadow(color: .black, radius: 5, x: 1, y: 1)
                            Text("1").font(.system(size: geo.size.height*0.1)).fontWeight(.black)
                        }
                        ZStack{
                            Image("Coin").resizable().frame(width:geo.size.height*0.2,height: geo.size.height*0.2).shadow(color: .black, radius: 5, x: 1, y: 1)
                            Text("\(coinNumber)").font(.system(size: geo.size.height*0.1)).fontWeight(.black)
                        }
                    }
                    HStack(spacing:20){
                        Text("XP").fontWeight(.black).font(.system(size: geo.size.height*0.14)).foregroundColor(.blue).shadow(color: .white, radius: 5, x: 0, y: 0)
                        if self.endless{
                            Text("3").font(.system(size: geo.size.height*0.1)).fontWeight(.black)
                        }
                        else{
                            Text("\(3+(currentIndex-1)+(4*level))").font(.system(size: geo.size.height*0.1)).fontWeight(.black)
                        }
                    }
                    if self.coinMagnet > 0{
                        HStack{
                            Image("Magnet").resizable().aspectRatio(contentMode: .fit).frame(width:geo.size.height*0.15)
                            Text("COIN MAGNET: +\(self.coinMagnet)").bold().font(.title)
                            Image("Magnet").resizable().aspectRatio(contentMode: .fit).frame(width:geo.size.height*0.15)
                        }
                    }
                }.scaleEffect(self.size).offset(y:30)
                
            }.frame(width: geo.size.width, height: geo.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).onAppear{
                withAnimation(Animation.interpolatingSpring(stiffness: 100, damping: 8)){
                    self.size += 0.66
                }
            }
            .onTapGesture {
                self.showingRewards = false
            }
        }
    }
}

struct RewardScreen_Previews: PreviewProvider {
    static var previews: some View {
        RewardScreen(coinNumber: 34,currentIndex: 1,level: 0,endless:true,coinMagnet: 3,showingRewards: Binding.constant(true))
    }
}
