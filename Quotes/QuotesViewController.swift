//
//  QuotesViewController.swift
//  Pomodoro
//
//  Created by Jose Luis Molina on 20/2/16.
//  Copyright © 2016 Jose Luis Molina. All rights reserved.
//

import Cocoa

class QuotesViewController: NSViewController {

    @IBOutlet var textLabel: NSTextField!

    let quotes = Quote.all
    
    var currentQuoteIndex: Int = 0 {
        didSet {
            updateQuote()
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        currentQuoteIndex = 0
    }
    
    func updateQuote() {
        textLabel.stringValue = String(quotes[currentQuoteIndex])
    }
    
}

extension QuotesViewController {
    @IBAction func randomQuote(sender: NSButton) {
        currentQuoteIndex = (currentQuoteIndex - 1 + quotes.count) % quotes.count
    }
    
    @IBAction func quit(sender: NSButton) {
        NSApplication.sharedApplication().terminate(sender)
    }
}
