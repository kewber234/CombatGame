//
//  SoundFile.swift
//  CombatGame
//
//  Created by Kenneth Yamashita on 5/11/20.
//  Copyright © 2020 Kenneth Yamashita. All rights reserved.
//

import AVFoundation


class Sounds {

  static var audioPlayer1:AVAudioPlayer?
  static var audioPlayer2:AVAudioPlayer?
  static var audioPlayer3:AVAudioPlayer?
    static var audioPlayer4:AVAudioPlayer?


  static func playDojo() {

      if let path = Bundle.main.path(forResource: "Master Kenny's Dojo", ofType: "mp3"){

          do{

              audioPlayer1 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
              audioPlayer1?.prepareToPlay()
            audioPlayer1?.numberOfLoops = -1
            audioPlayer1?.play()

          }catch {
              print("Error")
          }
      }
    
   }
    
    static func playSound(soundName:String) {

       if let path = Bundle.main.path(forResource: soundName, ofType: "mp3"){

           do{

               audioPlayer3 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
               audioPlayer3?.prepareToPlay()
             audioPlayer3?.play()

           }catch {
               print("Error")
           }
       }
     
    }
    static func playSoundWAV(soundName:String) {

       if let path = Bundle.main.path(forResource: soundName, ofType: "wav"){

           do{

               audioPlayer4 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
               audioPlayer4?.prepareToPlay()
             audioPlayer4?.play()

           }catch {
               print("Error")
           }
       }
     
    }
    
    static func playBattle() {

       if let path = Bundle.main.path(forResource: "Battle Music", ofType: "mp3"){

           do{

               audioPlayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
               audioPlayer2?.prepareToPlay()
               audioPlayer2?.numberOfLoops = -1
               audioPlayer2?.play()

           }catch {
               print("Error")
           }
       }
     
    }
    
    static func pauseDojo() {
        
        audioPlayer1?.pause()
    }
    
    static func stopBattle() {
        
        audioPlayer2?.stop()
    }
    static func resumeDojo(){
        audioPlayer1?.play()
    }
    static func stopAll() {
        
        audioPlayer1?.stop()
        audioPlayer2?.stop()
    }

    
    
    
    
    
}
