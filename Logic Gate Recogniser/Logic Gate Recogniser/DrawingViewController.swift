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
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let gateClassifier = GateClassifier()

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
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) { }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: [getCanvasImage()] , applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(getCanvasImage(), self, nil, nil)
        canvasView.drawing = PKDrawing()
    }
    
    private func getCanvasImage() -> UIImage {
        var image: UIImage?
        
        UITraitCollection(userInterfaceStyle: .light).performAsCurrent {
            let drawing = canvasView.drawing
            image = drawing.image(from: drawing.bounds, scale: 1.0)
        }
        
        return image!
    }
}

