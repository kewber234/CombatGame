//
//  CurrencyView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/7/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct CurrencyView: View {
    var image: String
    var number: Int
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Text("\(self.number)").font(.custom("HiraKakuProN-W6", size: 20)).frame(width:geo.size.width*0.2,height:geo.size.height*0.06).padding(.leading,20).padding(.trailing,5).background(Color.gray2).cornerRadius(0).foregroundColor(.white)
                Image(self.image).resizable().aspectRatio(contentMode: .fit).frame(height: self.image != "Lightning" ?  geo.size.height*0.07 : geo.size.height*0.08).offset(x: self.image != "Lightning" ? -geo.size.width*0.11 : -geo.size.width*0.1).rotation3DEffect(Angle(degrees: 5), axis: (x: 0, y: 1, z: 0))

            }.shadow(color: .gray2, radius: 3, x: 3, y: 1)
        }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView(image: "Coin",number: 300)
    }
}
