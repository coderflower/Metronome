//
//  MetronomeHelper.swift
//  Metronome
//
//  Created by 蔡龙君 on 2020/10/13.
//

import AVFoundation

class MetronomeHelper {
    
    private let audioPlayerNode: AVAudioPlayerNode
    private let audioFileMainClick: AVAudioFile
    private let audioFileAccentedClick: AVAudioFile
    private let audioEngine: AVAudioEngine
    
    @objc public init?(mainClickFile: URL, accentedClickFile: URL? = nil) {
        do {
            audioFileMainClick = try AVAudioFile(forReading: mainClickFile)
            audioFileAccentedClick = try AVAudioFile(forReading: accentedClickFile ?? mainClickFile)
            audioPlayerNode = AVAudioPlayerNode()
            audioEngine = AVAudioEngine()
            audioEngine.attach(audioPlayerNode)
            audioEngine.connect(audioPlayerNode, to: audioEngine.outputNode, format: audioFileMainClick.processingFormat)
            try audioEngine.start()
        } catch {
            return nil;
        }
     }
    
    private func generateBuffer(bpm: Double) -> AVAudioPCMBuffer? {
        
        audioFileMainClick.framePosition = 0
        audioFileAccentedClick.framePosition = 0
        do {
            let beatLength = AVAudioFrameCount(audioFileMainClick.processingFormat.sampleRate * 60 / bpm)
            let bufferMainClick = AVAudioPCMBuffer(pcmFormat: audioFileMainClick.processingFormat,
                                                   frameCapacity: beatLength)!
            try audioFileMainClick.read(into: bufferMainClick)
            bufferMainClick.frameLength = beatLength

            let bufferAccentedClick = AVAudioPCMBuffer(pcmFormat: audioFileMainClick.processingFormat,
                                                       frameCapacity: beatLength)!
            try audioFileAccentedClick.read(into: bufferAccentedClick)
            bufferAccentedClick.frameLength = beatLength

            let bufferBar = AVAudioPCMBuffer(pcmFormat: audioFileMainClick.processingFormat,
                                             frameCapacity: 4 * beatLength)!
            bufferBar.frameLength = 4 * beatLength

            // don't forget if we have two or more channels then we have to multiply memory pointee at channels count
            let channelCount = Int(audioFileMainClick.processingFormat.channelCount)
            let accentedClickArray = Array(
                UnsafeBufferPointer(start: bufferAccentedClick.floatChannelData![0],
                                    count: channelCount * Int(beatLength))
            )
            let mainClickArray = Array(
                UnsafeBufferPointer(start: bufferMainClick.floatChannelData![0],
                                    count: channelCount * Int(beatLength))
            )

            var barArray = [Float]()
            // one time for first beat
            barArray.append(contentsOf: accentedClickArray)
            // three times for regular clicks
            for _ in 1...3 {
                barArray.append(contentsOf: mainClickArray)
            }
            bufferBar.floatChannelData!.pointee.assign(from: barArray,
                                                       count: channelCount * Int(bufferBar.frameLength))
            return bufferBar
        } catch {
            return nil;
        }
    }
    
    @objc public func play(bpm: Double) {
        
        guard let buffer = generateBuffer(bpm: bpm) else {
            return;
        }
        if audioPlayerNode.isPlaying {
            audioPlayerNode.scheduleBuffer(buffer, at: nil, options: .interruptsAtLoop, completionHandler: nil)
        } else {
            if !self.audioEngine.isRunning {
                do {
                    try self.audioEngine.start()
                } catch {
                    return;
                }
            }
            self.audioPlayerNode.play()
        }
        self.audioPlayerNode.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)
    }
    @objc public func pause() {
        audioEngine.stop()
        audioPlayerNode.pause()
    }
    @objc public  func stop() {
        audioEngine.stop()
        audioPlayerNode.stop()
    }
    var isPlaying: Bool {
        return audioPlayerNode.isPlaying
    }
}
