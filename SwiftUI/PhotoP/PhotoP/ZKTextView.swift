//
//  ZKTextView.swift
//  ZKNASProj
//
//  Created by gaoguangxiao on 2022/11/1.
//

import SwiftUI

struct ZKTextView: UIViewRepresentable{
    
    var placeStr: String
    
    @Binding var zkText: String
    
    let view = UITextView()
    
    func makeUIView(context: Context) -> UITextView {
        view.isScrollEnabled = true
        view.isEditable = true
//        view.font = UIFont.regular14
//        view.textColor = UIColor.zk666666
//        view.placeholder = placeStr
        view.backgroundColor = UIColor.clear
        view.text = zkText
        view.isUserInteractionEnabled = true
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = zkText
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self,text: self.$zkText)
    }
}


//
class Coordinator: NSObject, UITextViewDelegate {
    
    var parent: ZKTextView
    
    var text: Binding<String>
    
    init(_ textView: ZKTextView,text:Binding<String>) {
        self.parent = textView

        self.text = text
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.text.wrappedValue = textView.text
    }
}
