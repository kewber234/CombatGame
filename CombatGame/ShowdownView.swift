//
//  ShowdownView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 4/26/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct ShowdownView: View {
    var oppImage:String
    var image:String
    var opp: fighter
    var oppName:String
    @Binding var showing:Bool
    @ObservedObject var main:fighter
    var body: some View {
        GeometryReader{geo in
            ZStack{
                
                Image(self.image).resizable().frame(width:geo.size.width,height: geo.size.height*0.5).position(x:geo.size.width*0.3,y:geo.size.height*0.8)
                Image(self.oppImage).resizable().frame(width:geo.size.width,height: geo.size.height*0.5).position(x:geo.size.width*0.7,y:geo.size.height*0.26)
                if self.oppImage == "Ninja Trio"{
                    Text("SHADOW SNEAK:\nCAN ONLY TAKE 1 \nDAMAGE AT A TIME").position(x:geo.size.width*0.8,y:geo.size.height*0.28).foregroundColor(.white).multilineTextAlignment(.center).font(.system(size: 13))
                }
                ZStack{
                    Image(systemName:"bolt.fill").font(.system(size:450,weight:.light)).foregroundColor(Color(red: 252/255, green: 255/255, blue: 142/255).opacity(0.4)).rotationEffect(Angle(degrees: 5))
                    Rectangle().frame(width: geo.size.width, height: 5)
                    
                }
                VStack{
                    ZStack{
                        Rectangle().frame(width:geo.size.width*0.6).foregroundColor(.greyWhite).opacity(0.8)
                        VStack(spacing:geo.size.height*0.005){
                
                                Text("\(self.oppName)").bold()
                            
                                HStack{
                                    Image("Heart").resizable().aspectRatio(contentMode: .fit).frame(width:40)
                                    Text("     \(self.opp.health)").fixedSize()
                                }.scaleEffect(geo.size.height/800)
                                HStack{
                                    Image("Swords").resizable().aspectRatio(contentMode: .fit).frame(width:50)
                                    Text("     \(self.opp.attack)").fixedSize()
                                }.scaleEffect(geo.size.height/800)
                            
                            
                                HStack{
                                    Image("Target").resizable().aspectRatio(contentMode: .fit).frame(width:50)
                                    Text("     \(self.opp.accuracy)").fixedSize()
                                }.scaleEffect(geo.size.height/800)
                                HStack{
                                    Image("Helmet").resizable().aspectRatio(contentMode: .fit).frame(width:40)
                                    Text("     \(self.opp.armour)").fixedSize()
                                }.scaleEffect(geo.size.height/800)
                            
                            
                                HStack{
                                    Image("Shield").resizable().aspectRatio(contentMode: .fit).frame(width:40)
                                    Text("     \(self.opp.block)").fixedSize()
                                }.scaleEffect(geo.size.height/800)
                            
                        }.font(.title)
                    }.offset(x:-geo.size.width*0.2)
                    
                    ZStack(alignment: .top){
                        Rectangle().frame(width:geo.size.width*0.6).foregroundColor(.greyWhite).opacity(0.8)
                        VStack(alignment: .center, spacing: geo.size.height*0.005){
                            Text("\(self.main.name)").bold()//.scaleEffect(geo.size.height/800)
                                HStack{
                                    Image("Heart").resizable().aspectRatio(contentMode: .fit).frame(width:40)
                                    Text("     \(self.main.health)").fixedSize()
                                }.scaleEffect(geo.size.height/800)
                                HStack{
                                    Image("Swords").resizable().aspectRatio(contentMode: .fit).frame(width:50)
                                    Text("     \(self.main.attack)").fixedSize()
                                }.scaleEffect(geo.size.height/800)
                            
                            
                                HStack{
                                    Image("Target").resizable().aspectRatio(contentMode: .fit).frame(width:50)
                                    Text("      \(self.main.accuracy)").fixedSize()
                                }.scaleEffect(geo.size.height/800)
                                HStack{
                                    Image("Helmet").resizable().aspectRatio(contentMode: .fit).frame(width:40)
                                    Text("     \(self.main.armour)").fixedSize()
                                }.scaleEffect(geo.size.height/800)
                            
                            
                                HStack{
                                    Image("Shield").resizable().aspectRatio(contentMode: .fit).frame(width:40)
                                    Text("     \(self.main.block)").fixedSize()
                                }.scaleEffect(geo.size.height/800)
                            Spacer()
                            
                        }.font(.title)//.scaleEffect(geo.size.height/800)
                        }.offset(x:geo.size.width*0.2)
                }
                
                
                
                
                /*Text("FIGHT").bold().font(.custom("HiraKakuProN-W6", size: 15)).foregroundColor(.greyWhite).padding(10).background(LinearGradient(gradient: Gradient(colors: [.gray2,.gray2,.greyWhite,.gray2,.gray2]), startPoint: .leading, endPoint: .trailing)).cornerRadius(30)*/
                
                
                
                
            }.background(LinearGradient(gradient: Gradient(colors: [.brown2,.greyWhite,.brown2]), startPoint: .topLeading, endPoint: .bottomTrailing)).edgesIgnoringSafeArea(.all)
        }
    }
}

struct ShowdownView_Previews: PreviewProvider {
    static var previews: some View {
        ShowdownView(oppImage: "Ninja Trio",image: "Mountain Giant",opp: fighter(health: 100, attack: 50, accuracy: 80, block: 3, armour: 45, money: 0, regens: 0),oppName: "Hello",showing: Binding.constant(true),main: fighter(health: 125, attack: 99, accuracy: 90, block: 12, armour: 90, money: 90, regens: 90))
    }
}
