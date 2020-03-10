//
//  ViewController.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 16/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import UIKit
import SwiftUI
import PencilKit
import CoreData

class DrawingViewController: UIViewController  {

    let testHelper = TestHelper()
    
    @IBOutlet weak var gateInfoView: DetectedGateInfoView!
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var penToolButton: UIBarButtonItem!
    @IBOutlet weak var erasorToolButton: UIBarButtonItem!
    @IBOutlet weak var resetCanvasButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // General Setup
        self.title = "Recogniser"
        setupPencilInteractions()
        
        // Canvas Setup
        canvasView.canvasViewModel.delegate = canvasView
        
        // Test Setup
        testHelper.delegate = self
    }
    
    @IBAction func penToolTapped(_ sender: Any) {
        canvasView.tool = .pen
    }
    
    @IBAction func erasorToolTapped(_ sender: Any) {
        canvasView.tool = .erasor
    }
    
    @IBAction func resetCanvasTapped(_ sender: Any) {
        canvasView.canvasViewModel.resetState()
    }
}

// MARK: - Drawing Extensions

extension DrawingViewController: UIPencilInteractionDelegate {
    
    func setupPencilInteractions() {
        let interaction = UIPencilInteraction()
        interaction.delegate = self
        view.addInteraction(interaction)
    }
    
    func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
        switch UIPencilInteraction.preferredTapAction {
        case .ignore:
            break
        default:
            if canvasView.tool == .pen {
                canvasView.tool = .erasor
            } else {
                canvasView.tool = .pen
            }
        }
    }
}

// MARK: Testing Extensions

extension DrawingViewController: TestAlertShower {
    
    func showTestAlert(for gate: TestRecognised) {
        var view = TestView(recognised: gate)  
        view.model = testHelper
        view.dismiss = {
            self.dismiss(animated: true, completion: nil)
        }
        
        // Display View
        let vc = UIHostingController(rootView: view)
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.barButtonItem = resetCanvasButton
        present(vc, animated: true, completion:nil)
    }
}

