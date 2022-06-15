//
//  ContentViewModel.swift
//  saxjaxXylophone
//
//  Created by Jakob Skov Søndergård on 15/06/2022.
//

import UIKit
import AVFoundation

class ContentViewModel: UIViewController {
    var player: AVAudioPlayer?

    func playSound(soundname:String?){

        guard let path = Bundle.main.path(forResource: soundname, ofType: "wav") else {
            return}
        let url = URL(fileURLWithPath: path)
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }
        catch let error{
            print(error.localizedDescription)

        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func keyPressed(_ sender: Any) {
        print("I ws pressed")
        playSound(soundname: "C")

    }

    @IBAction func clickedSound(_ sender: UIButton) {
        playSound(soundname: sender.titleLabel?.text)

    }



}

