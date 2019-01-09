import Foundation
import os.log

var detector = SleepDetector()

printMessage("ScreenSaver Detector Started...", kind: "screensaverDetector")
RunLoop.current.run()
