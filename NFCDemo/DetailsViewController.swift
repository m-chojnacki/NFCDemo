//
//  DetailsViewController.swift
//  NFCDemo
//
//  Created by Marcin Chojnacki on 03.11.2017.
//  Copyright © 2017 Droids On Roids. All rights reserved.
//

import UIKit
import CoreNFC

class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var scrollableLabel: UILabel!
    
    var nfcMessage: NFCNDEFMessage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Let's pretend we only have one record
        if let record = nfcMessage?.records.first {
            setup(with: record)
        }
    }
    
    @IBAction func actionButtonDidTap(_ sender: UIButton) {
        guard let record = nfcMessage?.records.first, let type = RTDType(data: record.type),
            [RTDType.uri, RTDType.smartPoster].contains(type) else { return }
        
        let url = URIRecord(data: record.payload).asURL
        UIApplication.shared.open(url)
    }
    
    private func setup(with record: NFCNDEFPayload) {
        let propertiesToShow = [
            ("identifier", record.identifier.hexEncodedString),
            ("payload", record.payload.hexEncodedString),
            ("type", record.type.hexEncodedString),
            ("RTDType(type)", String(describingOptional: RTDType(data: record.type))),
            ("typeNameFormat", String(describing: record.typeNameFormat)),
            ("formatRecord(payload)", formatRecord(record))
        ]
        
        scrollableLabel.text = propertiesToShow
            .map { name, value in "\(name):\n\(placeholder(value))" }
            .joined(separator: "\n\n")
    }
    
    private func placeholder(_ string: String?) -> String {
        guard let string = string else { return "-" }
        
        return string.isEmpty ? "-" : string
    }
    
    private func formatRecord(_ record: NFCNDEFPayload) -> String? {
        switch RTDType(data: record.type) {
        case .text?: return String(describing: TextRecord(data: record.payload))
        case .uri?, .smartPoster?: return String(describing: URIRecord(data: record.payload))
        default: return nil
        }
    }
}
