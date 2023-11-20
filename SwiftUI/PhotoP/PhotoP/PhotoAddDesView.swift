//
//  PhotoAddDesView.swift
//  ZKNASProj
//
//  Created by gaoguangxiao on 2022/10/29.
//  照片添加描述

import SwiftUI

@objcMembers
class PhotoAddDesViewVc: NSObject {
    var endMoreVcAction:((_ str:Int) -> Void)?
    func makePhotoAddDesView(superVc:UIViewController) -> UIViewController {
        let view = PhotoAddDesView()
        let Vc = UIHostingController(rootView: view)
//        Vc.view.backgroundColor = UIColor.zkF7F8FA
        superVc.addChild(Vc)
        superVc.view.addSubview(Vc.view)
        
        return Vc
    }
}

struct PhotoAddDesView: View {
    
    var title: String = ""
    
    @State private var des: String = ""
    
    var body: some View {
        
        VStack{
            VStack{
                HStack{
                    Image("tag_L-00")
                        .resizable()
                        .frame(width: 60,alignment: .leading).padding()
                    VStack(alignment: .leading){
                        Text("标题")
                            .font(Font.system(size: 14))
                        Text("2020年10月8日")
                            .font(Font.system(size: 12))
                            .padding(.top,5)
                    }
                    
                    Spacer()
                }.background(Color.white)
                    .cornerRadius(10)
            }.frame(height: 90)
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 15))
            
            VStack{
                VStack(alignment: .leading){
                    Text("描述内容")
                        .font(Font.system(size: 14))
                        .padding([.leading,.top],15).padding(.bottom,0)
                    VStack {
                        ZKTextView(placeStr: "请输入1-140字的描述", zkText: $des)
                            .frame(height: 121)
                            .background(Color(UIColor.zkFAFAFA))
                            .overlay(RoundedRectangle(cornerRadius: 6)
                                .stroke(Color(UIColor.zkE0E0E0), lineWidth: 0.5))
                    }.padding([.leading,.bottom,.trailing],15)
                }.background(Color.white)
                    .cornerRadius(10)
            }.padding([.leading,.trailing],15)
                
            
            Spacer()
        }.background(Color(UIColor.zkF7F8FA))
    }
}

struct PhotoAddDesView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoAddDesView()
    }
}

struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
