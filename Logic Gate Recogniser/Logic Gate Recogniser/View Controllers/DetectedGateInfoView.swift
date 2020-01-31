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
    private var subscriber: AnyCancellable?
    
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
        subscriber = NotificationCenter.Publisher(center: .default, name: .gateRecognised, object: nil)
            .map { notification in return notification.object as! Shape}
            .sink(receiveValue: { shape in self.recognisedGate.text = shape.type.rawValue } )
    }
}
