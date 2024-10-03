//
//  StudySettingsView.swift
//  StudyOn
//
//  Created by Zhansen Zhalel on 30.09.2024.
//

import SwiftUI

struct StudySettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var focusHour: Int
    @Binding var focusMinute: Int
    @Binding var focusSecond: Int
    
    @Binding var breakHour: Int
    @Binding var breakMinute: Int
    @Binding var breakSecond: Int
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Focus Timer") {
                    HStack {
                        Picker("Duration", selection: $focusHour) {
                            ForEach(0..<24) { hour in
                                Text("\(hour)")
                            }
                        }
                        .pickerStyle(.wheel)
                        Text("hours")
                        
                        Picker("Duration", selection: $focusMinute) {
                            ForEach(0..<60) { hour in
                                Text("\(hour)")
                            }
                        }
                        .pickerStyle(.wheel)
                        Text("min")
                        
                        Picker("Duration", selection: $focusSecond) {
                            ForEach(0..<60) { hour in
                                Text("\(hour)")
                            }
                        }
                        .pickerStyle(.wheel)
                        Text("sec")
                    }
                }
                
                Section("Break Timer") {
                    HStack {
                        Picker("Duration", selection: $breakHour) {
                            ForEach(0..<24) { hour in
                                Text("\(hour)")
                            }
                        }
                        .pickerStyle(.wheel)
                        Text("hours")
                        
                        Picker("Duration", selection: $breakMinute) {
                            ForEach(0..<60) { hour in
                                Text("\(hour)")
                            }
                        }
                        .pickerStyle(.wheel)
                        Text("min")
                        
                        Picker("Duration", selection: $breakSecond) {
                            ForEach(0..<60) { hour in
                                Text("\(hour)")
                            }
                        }
                        .pickerStyle(.wheel)
                        Text("sec")
                    }
                }
            }
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    StudySettingsView(focusHour: .constant(0), focusMinute: .constant(25), focusSecond: .constant(0), breakHour: .constant(0), breakMinute: .constant(5), breakSecond: .constant(0))
        .preferredColorScheme(.dark)
}
