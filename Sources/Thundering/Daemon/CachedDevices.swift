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

final class CachedDevices: Devices {
    private let origin: Devices
    private let cache: Memory<[Int: Device]>

    // MARK: Init

    init(origin: Devices, cache: Memory<[Int: Device]>) {
        self.origin = origin
        self.cache = cache
    }

    // MARK: Devices

    func insert(deviceID: Int, data: Data) {
        origin.insert(deviceID: deviceID, data: data)
        if let device = origin.device(withID: deviceID).first {
            cache.rawValue[deviceID] = device
        }
    }

    func device(withID deviceID: Int) -> [Device] {
        var result: [Device] = []
        if let device = cache.rawValue[deviceID] {
            result.append(device)
        }
        return result
    }

    func delete(withID deviceID: Int) {
        origin.delete(withID: deviceID)
        cache.rawValue[deviceID] = nil
    }
}
