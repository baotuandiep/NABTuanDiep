//
//  Obfuscator.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import Foundation

class Obfuscator {

    // MARK: - Variables

    /// The salt used to obfuscate and reveal the string.
    private let _salt: String

    // MARK: - Initialization
    init() {
        _salt = String(describing: AppDelegate.self) + String(describing: NSObject.self)
    }

    init(withSalt salt: String) {
        self._salt = salt
    }

    // MARK: - Instance Methods
    /**
     This method obfuscates the string passed in using the salt
     that was used when the Obfuscator was initialized.

     - parameter string: the string to obfuscate

     - returns: the obfuscated string in a byte array
     */
    func bytesByObfuscatingString(string: String) -> [UInt8] {
        let cipher = [UInt8](_salt.utf8)
        return [UInt8](string.utf8).enumerated().map { $0.element ^ cipher[$0.offset % cipher.count] }
    }

    /**
     This method reveals the original string from the obfuscated
     byte array passed in. The salt must be the same as the one
     used to encrypt it in the first place.

     - parameter key: the byte array to reveal

     - returns: the original string
     */
    func reveal(key: [UInt8]) -> String {
        let cipher = [UInt8](_salt.utf8)
        return String(bytes: key.enumerated().map { $0.element ^ cipher[$0.offset % cipher.count] }, encoding: .utf8) ?? ""
    }
}
