//
//  ViewController.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 16/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import UIKit
import PencilKit

class DrawingViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {

    @IBOutlet weak var canvasView: PKCanvasView!
    
    override func viewWillAppear(_ animated: Bool) {
        // General Setup
        self.title = "Logic Gate Recogniser"
        
        // Set up the canvas view
        canvasView.delegate = self
        canvasView.alwaysBounceVertical = true
        canvasView.allowsFingerDrawing = true
        
        // Set up the tool picker, using the window of our parent because our view has not been added to a window yet.
        if let window = parent?.view.window, let toolPicker = PKToolPicker.shared(for: window) {
            toolPicker.setVisible(true, forFirstResponder: canvasView)
            toolPicker.addObserver(canvasView)
            toolPicker.addObserver(self)
            canvasView.becomeFirstResponder()
        }
    }
    



}

