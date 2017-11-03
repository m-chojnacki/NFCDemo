//
//  Extensions.swift
//  NFCDemo
//
//  Created by Marcin Chojnacki on 03.11.2017.
//  Copyright © 2017 Droids On Roids. All rights reserved.
//

import CoreNFC

extension String {
    init<Subject>(describingOptional instance: Subject?) {
        if let instance = instance {
            self.init(describing: instance)
        } else {
            self.init("nil")
        }
    }
}

extension Data {
    var hexEncodedString: String {
        return map { String(format: "%02hhx", $0) }.joined(separator: " ")
    }
}

extension NFCTypeNameFormat: CustomStringConvertible {
    public var description: String {
        switch self {
        case .empty: return "empty"
        case .nfcWellKnown: return "nfcWellKnown"
        case .media: return "media"
        case .absoluteURI: return "absoluteURI"
        case .nfcExternal: return "nfcExternal"
        case .unknown: return "unknown"
        case .unchanged: return "unchanged"
        }
    }
}
