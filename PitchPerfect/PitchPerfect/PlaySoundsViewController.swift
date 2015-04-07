//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Vaijanath Angadihiremath on 4/5/15.
//  Copyright (c) 2015 com.voidangle. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController{

 
    @IBOutlet weak var snailButton: UIButton!
    var audioPlayer:AVAudioPlayer!
    var recievedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error:nil);
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)

    }

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  //       Dispose of any resources that can be recreated.
    }


    @IBAction func fastButton(sender: AnyObject) {
        // Plays audio fast
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 2.0
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    @IBAction func snailButtonClick(sender: AnyObject) {
        // Plays audio slowly
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
    }
  
    @IBAction func stopAudioPlay(sender: AnyObject) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
    }
    
    @IBAction func chipMunkButton(sender: AnyObject) {
    
        playAudioWithVariablePitch(1000)
    }
  
    
    @IBAction func darthVaderButton(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
}
