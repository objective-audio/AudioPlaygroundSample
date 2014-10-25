// Playground - noun: a place where people can play

import Cocoa
import AVFoundation
import XCPlayground

XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)

let audioEngine = AVAudioEngine()
let inputNode = audioEngine.inputNode
let outputNode = audioEngine.outputNode
let format = audioEngine.outputNode.inputFormatForBus(0)

audioEngine.connect(inputNode, to: outputNode, format: format)

audioEngine.startAndReturnError(nil)
