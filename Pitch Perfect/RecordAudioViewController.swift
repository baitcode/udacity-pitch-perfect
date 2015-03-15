//
//  RecordAudioViewController
//  Pitch Perfect
//
//  Created by Batiy Ilya on 07/03/15.
//  Copyright (c) 2015 baitcode. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var stopBtn: UIButton!;
    @IBOutlet weak var statusLbl: UILabel!;
    @IBOutlet weak var recordingBtn: UIButton!;
    @IBOutlet weak var pauseBtn: UIButton!;
    
    var recorder: AVAudioRecorder!;
    
    var recordedAudio: RecordedAudio!;
    
    var recordingStarted = false;
    
    func setStatus(status: String) {
        statusLbl.hidden = status == "";
        statusLbl.text = status;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func viewWillAppear(animated: Bool) {
        self.setStatus("");
        self.stopBtn.hidden = true;
        self.recordingBtn.enabled = true;
        self.pauseBtn.hidden = true;
        self.recordingStarted = false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }

    func startRecording(){
        var session = AVAudioSession.sharedInstance();
        session.setCategory(
            AVAudioSessionCategoryPlayAndRecord,
            withOptions: AVAudioSessionCategoryOptions.DefaultToSpeaker,
            error: nil
        );
        self.recordedAudio = RecordedAudio();
        self.recorder = AVAudioRecorder(URL: recordedAudio.getFileUrl(), settings: nil, error: nil);
        self.recorder.delegate = self;
        self.recorder.meteringEnabled = true;
        self.recorder.prepareToRecord();
        self.recorder.record();
        self.recordingStarted = true;
    }

    func resumeRecording(){
        self.recorder.record();
    }
    
    @IBAction func record(sender: UIButton) {
        self.recordingBtn.enabled = false;
        self.setStatus("recording");
        self.pauseBtn.hidden = false;
        self.stopBtn.hidden = false;

        if (!self.recordingStarted){
            self.startRecording();
        } else {
            self.resumeRecording();
        }
    }
    
    @IBAction func stop(sender: UIButton) {
        self.recordingBtn.enabled = true;
        self.setStatus("");
        self.pauseBtn.hidden = true;
        self.stopBtn.hidden = true;
        
        self.recorder.stop();
        var session = AVAudioSession.sharedInstance();
        session.setActive(false, error: nil);
    }

    @IBAction func pause(sender: UIButton) {
        self.recordingBtn.enabled = true;
        self.setStatus("paused");
        self.stopBtn.hidden = false;
        self.pauseBtn.hidden = true;
        
        self.recorder.pause();
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC: PlaySoundsViewController =
                segue.destinationViewController as PlaySoundsViewController;
            playSoundsVC.record = sender as RecordedAudio;
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag){
            self.recordedAudio = RecordedAudio();
            self.recordedAudio.title = recorder.url.lastPathComponent;
            self.recordedAudio.filePathURL = recorder.url;
            self.performSegueWithIdentifier("stopRecording", sender: self.recordedAudio)
        } else {
            self.statusLbl.hidden = true;
            stopBtn.hidden = true;
            pauseBtn.hidden = true;
            recordingBtn.enabled = true;
        }
    }
    

}

