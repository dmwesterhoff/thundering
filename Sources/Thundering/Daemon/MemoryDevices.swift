/**
 *
 * 	DarkLightning
 *
 *
 *
 *	The MIT License (MIT)
 *
 *	Copyright (c) 2017 Jens Meder
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy of
 *	this software and associated documentation files (the "Software"), to deal in
 *	the Software without restriction, including without limitation the rights to
 *	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 *	the Software, and to permit persons to whom the Software is furnished to do so,
 *	subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in all
 *	copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 *	FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 *	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 *	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 *	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import Foundation

final class MemoryDevices: Devices {
    private let devices: Memory<[Int: Data]>
    private let closure: (Int, Devices) -> (Device)

    // MARK: Init

    convenience init() {
        self.init(
            devices: Memory<[Int: Data]>(initialValue: [:]),
            closure: { (_: Int, _: Devices) -> (Device) in
                DeviceFake()
            }
        )
    }

    convenience init(devices: Memory<[Int: Data]>) {
        self.init(
            devices: devices,
            closure: { (_: Int, _: Devices) -> (Device) in
                DeviceFake()
            }
        )
    }

    required init(devices: Memory<[Int: Data]>, closure: @escaping (Int, Devices) -> (Device)) {
        self.devices = devices
        self.closure = closure
    }

    // MARK: Devices

    func insert(deviceID: Int, data: Data) {
        devices.rawValue[deviceID] = data
    }

    func device(withID deviceID: Int) -> [Device] {
        var result: [Device] = []
        if let _ = devices.rawValue[deviceID] {
            result.append(closure(deviceID, self))
        }
        return result
    }

    func delete(withID deviceID: Int) {
        devices.rawValue[deviceID] = nil
    }
}
