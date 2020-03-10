//
//  TestView.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 10/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import SwiftUI

struct TestView: View {
    var dismiss: (() -> Void)?
   
    var gates = GateType.allTypes
    var recognised: TestRecognised
    var model: TestHelper?
    
    @State var selectedGate = 0
    
    var body: some View {
        VStack(spacing: 10) {
            Text("\(recognised.description.capitalizingFirstLetter()) Gate Recognised!")
                .font(.title)
                .fontWeight(.medium)
            
            Text("Please indicate if this was correct, and if not select the gate you inteded to draw.")
                .font(.body)
            
            Picker(selection: $selectedGate, label: EmptyView()) {
                ForEach(0 ..< gates.count) {
                    Text(self.gates[$0].rawValue.capitalizingFirstLetter())
                }
            }
            .labelsHidden()
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
           
            HStack {
                Button(action: {
                    self.model?.addObservation(with: self.recognised,
                                               correct: true,
                                               intention: nil)
                    self.dismiss?()
                }, label: {
                    Text("Yes")
                })
                
                Button(action: {
                    self.model?.addObservation(with: self.recognised,
                                               correct: true,
                                               intention: self.selectedGate)
                    self.dismiss?()
                }, label: {
                    Text("No")
                })
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(recognised: TestRecognised(description: "and", points: []))
    }
}
