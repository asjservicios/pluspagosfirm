//
//  SHA256Firm.swift
//  PlusPagosFirm
//
//  Created by Andres Ceccoli on 22/01/2019.
//

import UIKit
import CryptoSwift

public class SHA256Firm {
    public static func getFirm(ipClient: String, secretKey: String, guidComercio: String, sucursalId: String, monto: String) -> String {
        let input = Data((ipClient + "*" + guidComercio + "*" + sucursalId + "*" + monto + "*" + secretKey).utf8)
        return input.sha256().toHexString()
    }
}
