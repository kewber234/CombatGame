//
//  AlertView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/22/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct AlertView: View {
    var bodyColors:[Color]
    var headerColors:[Color]
    var body: some View {
        GeometryReader{geo in
            ZStack{
                LinearGradient(gradient: Gradient(colors: self.bodyColors), startPoint: .top, endPoint: .bottom).frame(width:geo.size.width*0.8,height:geo.size.height*0.55).cornerRadius(10)
                LinearGradient(gradient: Gradient(colors: self.headerColors), startPoint: .leading, endPoint: .trailing).frame(width:geo.size.width*0.8,height:geo.size.height*0.12).cornerRadius(5).position(x:geo.size.width/2,y:geo.size.height*0.282)
            }
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(bodyColors: [.greyWhite,.white], headerColors: [.pinkMaroon,.pinkMaroon])
    }
}
