//
//  BoardingPassInterfaceController.swift
//  LBPWatchAppExample
//
//  Created by Leonardo Barros on 12/6/15.
//  Copyright © 2015 leonardobarros. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class BoardingPassInterfaceController: WKInterfaceController {

    // MARK: - Properties

    @IBOutlet var originLabel: WKInterfaceLabel!
    @IBOutlet var destinationLabel: WKInterfaceLabel!
    @IBOutlet var boardingPassImage: WKInterfaceImage!
    
    var flight: Flight? {
        didSet {
            guard let flight = flight else { return }
            originLabel.setText(flight.origin)
            destinationLabel.setText(flight.destination)
            
            if let _ = flight.boardingPass {
                showBoardingPass()
            }
        }
    }
    
    var session: WCSession? {
        didSet {
            if let session = session {
                session.delegate = self
                session.activateSession()
            }
        }
    }
    
    
    // MARK: - Interface Life Cycle

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let flight = context as? Flight {
            self.flight = flight
        }
    }

    override func didAppear() {
        super.didAppear()

        if let flight = flight where flight.boardingPass == nil && WCSession.isSupported() {
            session = WCSession.defaultSession()
            session?.sendMessage(["reference": flight.reference], replyHandler: { response in
                if let boardingPassData = response["boardingPassData"] as? NSData, boardingPass = UIImage(data: boardingPassData) {
                    flight.boardingPass = boardingPass
                    dispatch_async(dispatch_get_main_queue(), {
                        self.showBoardingPass()
                    })
                }
                
                }, errorHandler: { error in
                    print(error)
                })
        }
    }

    
    // MARK: - Boarding Pass
    
    private func showBoardingPass() {
        boardingPassImage.stopAnimating()
        boardingPassImage.setWidth(100)
        boardingPassImage.setHeight(100)
        boardingPassImage.setImage(flight?.boardingPass)
    }
    
}


// MARK: - WCSessionDelegate

extension BoardingPassInterfaceController: WCSessionDelegate {
    
}
