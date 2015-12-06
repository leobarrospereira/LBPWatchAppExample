//
//  ScheduleInterfaceController.swift
//  LBPWatchAppExample
//
//  Created by Leonardo Barros on 12/6/15.
//  Copyright © 2015 leonardobarros. All rights reserved.
//

import WatchKit
import Foundation


class ScheduleInterfaceController: WKInterfaceController {

    // MARK: - Properties
    
    @IBOutlet var flightsTable: WKInterfaceTable!
    
    var flights = Flight.allFlights()
    var selectedIndex = 0
    
    
    // MARK: - Interface Life Cycle
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        initTable()
    }
    
    override func didAppear() {
        super.didAppear()
        
        if flights[selectedIndex].checkedIn, let controller = flightsTable.rowControllerAtIndex(selectedIndex) as? FlightRowController {
            animateWithDuration(0.35, animations: { () -> Void in
                controller.updateForCheckIn()
            })
        }
    }
    
    
    // MARK: - Table
    
    func initTable() {
        flightsTable.setNumberOfRows(flights.count, withRowType: "FlightRow")
        for index in 0..<flightsTable.numberOfRows {
            if let controller = flightsTable.rowControllerAtIndex(index) as? FlightRowController {
                controller.flight = flights[index]
            }
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        selectedIndex = rowIndex
        let flight = flights[rowIndex]
        let controllers = flight.checkedIn ? ["Flight", "BoardingPass"] : ["Flight", "CheckIn"]
        presentControllerWithNames(controllers, contexts:[flight, flight])
    }
    
}
