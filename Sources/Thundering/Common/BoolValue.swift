//
//  BoolValue.swift
//  DarkLightning
//
//  Created by Jens Meder on 18.06.17.
//
//

import Foundation

protocol BoolValue: AnyObject {
    var boolValue: Bool { get set }
}

final class FakeBoolValue: BoolValue {
    // MARK: - Init

    init() {}

    // MARK: - BoolValue

    var boolValue: Bool = false
}
