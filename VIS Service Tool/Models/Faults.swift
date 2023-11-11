//
//  Faults.swift
//  L9 Service Tool
//
//  Created by Matt Reid on 11/9/2022.
//

import SwiftUI

struct FaultItem: Identifiable {
    var id = UUID()
    var hexCode: String
    var faultDescription: String
}

var faultItems = [
    FaultItem(hexCode: "04", faultDescription: "VIS NO REFERENCE STATE"),
    FaultItem(hexCode: "08", faultDescription: "BAD SEQUENCE NUMBER"),
    FaultItem(hexCode: "0C", faultDescription: "VIS NO HANDSHAKE"),
    FaultItem(hexCode: "10", faultDescription: "BAD PROTOCOL VERSION"),
    FaultItem(hexCode: "14", faultDescription: "OPERATION OVERRIDEN"),
    FaultItem(hexCode: "18", faultDescription: "VIS NO DIAGNOSTICS MESSAGE"),
    FaultItem(hexCode: "1C", faultDescription: "OPERATION CANNOT BE CANCELED"),
    FaultItem(hexCode: "20", faultDescription: "MIC CONFIG CHANGED"),
    FaultItem(hexCode: "24", faultDescription: "MIC MOD VEH SPEED"),
    FaultItem(hexCode: "28", faultDescription: "OPERATION TEMPORARY NOT AVAILABLE"),
    FaultItem(hexCode: "2C", faultDescription: "OPERATION RESTRICTED"),
    FaultItem(hexCode: "30", faultDescription: "OPERATION TIMED OUT"),
    FaultItem(hexCode: "34", faultDescription: "MIC INTERNAL FATAL HARDWARE ERROR"),
    FaultItem(hexCode: "38", faultDescription: "MIC ACCELERATOR INPUT FAULT"),
    FaultItem(hexCode: "3C", faultDescription: "MIC HOIST INPUT FAULT"),
    FaultItem(hexCode: "40", faultDescription: "MIC RETARDER INPUT FAULT"),
    FaultItem(hexCode: "44", faultDescription: "MIC OVERRIDE SWITCH FAULT"),
    FaultItem(hexCode: "48", faultDescription: "MIC PARK BRAKE SWITCH FAULT"),
    FaultItem(hexCode: "4C", faultDescription: "MIC GEAR INPUT FAULT"),
    FaultItem(hexCode: "50", faultDescription: "MIC SERVICE BRAKE INPUT FAULT"),
    FaultItem(hexCode: "54", faultDescription: "MIC VEHICLE SPEED INPUT FAULT"),
    FaultItem(hexCode: "58", faultDescription: "MIC SERVICE BRAKE OUTPUT FAULT"),
    FaultItem(hexCode: "5C", faultDescription: "MIC ACCELERATOR OUTPUT FAULT"),
    FaultItem(hexCode: "60", faultDescription: "MIC RETARDER OUTPUT FAULT"),
    FaultItem(hexCode: "64", faultDescription: "MIC HOIST OUTPUT FAULT"),
    FaultItem(hexCode: "68", faultDescription: "MIC PAYLOAD FAULT"),
    FaultItem(hexCode: "6C", faultDescription: "MIC INCLINATION SENSOR FAULT"),
    FaultItem(hexCode: "78", faultDescription: "MIC SW EXCEPTION"),
    FaultItem(hexCode: "7C", faultDescription: "MIC SETPOINT ERROR"),
    FaultItem(hexCode: "80", faultDescription: "MIC OEM CAN COMMS ERROR"),
    FaultItem(hexCode: "FC", faultDescription: "MIC NON FATAL ERROR"),

]


