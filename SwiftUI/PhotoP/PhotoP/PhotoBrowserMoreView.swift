//
//  PhotoBrowserMoreView.swift
//  ZKNASProj
//
//  Created by gaoguangxiao on 2022/10/29.
//

import SwiftUI

@objcMembers
class PhotoBrowserMoreViewVc: NSObject {
    var endMoreVcAction:((_ str:Int) -> Void)?
    func makePhotoBrowserMoreView(superVc:UIViewController) -> UIViewController {
        var view = PhotoBrowserMoreView()
        view.endMoreAction = { s in
            self.endMoreVcAction?(s)
        }
        let Vc = UIHostingController(rootView: view)
//        let Vc = ZKBaseSwiftVc(rootView: view, superVc: superVc)
        Vc.view.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        Vc.view.frame = UIScreen.main.bounds
//        superVc.addChild(Vc)
//        superVc.view.addSubview(Vc.view)
        return Vc
    }
}

struct PhotoBrowserMoreView: View {
    
    var endMoreAction:((_ str:Int) -> Void)?
    
    var body: some View {
            
        VStack {
            Spacer()
            
            Button {
                endMoreAction?(0)
            } label: {
                Text("")
                    .frame(width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height - 50)
                    .background(Color.red)
            }
            
            Spacer()
            
            VStack(alignment: .leading){
//                Button {
//                    endMoreAction?(0)
//                } label: {
//                    HStack(spacing: 10){
//                        Image("browser_more_tag")
//                        Text("标签")
//                            .frame(maxWidth: .infinity,minHeight: 50,alignment: .leading)
//                    }
////                    .background(Color.purple)
//                }
//                .padding(EdgeInsets(top: 10, leading: 22, bottom: 0, trailing: 0))
//                .foregroundColor(Color.black)
////
//
//                Divider()
                
                Button {
                    endMoreAction?(1)
                } label: {
                    HStack(spacing: 10){
                        Image("browser_more_des")
                        Text("描述")
                            .frame(maxWidth: .infinity,minHeight: 50,alignment: .leading)
                    }
//                    .background(Color.purple)
                }.padding(.leading,22)
                    .foregroundColor(Color.black)
                    .frame(height: 50)
                
//                Divider()
                
//                Button {
//                    endMoreAction?(2)
//                } label: {
//                    HStack(spacing: 10){
//                        Image("browser_more_picinfo")
//                        Text("详细信息")
//                            .frame(maxWidth: .infinity,minHeight: 50,alignment: .leading)
//                    }
//                }.padding(.leading,22).padding(.bottom,0)
//                .foregroundColor(Color.black)
                
            }
            .background(Color.white)
            .frame(alignment: .leading)
            .cornerRadius(10)
        }
    }
}

struct PhotoBrowserMoreView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoBrowserMoreView()
    }
}
