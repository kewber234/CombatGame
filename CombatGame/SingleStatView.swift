//
//  SingleStatView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 4/17/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct SingleStatView: View {
    @Binding var statAmount:Int
    @Binding var points:Int
    var stat:String
    var image:String
    var color:Color
    var start:Int
    var base:Int
    
    var body: some View {
        
        HStack{
            Text("\(self.stat)").font(.custom("HiraKakuProN-W6", size: 15))
            ForEach(0..<self.statAmount, id: \.self){ x in
                Image(systemName: self.image).foregroundColor(self.color).opacity(x+1 > self.start ? 0.5 : 1.0)
            }
            
            Stepper(onIncrement: {
                if self.points >= 1{
                    self.points -= 1
                    self.statAmount += 1
                }
            }, onDecrement: {
                if self.statAmount>self.base{
                    self.points+=1
                    self.statAmount -= 1
                }
            }) {
                Text("")
            }
        }.padding(.horizontal,20).font(.system(size:18))
        
        
    }
    
    struct SingleStatView_Previews: PreviewProvider {
        static var previews: some View {
            SingleStatView(statAmount: Binding.constant(3),points: Binding.constant(1), stat: "Health", image: "heart.fill", color: .red, start: 3,base: 3)
        }
    }
}
