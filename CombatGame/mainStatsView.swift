//
//  mainStatsView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/9/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct mainStatsView: View {

    let size:CGFloat = 30
    var height:CGFloat
    var width:CGFloat
    var hth:Int
    var atk:Int
    var acc:Int
    var arm:Int
    var blk:Int
    var rgn:Int
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.pinkMaroon,.greyWhite,.pinkMaroon]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all).frame(width:width,height:height)
            VStack(spacing:15){
                HStack(spacing:0){
                    HStack(spacing:1){
                        Text("HTH:").bold()
                        Text("\(hth)").bold().font(.system(size: size))
                    }
                    Spacer()
                    HStack(spacing:1){
                        Text("ATK:").bold()
                        Text("\(atk)").bold().font(.system(size: size))
                    }
                    Spacer()
                    HStack(spacing:1){
                        Text("ACC:").bold()
                        Text("\(acc)").bold().font(.system(size: size))
                    }
                }
                HStack(spacing:0){
                    HStack(spacing:1){
                        Text("ARM:").bold()
                        Text("\(arm)").bold().font(.system(size: size))
                    }
                    Spacer()
                    HStack(spacing:1){
                        Text("BLK:").bold()
                        Text("\(blk)").bold().font(.system(size: size))
                    }
                    Spacer()
                    HStack(spacing:1){
                        Text("RGN:").bold()
                        Text("\(rgn)").bold().font(.system(size: size))
                    }
                }
            }.padding(.horizontal,20)
            
        }
    }
}

struct mainStatsView_Previews: PreviewProvider {
    static var previews: some View {
        mainStatsView(height: 100,width: 100,hth: 1,atk: 1,acc: 1,arm: 1,blk: 1,rgn: 1)
    }
}
