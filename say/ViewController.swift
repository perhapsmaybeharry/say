//
//  ViewController.swift
//  say-ii-osx
//
//  Created by Harry Wang on 2/6/16.
//  Copyright © 2016 thisbetterwork. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
	
	var timer = NSTimer()

	override func viewDidLoad() {
		super.viewDidLoad()
		sayField.becomeFirstResponder()
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(pauseTimer), name: NSApplicationDidResignActiveNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(startTimer), name: NSApplicationDidBecomeActiveNotification, object: nil)
		
		for i in NSSpeechSynthesizer.availableVoices() {print(i); voiceSelector.addItemWithTitle(i.componentsSeparatedByString(".premium").first!.componentsSeparatedByString(".").last!.capitalizedString)}
		voiceSelector.selectItemWithTitle("Alex")
	}
	
	@IBOutlet var voiceSelector: NSPopUpButton!
	
	func pauseTimer() {timer.invalidate()}
	func startTimer() {timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)}
	
	var i = Int()
	
	func timerTick() {
		if sayField.stringValue == "" {sayButton.enabled = false}
		else if NSSpeechSynthesizer.isAnyApplicationSpeaking() {sayButton.title = "Stop"}
		else {sayButton.enabled = true; sayButton.title = "Say"}
	}
	
	@IBOutlet var sayField: NSTextField!
	
	@IBOutlet var sayButton: NSButton!
	var speaker = NSSpeechSynthesizer(), speak = String(), voice = String()
	@IBAction func didClickSayButton(sender: AnyObject) {
		speak = sayField.stringValue; voice = NSSpeechSynthesizer.availableVoices()[voiceSelector.indexOfSelectedItem]
		
		if sayButton.title == "Say" {
			print("to say \"\(speak)\" with voice \"\(voice)\"")
			speaker.setVoice(voice)
			speaker.startSpeakingString(speak)
		} else if sayButton.title == "Stop" {
			speaker.stopSpeaking()
		}
	}
}