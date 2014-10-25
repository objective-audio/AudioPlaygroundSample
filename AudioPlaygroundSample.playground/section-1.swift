// Playground - noun: a place where people can play

import Cocoa
import AVFoundation
import XCPlayground

XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)

let audioEngine = AVAudioEngine()
let outputNode = audioEngine.outputNode
let format = audioEngine.outputNode.inputFormatForBus(0)

let playerNode = AVAudioPlayerNode()
audioEngine.attachNode(playerNode)

audioEngine.connect(playerNode, to: outputNode, format: format)

audioEngine.startAndReturnError(nil)

playerNode.play()

let path = XCPSharedDataDirectoryPath.stringByAppendingPathComponent("edge.wav")
let url = NSURL.fileURLWithPath(path)
let audioFile = AVAudioFile(forReading: url, error: nil)

playerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
