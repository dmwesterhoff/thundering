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

final class DisconnectReaction: NSObject, StreamDelegate {
    private let handle: Memory<CFSocketNativeHandle>
    private let state: Memory<Int>
    private let newState: Int

    // MARK: Init

    required init(handle: Memory<CFSocketNativeHandle>, state: Memory<Int>, newState: Int) {
        self.handle = handle
        self.state = state
        self.newState = newState
    }

    // MARK: StreamDelegate

    func stream(_: Stream, handle _: Stream.Event) {
        handle.rawValue = CFSocketInvalidHandle
        state.rawValue = newState
    }
}
