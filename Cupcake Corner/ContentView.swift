//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Görkem Güray on 24.06.2024.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    @State private var counter = 0
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Button("Tap Count: \(counter)") {
            counter += 1
        }
        .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter)
        
        Button("Tap ME", action: complexSuccess)
            .onAppear(perform: prepareHaptics)
    } //body
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        } //cach
        
    } //func prepareHaptics
    
    func complexSuccess() {
        //make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        //create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.2)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1-i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1-i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        //convert those evenets into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }

        
    } //func complexSuccess
    
    
    
} //ContentView

#Preview {
    ContentView()
}
