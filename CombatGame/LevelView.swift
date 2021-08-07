//
//  LevelView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/3/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct LevelView: View {
    var lvl:String
    var levelsPassed:Int
    var completed:Bool
    var locked:Bool
    var body: some View {
        GeometryReader{geo in
            ZStack{
                VStack{
                    Text("\(self.lvl)").foregroundColor(.black).fontWeight(.black).font(.custom("HiraKakuProN-W6", size: geo.size.height*0.045))
                    
                    
                    HStack(spacing:0){
                        ForEach(1..<13){
                            Text("\($0)").frame(width:20,height:20).background($0<=self.levelsPassed ? Color.brightYellow : Color.greyWhite.opacity(0.5)).clipShape(Circle()).overlay(Circle().stroke(Color.black, lineWidth: 2))
                            if $0 != 12{
                                Rectangle().frame(width:geo.size.height*0.01,height:geo.size.height*0.01)
                            }
                        }
                    }
                    
                }.frame(width:geo.size.width*0.96,height:geo.size.height*0.13).background(LinearGradient(gradient: Gradient(colors: [.pinkMaroon,.greyWhite,.pinkMaroon]), startPoint: .top, endPoint: .bottom)).cornerRadius(20).colorMultiply(self.locked ? Color.gray :Color.white).blur(radius: self.locked||self.completed ? 1 : 0).opacity(self.locked ? 0.85 : 1.0)
                if self.locked{
                    Image(systemName: "lock.fill").scaleEffect(4.0)
                }
                if self.completed{
                    Text("COMPLETE").fontWeight(.black).foregroundColor(Color(red: 177/255, green: 255/255, blue: 168/255)).font(.system(size: 50)).rotationEffect(Angle(degrees: -6))
                }
            }
            
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView(lvl: "DIFFICULT",levelsPassed: 0,completed: false,locked: false)
    }
}
