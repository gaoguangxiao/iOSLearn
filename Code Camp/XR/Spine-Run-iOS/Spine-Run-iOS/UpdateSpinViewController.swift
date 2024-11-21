//
//  UpdateSpinViewController.swift
//  Spine-Run-iOS
//
//  Created by 高广校 on 2024/11/20.
//

import UIKit
import SwiftUI
import ZKBaseSwiftProject

class UpdateSpinViewController: ZKBaseHostingVc<UpdateSpinView> {
    
    public init() {
        let view = UpdateSpinView()
        super.init(rootView: view)
        self.modalPresentationStyle = .fullScreen
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func backBtnClick() {
        print("返回")
        pop()
//        self.dis()
//        self.dismiss(animated: false)
    }
}


struct UpdateSpinView: View {
    
    var body: some View {
        
        Button {
            
        } label: {
            Text("窗户")
        }

    }
}

@available(iOS 17.0,*)
#Preview(body: {
    UpdateSpinViewController()
})

