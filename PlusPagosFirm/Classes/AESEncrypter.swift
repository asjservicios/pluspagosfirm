//
//  AESEncrypter.swift
//  PlusPagosFirm
//
//  Created by Andres Ceccoli on 22/01/2019.
//

import UIKit
import CryptoSwift

public class AESEncrypter {
    public static func encryptString(plainText: String, phrase: String) -> String? {
        var phraseKey = phrase;
        while phraseKey.count < 32 {
            phraseKey += phraseKey
        }
        let key = String(phraseKey[..<phraseKey.index(phraseKey.startIndex, offsetBy: 32)]).bytes
        let iv = "1234567890123456".bytes
        
        do {
            let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs5)
            let encrypted = try aes.encrypt(plainText.bytes)
            
            var combinedIvCt = [UInt8]()
            combinedIvCt.append(contentsOf: iv)
            combinedIvCt.append(contentsOf: encrypted)
            
            return combinedIvCt.toBase64()
        } catch {
            return nil
        }
    }
    
    public static func decryptString(encryptedText: String, phrase: String) -> String? {
        var phraseKey = phrase;
        while phraseKey.count < 32 {
            phraseKey += phraseKey
        }
        let key = String(phraseKey[..<phraseKey.index(phraseKey.startIndex, offsetBy: 32)]).bytes
        
        let encryptedBytes = Array<UInt8>(base64: encryptedText)
        
        let iv = Array<UInt8>(encryptedBytes[..<AES.blockSize])
        let cipherText = encryptedBytes[AES.blockSize...]
        
        do {
            let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs5)
            let decrypted = try aes.decrypt(cipherText)
            
            return String(bytes: decrypted, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
