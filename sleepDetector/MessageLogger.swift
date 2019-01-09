import Foundation
import os.log

struct Log {
    static var general = OSLog(subsystem: "com.sevensignal.sleepdetector", category: "general")
}

func printMessage(_ message: Any, kind: String) {
    if let messageString = message as? String {
        os_log("%{public}s: %{public}s", log: Log.general, type: .default, kind, messageString)
    } else {
        os_log("%{public}s: %{public}@", log: Log.general, type: .default, kind, message as! NSObject)
    }
}
