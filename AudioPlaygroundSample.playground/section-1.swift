// Playground - noun: a place where people can play

import Cocoa
import AVFoundation
import XCPlayground

XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)

let audioEngine = AVAudioEngine()
let outputNode = audioEngine.outputNode
let format = audioEngine.outputNode.inputFormatForBus(0)

let samplerNode = AVAudioUnitSampler()
audioEngine.attachNode(samplerNode)
let path = NSBundle.mainBundle().pathForSoundResource("sine")
let url: NSURL! = NSURL(fileURLWithPath: path!)
let urls: [NSURL] = [url]
samplerNode.loadAudioFilesAtURLs(urls, error: nil)

audioEngine.connect(samplerNode, to: outputNode, format: format)

audioEngine.startAndReturnError(nil)

let seq: [UInt8] = [0, 2, 4, 5, 7, 9, 11, 12]
while true {
    for note in seq {
        samplerNode.startNote(note + 60, withVelocity: 127, onChannel: 0)
        NSThread.sleepForTimeInterval(0.5)
    }
}

