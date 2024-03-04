import SwiftUI
import Thundering

class DeviceConnectionHandler: Thundering.PortDelegate {
    
    var onConnected: ((Thundering.Port) -> Void)?
    var onDisconnected: ((Thundering.Port) -> Void)?
    var onReceive: ((Thundering.Port, OOData) -> Void)?
    
    // MARK: - PortDelegate
    func port(didConnect port: Thundering.Port) {
        if let onConnected {
            onConnected(port)
        }
        logger.info("port.connected")
    }
    
    func port(didDisconnect port: Thundering.Port) {
        if let onDisconnected {
            onDisconnected(port)
        }
        logger.info("port.disconnected")
    }
    
    func port(port: Thundering.Port, didReceiveData data: OOData) {
        if let onReceive {
            onReceive(port, data)
        }
    }
}

@Observable class DeviceViewModel {
        
    @ObservationIgnored var deviceConnectionHandler = DeviceConnectionHandler()
    @ObservationIgnored var port: DevicePort
    var connected: Bool = false
    var messages: [Data] = []
    
    init() {
        port = DevicePort(delegate: deviceConnectionHandler)
        deviceConnectionHandler.onConnected = { port in
            self.connected = true
        }
        deviceConnectionHandler.onDisconnected = { port in
            self.connected = false
            self.messages = []
        }
        deviceConnectionHandler.onReceive = onReceive
        port.open()
        logger.info("port.opened")
    }
    
    func onReceive(port: Thundering.Port, data: OOData) {
        logger.info("data.received:\(data.dataValue)")
        messages.insert(data.dataValue, at: 0)
    }
}
