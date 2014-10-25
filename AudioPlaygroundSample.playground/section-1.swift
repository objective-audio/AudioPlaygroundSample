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

let delayNode = AVAudioUnitDelay()
audioEngine.attachNode(delayNode)
delayNode.wetDryMix = 60
delayNode.delayTime = 0.25
delayNode.feedback = 60

let reverbNode = AVAudioUnitReverb()
audioEngine.attachNode(reverbNode)
reverbNode.wetDryMix = 100
reverbNode.loadFactoryPreset(.Plate)

audioEngine.connect(samplerNode, to: delayNode, format: format)
audioEngine.connect(delayNode, to: reverbNode, format: format)
audioEngine.connect(reverbNode, to: outputNode, format: format)

audioEngine.startAndReturnError(nil)

let seq: [UInt8] = [0, 2, 4, 5, 7, 9, 11, 12]
while true {
    for note in seq {
        samplerNode.startNote(note + 60, withVelocity: 127, onChannel: 0)
        NSThread.sleepForTimeInterval(0.5)
    }
}

