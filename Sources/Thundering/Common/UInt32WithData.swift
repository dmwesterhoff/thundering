//
//  UInt32WithData.swift
//  DarkLightning
//
//  Created by Jens Meder on 18.06.17.
//
//

import Foundation

final class UInt32WithData: OOUInt32 {
    private let data: OOData

    // MARK: Init

    required init(data: OOData) {
        self.data = data
    }

    // MARK: OOUInt32

    var rawValue: UInt32 {
        return data.dataValue.withUnsafeBytes { (ptr: UnsafePointer<UInt32>) -> UInt32 in
            ptr.pointee
        }
    }
}
