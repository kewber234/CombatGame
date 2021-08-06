//
//  extensions.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 4/30/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import SwiftUI
import Foundation

extension Color{
    static func rgb(r:Double, g:Double, b:Double) -> Color{
        return Color(red: r / 255, green: g / 255, blue: b / 255)
    }
    static let gray2 = Color.rgb(r:69, g:69, b:69)
    static let greyWhite = Color.rgb(r:191,g:189,b:193)
    static let maroon = Color.rgb(r:68, g:13, b:15)
    static let pinkMaroon = Color.rgb(r:134,g:97,b:92)
    static let brown2 = Color.rgb(r:96,g:70,b:59)
    static let brightYellow = Color.rgb(r:245,g:255,b:85)
    static let cyan = Color.rgb(r:0,g:247,b:255)
    static let orange2 = Color.rgb(r: 255, g: 201, b: 50)
    static let darkGreen = Color.rgb(r: 15, g: 121, b: 15)
}

