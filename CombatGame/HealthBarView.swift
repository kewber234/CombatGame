//
//  HealthBarView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 4/27/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct HealthBarView: View {
    var name:String
    var originalHealth:Int
    var health:Int
    var body: some View {
        GeometryReader{ geo in
            
            ZStack{
                RoundedRectangle(cornerRadius: 30).frame(width:geo.size.width*0.92,height:geo.size.height*0.07).foregroundColor(.white).overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
                RoundedRectangle(cornerRadius: 30).frame(width:geo.size.width*0.92*self.getL(),height:geo.size.height*0.07).foregroundColor(.red).position(x: ((geo.size.width*self.getL()*0.92)/(2))+(0.04*geo.size.width), y: geo.size.height/2)
                    .animation(.default)
                Text("\(self.name)").font(.custom("HiraKakuProN-W6", size: 30)).position(x: geo.size.width*self.getNameMove(),y: geo.size.height*0.44)
                Text("\(self.health)").bold().position(x: geo.size.width*0.85,y: geo.size.height*0.5)
            }
        }
        
    }
    func getNameMove()->CGFloat{
        let length = CGFloat(self.name.count)
        return 0.85 - (length*0.017)
    }
    func getL()->CGFloat{
        let r = CGFloat(health)/CGFloat(originalHealth)
        if r>=0{
            return r
        }
        return 0
    }
    
}

struct HealthBarView_Previews: PreviewProvider {
    static var previews: some View {
        HealthBarView(name: "Training Partner", originalHealth: 6, health: 4)
    }
}
