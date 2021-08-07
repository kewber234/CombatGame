//
//  IntroView.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 4/28/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI

struct IntroView: View {
    @State private var introIndex = 0
    @Binding var showing:Bool
    var intro = ["Grandmaster Kenny: Ah, hello there my friend. I am Grandmaster Kenny. Welcome to the Yamashita Fighting Institute.","So you want to become a master eh? Well, then your first lesson begins now...","First off, you must learn about stats. They are as follows: health, attack, block, armour, and accuracy.","Health is simple: the amount of damage you can take before you become unconscious","Attack is the amount of damage you deal to your opponent. The actual amount may vary from your actual stat.","Accuracy is the likelihood that you will land your attack on your opponent.","Armour is used to negate some of the damage dealth to you, again it is variable.","Finally, block is simply the likehood of you completely negating a succesful opposing attack.","Ah yes, one more thing. There exists a rather rare item known to many as a regen. A regen will automatically restore your health to 50% when you lose all your health, effectively giving you a second life.","That is all for now, I'll leave the rest of your training in the capable hands of your masters. I bid you good luck...and...hmm...I have a feeling we will meet again very soon.","Master Rory: Hey there sport! I'm Master Rory and I'll be instructing you your time here at the institute. Now, I know you're excited but first things first, I need you to take out your complimentary tablet and fill out a form..."]
    var body: some View {
        VStack{
            Text(intro[introIndex]).font(.custom("HiraKakuProN-W6", size: 20)).foregroundColor(.gray2).onTapGesture {
                self.introIndex += self.introIndex != self.intro.count-1 ? 1 :0
            }.padding(.horizontal)
            if introIndex == intro.count-1{
                VStack{
                    Button("OPEN TABLET"){
                        self.showing = false
                    }.offset(x: 0, y: 30)
                }
                
            }
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView(showing: Binding.constant(true))
    }
}
