//
//  FlightRowController.swift
//  LBPWatchAppExample
//
//  Created by Leonardo Barros on 12/6/15.
//  Copyright © 2015 leonardobarros. All rights reserved.
//

import WatchKit

class FlightRowController: NSObject {

    // MARK: - Properties

    @IBOutlet var separator: WKInterfaceSeparator!
    @IBOutlet var originLabel: WKInterfaceLabel!
    @IBOutlet var destinationLabel: WKInterfaceLabel!
    @IBOutlet var flightNumberLabel: WKInterfaceLabel!
    @IBOutlet var statusLabel: WKInterfaceLabel!
    @IBOutlet var planeImage: WKInterfaceImage!

    var flight: Flight? {
        didSet {
            guard let flight = flight else { return }
            
            originLabel.setText(flight.origin)
            destinationLabel.setText(flight.destination)
            flightNumberLabel.setText(flight.number)
            
            if flight.onSchedule {
                statusLabel.setText("On Time")
            } else {
                statusLabel.setText("Delayed")
                statusLabel.setTextColor(UIColor.redColor())
            }
        }
    }
    
    func updateForCheckIn() {
        let color = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
        planeImage.setTintColor(color)
        separator.setColor(color)
    }
}
