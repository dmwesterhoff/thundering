//
//  DataDecodings.swift
//  DarkLightning
//
//  Created by Jens Meder on 18.06.17.
//
//

import Foundation

final class DataDecodings: DataDecoding {
    private let decodings: [DataDecoding]

    // MARK: Init

    required init(decodings: [DataDecoding]) {
        self.decodings = decodings
    }

    // MARK: DataDecoding

    func decode(data: OOData) {
        for decoding in decodings {
            decoding.decode(data: data)
        }
    }
}
