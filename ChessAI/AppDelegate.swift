//
//  AppDelegate.swift
//  ChessAI
//
//  Created by Liam Cain on 10/26/15.
//  Copyright (c) 2015 Pillowfort Architects. All rights reserved.
//


import Cocoa
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!
    
    weak var currentScene: GameScene?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        let scene = GameScene(size: CGSize(width:800, height:800))
        currentScene = scene
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        self.skView!.presentScene(scene)
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        self.skView!.ignoresSiblingOrder = true
        
        self.skView!.showsFPS = true
        self.skView!.showsNodeCount = true

        let menuBar = NSMenu(title:"")
        let app = NSMenu(title: "ChessAI")
        app.addItemWithTitle("About ChessAI", action: nil, keyEquivalent: "")
        app.addItem(NSMenuItem.separatorItem())
        app.addItemWithTitle("Quit", action: Selector("quit:"), keyEquivalent: "q")
        
        let appItem = menuBar.addItemWithTitle("", action: nil, keyEquivalent: "")
        appItem?.submenu = app
        
        let edit = NSMenu.init(title: "Edit")
        edit.addItemWithTitle("Undo", action: Selector("undo"), keyEquivalent: "z")
        edit.addItemWithTitle("Reset", action: Selector("reset"), keyEquivalent: "r")
        edit.addItemWithTitle("Copy FEN", action: Selector("copyfen"), keyEquivalent: "c")
        edit.addItemWithTitle("Paste FEN", action: Selector("pastefen"), keyEquivalent: "v")
        
        let editHeading = menuBar.addItemWithTitle("", action: nil, keyEquivalent: "")
        editHeading?.submenu = edit
        
        NSApp.mainMenu = menuBar
    }
    
    func pastefen() {
        let pasteboard = NSPasteboard.generalPasteboard()
        if pasteboard.canReadObjectForClasses([NSString.self], options:nil) {
            if let strings = pasteboard.readObjectsForClasses([NSString.self], options:nil) as? Array<String> {
                for s in strings {
                    currentScene?.loadFEN(s)
                    break
                }
            }
        }
    }
    
    func copyfen() {
        let pasteboard = NSPasteboard.generalPasteboard()
        pasteboard.clearContents()
        pasteboard.setString(currentScene!.game.generateFen(), forType: NSPasteboardTypeString)
    }
    
    func undo() {
        currentScene?.undo()
    }
    
    func reset() {
        currentScene?.reset()
    }
    
    func quit(sender: AnyObject) {
        NSApp.terminate(self)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
