# Sleep Detector

This is a spike done to investigate how one might detect if the macOS system's screensaver is activated while running as a Daemon process.

Initially this would have included detecting sleep, screens powered down, etc. This explains the project's name.

Log messages are sent to the Console using the "subsystem" `com.sevensignal.sleepdetector`.
