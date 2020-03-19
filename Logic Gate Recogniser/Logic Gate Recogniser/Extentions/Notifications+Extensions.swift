//
//  Notifications+Extensions.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 29/01/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    //Shapes + Gates Recognised
    static var gateRecognised:  Notification.Name { Notification.Name("gateRecognised") }
    static var shapeRecognised: Notification.Name { Notification.Name("shapeRecognised") }
    static var testRecognised:  Notification.Name { Notification.Name("testRecognised") }

    //State changed in simulation
    static var gateUpdated: Notification.Name { Notification.Name("gateUpdated")}
}
