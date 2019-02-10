//
//  AppDelegate.swift
//  Link It
//
//  Created by Nikhil Bolar on 2/3/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let menu = NSMenu()
        statusItem.button?.image = NSImage(named: "hyperlink")
        menu.addItem(NSMenuItem(title: "Link It", action: #selector(self.link), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(self.quit), keyEquivalent: ""))
        
        statusItem.menu = menu
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func link(){

        if let items = NSPasteboard.general.pasteboardItems{
            for item in items{
                for type in item.types{
                    if type.rawValue == "public.utf8-plain-text"{
                        if let url = item.string(forType: type){
                            NSPasteboard.general.clearContents()
                            
                            var actualURL : String
                            
                            if url.hasPrefix("http://") || url.hasPrefix("https://"){
                                actualURL = url
                            }else{
                                actualURL = "https://\(url)"
                            }
                            
                            NSPasteboard.general.setString("<a href=\(url)>\(url)</a>", forType: NSPasteboard.PasteboardType(rawValue: "public.html"))
                            NSPasteboard.general.setString(url, forType: NSPasteboard.PasteboardType(rawValue: "public.utf8-plain-text"))
                        }
                    }
    
                }
            }
        }
    }
    
    @objc func quit(){
        
        NSApp.terminate(nil)
    }
    


}

