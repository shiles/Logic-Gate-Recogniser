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
import Combine

class DrawingViewController: UIViewController  {
    
    private let testHelper = TestHelper()
    private var simFinishedSub: AnyCancellable?
    private var simStartedSub: AnyCancellable?
    private var previousTool = DrawingTools.erasor
    
    @IBOutlet weak var gateInfoView: DetectedGateInfoView!
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var penToolButton: UIBarButtonItem!
    @IBOutlet weak var erasorToolButton: UIBarButtonItem!
    @IBOutlet weak var linkToolButton: UIBarButtonItem!
    @IBOutlet weak var runSimulationButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // General Setup
        self.title = "Recogniser"
        setupPencilInteractions()
        
        // Canvas Setup
        canvasView.canvasViewModel.delegate = canvasView
        
        // Test Setup
        testHelper.delegate = self
        
        // Simulation Setup
        simFinishedSub = NotificationCenter.Publisher(center: .default, name: .simulationFinished, object: nil)
            .sink(receiveValue: { [weak self] _ in
                DispatchQueue.main.async { self?.runSimulationButton.image = UIImage(systemName: "play.fill") }
            })
        simStartedSub = NotificationCenter.Publisher(center: .default, name: .simulationStarted, object: nil)
            .sink(receiveValue: { [weak self] _ in
                DispatchQueue.main.async { self?.runSimulationButton.image = UIImage(systemName: "stop.fill") }
            })
    }
    
    @IBAction func penToolTapped(_ sender: Any) {
        canvasView.tool = .pen
        updateSelectedBarButton(selected: .pen)
    }
    
    @IBAction func erasorToolTapped(_ sender: Any) {
        canvasView.tool = .erasor
        updateSelectedBarButton(selected: .erasor)
    }
    
    @IBAction func linkToolTapped(_ sender: Any) {
        canvasView.tool = .link
        updateSelectedBarButton(selected: .link)
    }
    
    @IBAction func runSimulationTapped(_ sender: Any) {
        canvasView.canvasViewModel.toggleSimulation()
    }
    
    private func updateSelectedBarButton(selected tool: DrawingTools) {
        penToolButton.image = tool == .pen ? UIImage(systemName: "pencil.circle.fill") : UIImage(systemName: "pencil.circle")
        erasorToolButton.image = tool == .erasor ? UIImage(systemName: "trash.circle.fill") : UIImage(systemName: "trash.circle")
        linkToolButton.image = tool == .link ? UIImage(systemName: "link.circle.fill") : UIImage(systemName: "link.circle")
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
            let current = canvasView.tool
            canvasView.tool = previousTool
            previousTool = current
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
        vc.popoverPresentationController?.barButtonItem = runSimulationButton
        present(vc, animated: true, completion:nil)
    }
}

