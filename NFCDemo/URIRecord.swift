//
//  URIRecord.swift
//  NFCDemo
//
//  Created by Marcin Chojnacki on 03.11.2017.
//  Copyright © 2017 Droids On Roids. All rights reserved.
//

import Foundation

struct URIRecord {
    
    let value: String
    
    var asURL: URL {
        return URL(string: value)!
    }
    
    init(data: Data) {
        let payloadLength = data[2]
        let prefixCode = data[4]
        let payloadBytes = data[5...(3 + payloadLength)]
        
        let prefixString = URIRecord.prefixCodeToString(prefixCode)
        let payloadString = String(bytes: payloadBytes, encoding: .ascii)!
        
        self.value = prefixString + payloadString
    }
    
    private static func prefixCodeToString(_ prefixCode: UInt8) -> String {
        switch prefixCode {
        case 0x01: return "http://www."
        case 0x02: return "https://www."
        case 0x03: return "http://"
        case 0x04: return "https://"
        case 0x05: return "tel:"
        case 0x06: return "mailto:"
        case 0x07: return "ftp://anonymous:anonymous@"
        case 0x08: return "ftp://ftp."
        case 0x09: return "ftps://"
        case 0x0A: return "sftp://"
        case 0x0B: return "smb://"
        case 0x0C: return "nfs://"
        case 0x0D: return "ftp://"
        case 0x0E: return "dav://"
        case 0x0F: return "news:"
        case 0x10: return "telnet://"
        case 0x11: return "imap:"
        case 0x12: return "rtsp://"
        case 0x13: return "urn:"
        case 0x14: return "pop:"
        case 0x15: return "sip:"
        case 0x16: return "sips:"
        case 0x17: return "tftp:"
        case 0x18: return "btspp://"
        case 0x19: return "btl2cap://"
        case 0x1A: return "btgoep://"
        case 0x1B: return "tcpobex://"
        case 0x1C: return "irdaobex://"
        case 0x1D: return "file://"
        case 0x1E: return "urn:epc:id:"
        case 0x1F: return "urn:epc:tag:"
        case 0x20: return "urn:epc:pat:"
        case 0x21: return "urn:epc:raw:"
        case 0x22: return "urn:epc:"
        case 0x23: return "urn:nfc:"
        default: return ""
        }
    }
}

extension URIRecord: CustomStringConvertible {
    var description: String {
        return value
    }
}
