//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by Hung Truong on 9/1/23.
//
import AVFoundation
import UIKit

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var lblRecording: UILabel!
    @IBOutlet weak var btnRecording: UIButton!
    @IBOutlet weak var btnStopRecording: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnStopRecording.isEnabled = false
    }

    @IBAction func recordAudio(_ sender: Any) {
        configureUI(true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
    
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else {
            print("Failed to record the audio")
        }
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        configureUI()
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            // Get the new view controller using segue.destination.
            let playSoundVC = segue.destination as! PlaySoundViewController
            let recordedAudioUrl = sender as! URL
            // Pass the selected object to the new view controller.
            playSoundVC.recordedAudioUrl = recordedAudioUrl
        }
    }
    
    func configureUI(_ recording:Bool = false) {
        if recording {
            lblRecording.text = "Recording in Progress"
        }
        else {
            lblRecording.text = "Tap to record"
        }
        btnStopRecording.isEnabled = recording
        btnRecording.isEnabled = !recording
    }
}

