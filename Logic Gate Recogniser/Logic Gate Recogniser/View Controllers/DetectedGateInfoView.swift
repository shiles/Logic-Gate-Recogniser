//
//  DetectedGateInfoView.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 17/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import UIKit
import Combine

class DetectedGateInfoView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var recognisedGate: UILabel!
    @IBOutlet weak var recognisedShape: UILabel!
    private var gateSubscriber: AnyCancellable?
    private var shapeSubscriber: AnyCancellable?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        // Load XIB
        Bundle.main.loadNibNamed("DetectedGateInfo", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // Style
        self.roundCorners()
        
        // Listener
        gateSubscriber = NotificationCenter.Publisher(center: .default, name: .gateRecognised, object: nil)
//            .map { notification in return GateType.getGateType(from: notification.object) }
            .map { notification in return notification.object as AnyObject as! Gate }
            .sink(receiveValue: { gate in self.recognisedGate.text = gate.description } )
           
        shapeSubscriber = NotificationCenter.Publisher(center: .default, name: .shapeRecognised, object: nil)
            .map { notification in return notification.object as! Shape}
            .sink(receiveValue: { shape in self.recognisedShape.text = shape.type.rawValue } )
    }
}
