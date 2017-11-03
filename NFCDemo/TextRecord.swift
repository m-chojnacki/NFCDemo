//
//  TextRecord.swift
//  NFCDemo
//
//  Created by Marcin Chojnacki on 03.11.2017.
//  Copyright © 2017 Droids On Roids. All rights reserved.
//

import Foundation

struct TextRecord {
    
    let encoding: String.Encoding
    let language: String
    let value: String
    
    init(data: Data) {
        let statusByte = data[0]
        let encodingByte = (statusByte & 0b10000000) >> 7
        let languageLength = statusByte & 0b00111111
        let languageBytes = data[1...languageLength]
        let valueBytes = data[(1 + languageLength)...]
        
        self.encoding = encodingByte == 0 ? .utf8 : .utf16
        self.language = String(bytes: languageBytes, encoding: .ascii)!
        print(language)
        self.value = String(bytes: valueBytes, encoding: self.encoding)!
    }
}

extension TextRecord: CustomStringConvertible {
    var description: String {
        return value
    }
}
