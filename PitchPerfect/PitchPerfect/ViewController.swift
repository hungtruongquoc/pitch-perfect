//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Hung Truong on 9/1/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblRecording: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func recordAudio(_ sender: Any) {
        print("Record button was pressed")
        lblRecording.text = "Recording in Progress"
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        print("Stop Recording button was pressed")
    }
}

