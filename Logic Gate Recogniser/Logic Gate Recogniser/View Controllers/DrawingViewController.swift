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
    @IBOutlet weak var penToolButton: UIBarButtonItem!
    @IBOutlet weak var erasorToolButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        // General Setup
        self.title = "Recogniser"
    }
    
    @IBAction func penToolTapped(_ sender: Any) {
        canvasView.tool = .pen
    }
    
    @IBAction func erasorToolTapped(_ sender: Any) {
        canvasView.tool = .erasor
    }
}

