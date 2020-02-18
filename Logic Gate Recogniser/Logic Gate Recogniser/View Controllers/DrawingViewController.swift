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
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var penToolButton: UIBarButtonItem!
    @IBOutlet weak var erasorToolButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // General Setup
        self.title = "Recogniser"
        setupPencilInteractions()
        
        // Canvas Setup
        canvasView.canvasViewModel.delegate = canvasView
    }
    
    @IBAction func penToolTapped(_ sender: Any) {
        canvasView.tool = .pen
    }
    
    @IBAction func erasorToolTapped(_ sender: Any) {
        canvasView.tool = .erasor
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

