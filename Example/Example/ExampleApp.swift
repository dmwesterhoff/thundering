import SwiftUI
import Logging

var logger = Logger(label: "thundering")

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            HostView()
            #else
            DeviceView()
            #endif
        }
        .windowResizability(.contentSize)
    }
}
