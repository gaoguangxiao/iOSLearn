//
//  View+Extensions.swift
//  003_ARF
//
//  Created by 高广校 on 2024/2/26.
//

import SwiftUI

extension View {
    
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true:
            self.hidden()
        case false: self
        }
    }
}
