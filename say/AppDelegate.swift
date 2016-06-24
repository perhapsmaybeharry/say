//
//  AppDelegate.swift
//  say-ii-osx
//
//  Created by Harry Wang on 2/6/16.
//  Copyright © 2016 thisbetterwork. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {return true}
}

