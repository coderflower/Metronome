//
//  PlayerHelper.swift
//  Metronome
//
//  Created by 蔡龙君 on 2020/10/13.
//

import Foundation
import AVFoundation

public class PlayerHelper {
    static var isBeatPlaying: Bool = false
    
    var beatValue: Int = 150 {
        didSet {
            helper?.play(bpm: Double(beatValue))
        }
    }
    
    var fileName: String = "beat.wav" {
        didSet {
            filePath = Bundle.main.path(forResource: fileName, ofType: nil)
                ?? Bundle.main.path(forResource: "beat.wav", ofType: nil)!
        }
    }
    private var filePath: String = Bundle.main.path(forResource: "beat.wav", ofType: nil)!
    
    lazy var helper: MetronomeHelper? = {
        let url = URL(string: filePath)!
        return MetronomeHelper(mainClickFile: url, accentedClickFile: url)
    }()
    
    func play() {
        PlayerHelper.isBeatPlaying = true
        activeAudioSession()
        helper?.play(bpm: Double(beatValue))
    }
    
    func pause() {
        guard !PlayerHelper.isBeatPlaying else {
            return
        }
        PlayerHelper.isBeatPlaying = false
        deactiveAudioSessiong()
        helper?.pause()
    }
    
    func stop() {
        PlayerHelper.isBeatPlaying = false
        deactiveAudioSessiong()
        helper?.stop()
    }
    
    
    private func activeAudioSession() {
        DispatchQueue.main.async {
            AudioHelper.activeAudioSession()
            AudioHelper.duckOtherMusic()
        }
    }
    
    private func deactiveAudioSessiong() {
        DispatchQueue.main.async {
            AudioHelper.deactiveAudioSessionWillOtherMusicPlay()
        }
    }
}

struct AudioHelper {
    //MARK: - private
    fileprivate static var currentSessionActive: Bool = false
    fileprivate static var otherAudioPlaying: Bool {
        AVAudioSession.sharedInstance().secondaryAudioShouldBeSilencedHint
    }
    fileprivate static var isActive: Bool { currentSessionActive || otherAudioPlaying}
    
    fileprivate static func activeAudioSession() {
        guard !isActive else { return }
        do {
            try AVAudioSession.sharedInstance().setActive(true, options: [])
            AudioHelper.currentSessionActive = true
        } catch {
            print(error)
        }
    }
    
    static func deactiveAudioSessionWillOtherMusicPlay() {
        if otherAudioPlaying {
            try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        }
    }
    
    static func deactiveAudioSession() {
        guard !isActive else { return }
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
    
    static func duckOtherMusic() {
        if !isActive {
            activeAudioSession()
        }
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: .duckOthers)
    }
}
