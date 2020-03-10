//
//  TestHelper.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 10/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import CoreData
import Combine
import UIKit

protocol TestAlertShower {
    func showTestAlert(for gate: TestRecognised)
}

struct TestRecognised {
    let description: String
    let points: [CGPoint]
}

class TestHelper {
    
    private var persistentContainer: NSPersistentContainer
    private lazy var context: NSManagedObjectContext = { self.persistentContainer.viewContext }()
    private var testSubscriber: AnyCancellable?
    var delegate: TestAlertShower?
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        persistentContainer = appDelegate.persistentContainer
        
        testSubscriber = NotificationCenter.Publisher(center: .default, name: .testRecognised, object: nil)
            .receive(on: RunLoop.main)
            .map { notification in return notification.object as! TestRecognised}
            .sink(receiveValue: { gate in self.delegate?.showTestAlert(for: gate) })
    }
    
    func addObservation(with gate: TestRecognised, correct: Bool) {
        guard let obs = NSEntityDescription.insertNewObject(forEntityName: "Observation", into: context) as? Observation else { return }
        obs.correct = correct
        obs.recognised = gate.description
        obs.points = gate.points as NSObject
        self.save()
    }
    
    private func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Save error \(error)")
            }
        }
    }
    
}
