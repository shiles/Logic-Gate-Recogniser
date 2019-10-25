//
//  ViewController.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 16/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import UIKit
import PencilKit
import Combine

class DrawingViewController: UIViewController  {

    @IBOutlet weak var gateInfoView: DetectedGateInfoView!
    @IBOutlet weak var canvasView: CanvasViewViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        // General Setup
        self.title = "Recogniser"
    }
}

