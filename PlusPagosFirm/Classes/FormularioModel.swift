//
//  SHA256Firm.swift
//  PlusPagosFirm
//
//  Created by Andres Ceccoli on 22/01/2019.
//

import UIKit

public class FormularioModel {
    fileprivate var hash: String?
    fileprivate var callbackSuccess: String!
    fileprivate var callbackCancel: String!
    fileprivate var comercio: String!
    fileprivate var sucursalComercio: String! = ""
    fileprivate var transaccionComercioId: String!
    fileprivate var monto: String!
    fileprivate var producto = [String]()
    fileprivate let secretKey: String!
    fileprivate var ip: String!
    
    public init(secretKey: String!) {
        self.secretKey = secretKey
    }
    
    public func hash(_ h: String!) -> FormularioModel {
        hash = h
        return self
    }
    
    public func callbackSuccess(_ cb: String!) -> FormularioModel {
        callbackSuccess = cb
        return self
    }
    
    public func callbackCancel(_ cb: String!) -> FormularioModel {
        callbackCancel = cb
        return self
    }
    
    public func comercio(_ c: String!) -> FormularioModel {
        comercio = c
        return self
    }
    
    public func sucursalComercio(_ s: String!) -> FormularioModel {
        sucursalComercio = s
        return self
    }
    
    public func transaccionComercioId(_ t: String!) -> FormularioModel {
        transaccionComercioId = t
        return self
    }
    
    public func monto(_ m: Double!) -> FormularioModel {
        var mt = m * 100.0
        mt.round()
        monto = "\(mt)"
        return self
    }
    
    public func addProducto(_ p: String!) -> FormularioModel {
        producto.append(p)
        return self
    }
    
    public func ip(_ ip: String!) -> FormularioModel {
        self.ip = ip
        return self
    }
    
    public func toUrlEncodedForm() -> Data? {
        var allowed = CharacterSet.alphanumerics
        allowed.insert(charactersIn: "-._~")
        
        if hash == nil {
            hash = SHA256Firm.getFirm(ipClient: ip, secretKey: secretKey, guidComercio: comercio, sucursalId: sucursalComercio, monto: monto)
        }
        
        var r = "";
        r += "Hash=\(hash!.addingPercentEncoding(withAllowedCharacters: allowed)!)&"
        r += "TransaccionComercioId=\(transaccionComercioId.addingPercentEncoding(withAllowedCharacters: allowed)!)&"
        r += "COMERCIO=\(comercio.addingPercentEncoding(withAllowedCharacters: allowed)!)&"
        
        var i = 0
        for p in producto {
            r += "Producto[\(i)]".addingPercentEncoding(withAllowedCharacters: allowed)! + "=\(p.addingPercentEncoding(withAllowedCharacters: allowed)!)&"
            i += 1
        }
        
        r += "Monto=\(AESEncrypter.encryptString(plainText: monto, phrase: secretKey)!.addingPercentEncoding(withAllowedCharacters: allowed)!)&"
        r += "SucursalComercio=\(AESEncrypter.encryptString(plainText: sucursalComercio, phrase: secretKey)!.addingPercentEncoding(withAllowedCharacters: allowed)!)&"
        r += "CallbackCancel=\(AESEncrypter.encryptString(plainText: callbackCancel, phrase: secretKey)!.addingPercentEncoding(withAllowedCharacters: allowed)!)&"
        r += "CallbackSuccess=\(AESEncrypter.encryptString(plainText: callbackSuccess, phrase: secretKey)!.addingPercentEncoding(withAllowedCharacters: allowed)!)"
        
        return r.data(using: .utf8)
    }
}
