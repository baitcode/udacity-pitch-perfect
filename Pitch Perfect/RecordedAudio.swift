//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Batiy Ilya on 10/03/15.
//  Copyright (c) 2015 baitcode. All rights reserved.
//

import Foundation
import AVFoundation

let RecordingsDir: String = NSSearchPathForDirectoriesInDomains(
    .DocumentDirectory, .UserDomainMask, true
)[0] as String;

class RecordedAudio: NSObject {
    var title: String!;
    var fileName: String!;
    var filePathURL: NSURL! = nil;
    
    private var file: AVAudioFile!;
    
    func getFileUrl() -> NSURL! {
        let pathArray = [
            RecordingsDir,
            self.fileName
        ];
        return NSURL.fileURLWithPathComponents(
            pathArray
        );
    }

    func generateFileName() -> String {
        let timestamp = NSDate();
        let fileNameFormatter = NSDateFormatter();
        fileNameFormatter.dateFormat = "ddMMyyyy-HHmmsss";
        return fileNameFormatter.stringFromDate(timestamp);
    }

    override init() {
        super.init();
        self.fileName = self.generateFileName();
        self.filePathURL = self.getFileUrl();
    }
    
    func asAVAudioFile() -> AVAudioFile {
        if (self.file == nil){
            self.file = AVAudioFile(forReading: self.filePathURL, error: nil);
        }
        return file;
    }
}