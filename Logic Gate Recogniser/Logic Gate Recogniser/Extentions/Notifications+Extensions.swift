//
//  Notifications+Extensions.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 29/01/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    //Gates Recognised
    static var gateRecognised:  Notification.Name { Notification.Name("gateRecognised") }

    //State changesw in simulation
    static var gateUpdated: Notification.Name { Notification.Name("gateUpdated") }
    static var simulationFinished: Notification.Name { Notification.Name("simulationFinished") }
    static var simulationStarted: Notification.Name { Notification.Name("simulationStarted") }
    static var endSimulation: Notification.Name { Notification.Name("endSimulation" )}
}
