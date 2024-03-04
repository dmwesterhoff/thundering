//
//  IncomingMessages.swift
//  DarkLightning
//
//  Created by Jens Meder on 17.06.17.
//
//

import Foundation

final class IncomingMessages: USBMuxMessage {
    private let messages: [USBMuxMessage]

    required init(messages: [USBMuxMessage]) {
        self.messages = messages
    }

    func decode() {
        for message in messages {
            message.decode()
        }
    }
}
