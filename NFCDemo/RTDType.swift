//
//  RTDType.swift
//  NFCDemo
//
//  Created by Marcin Chojnacki on 03.11.2017.
//  Copyright © 2017 Droids On Roids. All rights reserved.
//

import Foundation

enum RTDType {
    case text
    case uri
    case smartPoster
    case alternativeCarrier
    case handoverCarrier
    case handoverRequest
    case handoverSelect
    
    private static let allValues: [RTDType] = [
        .text,
        .uri,
        .smartPoster,
        .alternativeCarrier,
        .handoverCarrier,
        .handoverRequest,
        .handoverSelect
    ]
    
    init?(data: Data) {
        guard let foundType = RTDType.allValues
            .first(where: { $0.data == data }) else { return nil }
        
        self = foundType
    }
    
    var data: Data {
        switch self {
        case .text: return Data(bytes: [0x54])
        case .uri: return Data(bytes: [0x55])
        case .smartPoster: return Data(bytes: [0x53, 0x70])
        case .alternativeCarrier: return Data(bytes: [0x61, 0x63])
        case .handoverCarrier: return Data(bytes: [0x48, 0x63])
        case .handoverRequest: return Data(bytes: [0x48, 0x72])
        case .handoverSelect: return Data(bytes: [0x48, 0x73])
        }
    }
}

extension RTDType: CustomStringConvertible {
    var description: String {
        switch self {
        case .text: return "text"
        case .uri: return "uri"
        case .smartPoster: return "smartPoster"
        case .alternativeCarrier: return "alternativeCarrier"
        case .handoverCarrier: return "handoverCarrier"
        case .handoverRequest: return "handoverRequest"
        case .handoverSelect: return "handoverSelect"
        }
    }
}
