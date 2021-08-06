//
//  XPBarView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/16/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct XPBarView: View {
    @ObservedObject var mainCurrencies: currencies
    var body: some View {
        GeometryReader{ geo in
            
            ZStack{
                RoundedRectangle(cornerRadius: 10).frame(width:geo.size.width*0.3,height:geo.size.height*0.06).foregroundColor(.gray2).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1)).position(x: geo.size.width*0.19, y: geo.size.height/2).shadow(color: .gray2, radius: 3, x: 3, y: 1)
                RoundedRectangle(cornerRadius: 10).frame(width:geo.size.width*0.3*self.getL(),height:geo.size.height*0.06).foregroundColor(.blue).position(x: ((geo.size.width*self.getL()*0.3)/(2))+(geo.size.width*0.04), y: geo.size.height/2)
                    .animation(.default)
                Text("\(self.mainCurrencies.xp)/\(self.mainCurrencies.xpBound)").bold().position(x: geo.size.width*0.26,y: geo.size.height*0.5).foregroundColor(.greyWhite).font(.system(size:13))
                Text("\(self.mainCurrencies.xpLevel)").font(.system(size: 38, weight: .black )).foregroundColor(.blue).position(x: geo.size.width*0.09, y: geo.size.height/2).shadow(color: .white, radius: 5, x: 0, y: 0)
            }
            
        }
    }
    func getL()->CGFloat{
        let r = CGFloat(self.mainCurrencies.xp)/CGFloat(self.mainCurrencies.xpBound)
        if r>=0{
            return r
        }
        return 0
    }
}

struct XPBarView_Previews: PreviewProvider {
    static var previews: some View {
        XPBarView(mainCurrencies: currencies(treasuryLevel: 0, coinsStored: 0, xp: 90, xpBound: 100,xpLevel: 1,gems: 0, energy: 0))
    }
}
