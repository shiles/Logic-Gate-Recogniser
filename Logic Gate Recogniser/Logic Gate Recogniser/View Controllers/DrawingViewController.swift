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

class DrawingViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {

    @IBOutlet weak var canvasView: PKCanvasView!
    @IBOutlet weak var gateInfoView: DetectedGateInfoView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let gateClassifier = GateClassifier()
    
    override func viewWillAppear(_ animated: Bool) {
        // General Setup
        self.title = "Recogniser"
        
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
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        let image = getCanvasImage().toBuffer()!
        let guess = try? gateClassifier.prediction(image: image)
    
        guard let g = guess else { return }
        gateInfoView.recognisedGate.text = g.classLabel
        gateInfoView.confidence.text = "Confidence: " + String(format: "%.0f", g.classLabelProbs[g.classLabel]! * 100) + "%"
        print(g.classLabelProbs)
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: [getCanvasImage()], applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(getCanvasImage(), self, nil, nil)
        canvasView.drawing = PKDrawing()
        gateInfoView.recognisedGate.text = "Not Gate Recognised"
        gateInfoView.confidence.text = "Confidence: 100%"
    }
    
    private func getCanvasImage() -> UIImage {
        var image: UIImage?
        
        UITraitCollection(userInterfaceStyle: .light).performAsCurrent {
            let drawing = canvasView.drawing
            image = drawing.image(from: drawing.bounds, scale: 1.0)
        }
        
        return (image?.resized()?.addBackground()!)!
    }
}

