//
//  MotionDetector.swift
//  L9 Service Tool
//
//  Created by Matt Reid on 8/9/2022.
//

import CoreMotion
import CoreLocation
import SwiftUI
import UIKit

class MotionDetector: ObservableObject {
    private let motionManager = CMMotionManager()
    
    private var timer = Timer()
    private var updateInterval: TimeInterval
    
    @Published var pitch: Double = 0
    @Published var roll: Double = 0
    @Published var yaw: Double = 0
    @Published var yawStart: Double = 0
    @Published var yawAngle: Double = 0
    @Published var rollStart: Double = 0
    @Published var rollAngle: Double = 0
    @Published var showModal: Bool = false
    @Published var dismissModal: Bool = false
    
    var onUpdate: (() -> Void) = {}
    
    init(updateInterval: TimeInterval) {
        self.updateInterval = updateInterval
    }
    
    func start() {
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            timer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { _ in
                self.updateMotionData()
            }
        } else {
            print("Motion data isn't available on this device.")
        }
    }
    
    func updateMotionData() {
        if let data = motionManager.deviceMotion {
            pitch = data.attitude.pitch  * (180.0 / Double.pi)
            roll = data.attitude.roll  * (180.0 / Double.pi)
            yaw = data.attitude.yaw  * (180.0 / Double.pi)
            
            yawView()
            
            rollView()
            
            onUpdate()
        }
        
    }
    
    func stop() {
        motionManager.stopDeviceMotionUpdates()
        timer.invalidate()
    }
    
    deinit {
        stop()
    }
    
    func yawView() {
        
        if yawStart < yaw {
            yawAngle = yaw - yawStart
        }
        else if yawStart > yaw {
            yawAngle = yawStart - yaw
        }
        if yawAngle > 180 {
            yawAngle = 360 - yawAngle
        }
    }
    
    func rollView() {
        
        if rollStart < roll {
            rollAngle = roll - rollStart
        }
        else if rollStart > roll {
            rollAngle = -rollStart - -roll
        }
        if rollAngle < -90 {
            rollAngle = -90
        }
        else if rollAngle > 90 {
            rollAngle = 90
        }
    }
}

extension MotionDetector {
    func started() -> MotionDetector {
        start()
        return self
    }
}



