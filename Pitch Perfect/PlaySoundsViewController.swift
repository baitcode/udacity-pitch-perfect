//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Batiy Ilya on 07/03/15.
//  Copyright (c) 2015 baitcode. All rights reserved.
//

import AVFoundation

import UIKit

class PlaySoundsViewController: UIViewController {
    @IBOutlet weak var slowBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var fastBtn: UIButton!
    @IBOutlet weak var chimpmonkBtn: UIButton!
    @IBOutlet weak var darthVaderBtn: UIButton!
    @IBOutlet weak var reverbBtn: UIButton!
    
    var engine = AVAudioEngine()
    var playerNode = AVAudioPlayerNode()
    var pitchEffect = AVAudioUnitTimePitch()
    var reverbEffect = AVAudioUnitReverb()

    var record: RecordedAudio!
    
    func stop(){
        self.playerNode.stop()
    }

    func play(){
        self.stop()
        self.engine.startAndReturnError(nil)
        var session = AVAudioSession.sharedInstance()
        session.overrideOutputAudioPort(AVAudioSessionPortOverride.None, error: nil)
        self.playerNode.scheduleFile(self.record.asAVAudioFile(), atTime: nil, completionHandler: nil)
        self.playerNode.play()
    }
    
    func resetEffects() {
        self.pitchEffect.rate = 1
        self.pitchEffect.pitch = 1
        self.reverbEffect.wetDryMix = 0
    }
    
    @IBAction func playSlowAction(sender: UIButton) {
        self.resetEffects()
        self.pitchEffect.rate = 0.5
        self.play()
    }

    @IBAction func playReverbAction(sender: UIButton) {
        self.resetEffects()
        self.reverbEffect.wetDryMix = 10
        self.play()
    }
    
    @IBAction func playFastAction(sender: UIButton) {
        self.resetEffects()
        self.pitchEffect.rate = 1.5
        self.play()
    }
    
    @IBAction func playChimpmonkAction(sender: UIButton) {
        self.resetEffects()
        self.pitchEffect.pitch = 1000
        self.play()
    }

    @IBAction func playDartVaderAction(sender: UIButton) {
        self.resetEffects()
        self.pitchEffect.pitch = -1000
        self.play()
    }

    @IBAction func stopAction(sender: UIButton) {
        self.stop()
    }
        
    
    override func viewDidLoad() {
        self.engine.reset()
        self.engine.stop()

        self.engine.attachNode(self.playerNode)
        self.engine.attachNode(self.pitchEffect)
        self.engine.attachNode(self.reverbEffect)
        
        self.engine.connect(self.playerNode, to: self.pitchEffect, format: nil)
        self.engine.connect(self.pitchEffect, to: self.reverbEffect, format: nil)
        self.engine.connect(self.reverbEffect, to: self.engine.outputNode, format: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}