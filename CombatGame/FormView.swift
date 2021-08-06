//
//  FormView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 4/15/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI


struct FormView: View {
    @ObservedObject var main:fighter
    @Binding var showing:Bool
    @State private var name = ""
    @State var error = false
    var body: some View {
        GeometryReader{geo in
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.maroon,.brown2,.pinkMaroon,.maroon,.brown2]), startPoint: .topTrailing, endPoint: .bottomLeading).edgesIgnoringSafeArea(.all)
                Text("Please enter your name").font(.custom("HiraKakuProN-W6", size: 26)).bold().foregroundColor(.white).position(x:geo.size.width*0.5,y: geo.size.height*0.25)
                VStack(spacing:10){
                    TextField("", text: self.$name).textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width:geo.size.width*0.7)
                    if self.error{
                        Text("Name should not exceed 10 characters").foregroundColor(.red)
                    }
                }
                
                    Text("confirm").foregroundColor(.white).padding().background(Color.gray2).cornerRadius(25).position(x: geo.size.width*0.5, y: geo.size.height*0.8)
                        .font(.custom("HiraKakuProN-W6", size: 20))
                        .onTapGesture {
                            if self.name.count <= 10{
                                self.main.name = self.name
                                self.showing = false
                            }
                            else{
                                self.error = true
                            }
                }
                
            }
        }
    }
}
struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView(main: fighter(health: 1, attack: 1, accuracy: 1, block: 1, armour: 1,money: 0 , regens: 0 ),showing: Binding.constant(true))
    }
}
