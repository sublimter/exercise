//
//  DEMO2ViewController.swift
//  swiftDemo
//
//  Created by luo on 2018/5/29.
//  Copyright © 2018年 luoliangliang. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer

class DEMO2ViewController: UIViewController {

    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let videoButton = UIButton()
        videoButton.setTitleColor(UIColor.blue, for: .normal)
        videoButton.setTitle("play video", for: .normal)
        videoButton.frame = CGRect(x: 50, y: 50, width: 100, height: 50)
        view.addSubview(videoButton)
        videoButton.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        
        let audioPlayButton = UIButton()
        audioPlayButton.setTitleColor(UIColor.red, for: UIControlState.normal)
        audioPlayButton.setTitle("Play Audio", for: UIControlState.normal)
        audioPlayButton.frame = CGRect(x: 50, y: 150, width: 100, height: 50)
        self.view.addSubview(audioPlayButton)
        audioPlayButton.addTarget(self, action: #selector(playAudio), for: UIControlEvents.touchUpInside)
        
        let audioPauseButton = UIButton()
        audioPauseButton.setTitleColor(UIColor.red, for: UIControlState.normal)
        audioPauseButton.setTitle("Pause Audio", for: UIControlState.normal)
        audioPauseButton.frame = CGRect(x: 50, y: 250, width: 100, height: 50)
        self.view.addSubview(audioPauseButton)
        audioPauseButton.addTarget(self, action: #selector(pauseAudio), for: UIControlEvents.touchUpInside)
        
        initAudio()
    }

    /// 初始化 audio
    func initAudio() {
        
        let audioPath = Bundle.main.path(forResource: "live", ofType: "mp3")
        let audioUrl = URL(fileURLWithPath: audioPath!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
        } catch {
            audioPlayer = nil
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {
            print("error")
        }
    }
    
    @objc func playAudio() {
        audioPlayer?.play()
    }
    
    @objc func pauseAudio() {
        audioPlayer?.pause()
    }
    
    @objc func playVideo() {
        let videoUrl = URL(string: "http://down.treney.com/mov/test.mp4")
        let player = AVPlayer(url: videoUrl!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true) {}
    }
    
}
