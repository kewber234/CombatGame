//
//  StoreElementView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/25/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct StoreElementView: View {
    var name:String
    var image:String
    var text:String
    var level:Int
    var color:Color
    var sideLength:CGFloat
    var textSize:CGFloat
    @State private var showingDescription = false
    var body: some View {
        GeometryReader{geo in
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.white,self.color,self.color,.white,self.color,self.color,.white]), startPoint: .topTrailing, endPoint: .bottomLeading).frame(width:geo.size.width,height: geo.size.width).cornerRadius(20)
                VStack{
                    Text("\(self.name)").bold().font(.system(size: self.textSize)).offset(y:self.image == "Test Wheel" ? 10 : 0)
                        .minimumScaleFactor(0.01).foregroundColor(.black)//.font(.title).bold().foregroundColor(.black)
                    Image("\(self.image)").renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width:geo.size.width*self.sideLength).offset(y:self.image == "Test Wheel" ? -20 : 0)
                    if self.level != -1{
                        Text("LVL \(self.level)").font(.system(size: geo.size.height*0.08)).foregroundColor(.gray2).offset(y:self.image == "Test Wheel" ? -20 : 0)
                    }
                    
                }.blur(radius: self.showingDescription ? 10 : 0).opacity(self.showingDescription ? 0.5 : 1)
                HStack{
                    Image(systemName: "info.circle.fill").font(.system(size: 25)).foregroundColor(.gray2).offset(x: geo.size.width*0.02, y: geo.size.width*0.4).onTapGesture {
                        self.showingDescription.toggle()
                    }
                    Spacer()
                }
                if self.showingDescription{
                    Text(self.text).font(.system(size: geo.size.height*0.085)).padding().foregroundColor(.black)
                }
            }.position(x: geo.size.width/2, y:geo.size.height/2).edgesIgnoringSafeArea(.all)
        }
    }
    //func getSize()->CGFloat{

    //}
}

struct StoreElementView_Previews: PreviewProvider {
    static var previews: some View {
        StoreElementView(name: "Healing Aura", image: "Aura", text: "A shroud of mystical energy mysteriously heals you each turn. The more damaged you are, the more healing occurs.",level:3,color: .orange2,sideLength: 0.33,textSize: 30)
    }
}
