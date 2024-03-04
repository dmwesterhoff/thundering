import SwiftUI
import Thundering

class HostConnectionHandler: DaemonDelegate, DeviceDelegate {
    
    var onDisconnected: ((Device) -> Void)?
    var onConnected: ((Device) -> Void)?
    var onFailedToConnect: ((Device) -> Void)?
    var onReceive: ((Device, OOData) -> Void)?
    var onAttached: ((Daemon, Device) -> Void)?
    var onDetached: ((Daemon, Device) -> Void)?
    
    // MARK: - DeviceDelegate
    func device(didDisconnect device: Thundering.Device) {
        if let onDisconnected {
            onDisconnected(device)
        }
        logger.info("device.didDisconnect")
    }
    
    func device(didConnect device: Thundering.Device) {
        if let onConnected {
            onConnected(device)
        }
        logger.info("device.didConnect")
    }
    
    func device(didFailToConnect device: Thundering.Device) {
        if let onFailedToConnect {
            onFailedToConnect(device)
        }
        logger.info("device.didFailToConnect")
    }
    
    func device(_ device: Thundering.Device, didReceiveData data: Thundering.OOData) {
        if let onReceive {
            onReceive(device, data)
        }
    }
    
    // MARK: - DaemonDelegate
    func daemon(_ daemon: Thundering.Daemon, didAttach device: Thundering.Device) {
        if let onAttached {
            onAttached(daemon, device)
        }
        logger.info("device.didAttach")
        device.connect()
    }
    
    func daemon(_ daemon: Thundering.Daemon, didDetach device: Thundering.Device) {
        if let onDetached {
            onDetached(daemon, device)
        }
        logger.info("device.didDetach")
        device.disconnect()
    }
}

@Observable class HostViewModel {
    
    @ObservationIgnored var hostHandler = HostConnectionHandler()
    @ObservationIgnored var daemon: USBDaemon
    var connected: Bool = false
    var device: Device?
    var messages: [Data] = []
    
    init() {
        daemon = USBDaemon(delegate: hostHandler, deviceDelegate: hostHandler)
        hostHandler.onConnected = { device in
            self.connected = true
            self.device = device
        }
        hostHandler.onDisconnected = { device in
            self.connected = false
            self.device = nil
            self.messages = []
        }
        hostHandler.onReceive = onReceive
        daemon.start()
        logger.info("daemon.started")
    }
    
    func onReceive(port: Device, data: OOData) {
        logger.info("data.received:\(data.dataValue)")
        messages.insert(data.dataValue, at: 0)
    }
}
