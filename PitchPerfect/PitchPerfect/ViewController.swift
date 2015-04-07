//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Vaijanath Angadihiremath on 3/15/15.
//  Copyright (c) 2015 com.voidangle. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var Stop: UIButton!
    @IBOutlet weak var microphone: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    override func viewDidLoad() {
        super.viewDidLoad()
        recordingInProgress.hidden = false
        recordingInProgress.text = "Tap to Record"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func Stop(sender: AnyObject) {
        Stop.hidden = true
        Stop.enabled = false
        microphone.hidden = false
        microphone.enabled = true
        recordingInProgress.text = "Tap to Record"
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }
    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgress.hidden = false
        recordingInProgress.text = "Recording"
        microphone.enabled = false
        microphone.hidden = true
        Stop.enabled = true
        Stop.hidden = false
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
            recordedAudio = RecordedAudio( filePathUrl: recorder.url , title:recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecording" , sender: recordedAudio)
        }
        else {
            println("Recording was not successful")
            microphone.enabled = true
            Stop.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.recievedAudio = data
            println(data.filePathUrl)
        }
    }
    
}

