//
//  ShopElementView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 4/23/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI
import AVKit

struct ShopElementView: View {
    var proxyID:Int
    var image:String
    var attribute:String
    var price:Double
    @Binding var tapped:Bool
    @Binding var ID:Int
    var disabled:Bool
    @Binding var buttonsDisabled:[Bool]
    var body: some View {
        GeometryReader{geo in
            Button(action: {
                Sounds.playSound(soundName: "realclick")
                self.ID=self.proxyID
                self.tapped = true
                for i in 0...5{
                    if self.ID != i{
                        self.buttonsDisabled[i] = true
                    }
                }
            }) {
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [.white,.greyWhite,.greyWhite,.white,.greyWhite,.greyWhite,.white]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    VStack{
                        Text("\(self.attribute)").font(.title)/*.font(.custom("HiraKakuProN-W6", size: self.attribute == "Accuracy" ? 30 : 35))*/.bold().foregroundColor(.black)
                        Image(self.image).renderingMode(.original).resizable().frame(width:geo.size.width*0.7,height:geo.size.height*0.6).offset(y: self.image == "Swords" ? -10 : 0)
                        
                    }
                }.cornerRadius(20)
            }.buttonStyle(animatedButton()).disabled(self.disabled)
            /*ZStack{
                LinearGradient(gradient: Gradient(colors: [.white,.greyWhite,.greyWhite,.white,.greyWhite,.greyWhite,.white]), startPoint: .topTrailing, endPoint: .bottomLeading)
                VStack{
                    Text("\(self.attribute)").font(.custom("HiraKakuProN-W6", size: self.attribute == "Accuracy" ? 30 : 35)).bold()
                    Image(self.image).resizable().frame(width:geo.size.width*0.8,height:geo.size.height*0.6)
                    /*Text("Price: \(self.price, specifier: "%.2f")")
                        .font(.custom("HiraKakuProN-W6", size: 18))
                        .fontWeight(.semibold)*/
                }
            }.cornerRadius(20)
                .onTapGesture {
                    let clickSound = Bundle.main.path(forResource: "click", ofType: "mp3")
                    self.AudioPlayer = try!AVAudioPlayer(contentsOf: URL(fileURLWithPath: clickSound!))
                    self.AudioPlayer.play()
                    self.ID=self.proxyID
                    self.tapped = true
            }*/
        }
    }
}

struct ShopElementView_Previews: PreviewProvider {
    static var previews: some View {
        ShopElementView(proxyID: 3, image: "Balanced", attribute: "health", price: 2.0,tapped: Binding.constant(false),ID:Binding.constant(1),disabled: true, buttonsDisabled: Binding.constant([true]))
    }
}
