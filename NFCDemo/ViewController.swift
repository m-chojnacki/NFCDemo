//
//  ViewController.swift
//  NFCDemo
//
//  Created by Marcin Chojnacki on 03.11.2017.
//  Copyright © 2017 Droids On Roids. All rights reserved.
//

import UIKit
import CoreNFC

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Data(bytes: [0x54]) == Data(bytes: [0x54]))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? DetailsViewController,
            let message = sender as? NFCNDEFMessage else { return }
        
        detailsVC.nfcMessage = message
    }
    
    @IBAction func scanButtonDidTap(_ sender: UIButton) {
        let nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession.alertMessage = "Tap the NFC tag to scan"
        nfcSession.begin()
    }
}

extension ViewController: NFCNDEFReaderSessionDelegate {
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // Single tag read xD
        print(error)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // We scan only one tag so we don't need a whole array
        guard let firstMessage = messages.first else { return }
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "DetailsSegue", sender: firstMessage)
        }
    }
}
