import Foundation
import AppKit
import os.log

class SleepDetector
{
    var detectedScreenSaverStart = false
    var screenSaverStartedCount = 0
    
    init() {
        let distCenter = DistributedNotificationCenter.default()
        let wsCenter = NSWorkspace.shared.notificationCenter
        
        // Distributed Notificiations
//        distCenter.addObserver(self,
//                           selector: #selector(distCenterReceived(_:)),
//                           name: Notification.Name("com.apple.screenIsLocked"),
//                           object: nil)
//        distCenter.addObserver(self,
//                           selector: #selector(distCenterReceived(_:)),
//                           name: Notification.Name("com.apple.screenIsUnLocked"),
//                           object: nil)
//        distCenter.addObserver(self,
//                           selector: #selector(distCenterReceived(_:)),
//                           name: Notification.Name("com.apple.screensaver.didstart"),
//                           object: nil)
//        distCenter.addObserver(self,
//                           selector: #selector(distCenterReceived(_:)),
//                           name: Notification.Name("com.apple.screensaver.didstop"),
//                           object: nil)
        
        distCenter.addObserver(self,
                               selector: #selector(screenSaverStarted(_:)),
                               name: Notification.Name("com.apple.screensaver.didlaunch"),
                               object: nil)
        
//        distCenter.addObserver(self,
//                               selector: #selector(distCenterReceived(_:)),
//                               name: nil,
//                               object: nil)
        
        // NSWorkspace Notifications
//        wsCenter.addObserver(self,
//                           selector: #selector(wsCenterReceived(_:)),
//                           name: NSWorkspace.willSleepNotification,
//                           object: nil)
//        wsCenter.addObserver(self,
//                           selector: #selector(wsCenterReceived(_:)),
//                           name: NSWorkspace.didWakeNotification,
//                           object: nil)
//
        wsCenter.addObserver(self,
                             selector: #selector(applicationActivated(_:)),
                             name: NSWorkspace.didActivateApplicationNotification,
                             object: nil)
        wsCenter.addObserver(self,
                             selector: #selector(applicationDeactivated(_:)),
                             name: NSWorkspace.didDeactivateApplicationNotification,
                             object: nil)
        
        
        
        
    }
    
    @objc func screenSaverStarted(_ notification: Notification) {
        printMessage("Detected ScreenSaver Start", kind: "screensaverDetector")
        detectedScreenSaverStart = true
    }
    
    @objc func applicationActivated(_ notification: Notification) {
        if let ws = notification.object as? NSWorkspace {
            if let frontmostApp = ws.frontmostApplication {
                if frontmostApp.bundleIdentifier == "com.apple.ScreenSaver.Engine" && screenSaverStartedCount == 0 && detectedScreenSaverStart {
                    screenSaverStartedCount += 1
                    printMessage("Started ScreenSaver : \(screenSaverStartedCount)", kind: "screensaverDetector")
                }
            }
        }
    }
    
    @objc func applicationDeactivated(_ notification: Notification) {
        if let ws = notification.object as? NSWorkspace {
            if let frontmostApp = ws.frontmostApplication {
                if frontmostApp.bundleIdentifier == "com.apple.ScreenSaver.Engine" && screenSaverStartedCount > 0 {
                    screenSaverStartedCount -= 1
                    printMessage("Stopped ScreenSaver : \(screenSaverStartedCount)", kind: "screensaverDetector")
                    if (screenSaverStartedCount == 0) {
                        detectedScreenSaverStart = false
                        printMessage("Detected ScreenSaver End", kind: "screensaverDetector")
                    }
                }
            }
        }
    }

}
