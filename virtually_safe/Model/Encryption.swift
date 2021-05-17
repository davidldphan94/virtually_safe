//
//  Encryption.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/17/21.
//

import Foundation
import UIKit
import SwiftUI
import RNCryptor

    
let key = "mZ4!IY$o8T"
class Encryption {

    func encrypt(plainTxt: String, encryptionKey: String) -> String {
            let messageData = plainTxt.data(using: .utf8)!
            let cipherData = try RNCryptor.encrypt(data: messageData, withPassword: encryptionKey)
            return cipherData.base64EncodedString()
        }

    func decrypt(encryptedMessage: String, encryptionKey: String) -> String {
        do {
            let encryptedData = Data.init(base64Encoded: encryptedMessage)!
            let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: encryptionKey)
            let decryptedString = String(data: decryptedData, encoding: .utf8)!
            return decryptedString ?? ""
        }
        catch {
            return "Decrypt Failed"
        }
    }
}
