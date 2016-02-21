//
//  AppDelegate.swift
//  Pomodoro
//
//  Created by Jose Luis Molina on 20/2/16.
//  Copyright © 2016 Jose Luis Molina. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2);
    let popover = NSPopover()
    var eventMonitor: EventMonitor?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
            button.action = Selector("togglePopover:")
        }
        popover.contentViewController = QuotesViewController(nibName: "QuotesViewController", bundle: nil)
        initEventMonitor();
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
        eventMonitor?.start()
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func togglePopover(sender: AnyObject?) {
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    func initEventMonitor() {
        eventMonitor = EventMonitor(mask: NSEventMask.LeftMouseDownMask.union(NSEventMask.RightMouseDownMask)) { [unowned self] event in
            if self.popover.shown {
                self.closePopover(event)
            }
        }
        eventMonitor?.start()
    }


}

