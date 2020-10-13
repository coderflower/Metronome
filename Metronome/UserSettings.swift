//
//  UserSettings.swift
//  Metronome
//
//  Created by 蔡龙君 on 2020/10/13.
//

import UIKit

class UserSettings: ObservableObject {
    @Published var selectedValue: Int {
        didSet {
            UserDefaults.standard.setValue(selectedValue, forKey: "User.selectedStepValue")
            UserDefaults.standard.synchronize()
        }
    }
    
    var progress: CGFloat {
        (CGFloat(value) / CGFloat(maxValue))
    }
    
    var value: Int {
        return min(max(minValue, selectedValue), maxValue)
    }
    
    let minValue: Int = 10
    let maxValue: Int = 300
    init() {
        let selectedValue = UserDefaults.standard.integer(forKey: "User.selectedStepValue")
        self.selectedValue = selectedValue == 0 ? 120 : selectedValue
    }
}


