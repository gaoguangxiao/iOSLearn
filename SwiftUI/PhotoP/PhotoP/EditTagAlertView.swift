//
//  EditTagAlertView.swift
//  ZKNASProj
//
//  Created by gaoguangxiao on 2022/10/26.
//

import SwiftUI

@objcMembers
class EditTagAlertViewVc: NSObject {
    ///输入字符
    var tagEndVcEdit:((_ str:String) -> Void)?
    ///
    func makeEditTagAlertView() -> UIViewController {
        var editTagView = EditTagAlertView()
        editTagView.tagEndEdit = { s in
            self.tagEndVcEdit?(s)
        }
        let Vc = UIHostingController(rootView: editTagView)
        Vc.view.backgroundColor = UIColor.zkColor("#000000", alpha: 0.3)
        Vc.view.frame = UIScreen.main.bounds
        return Vc
    }
}

struct EditTagAlertView: View {
    var tagEndEdit:((_ str:String) -> Void)?
    @State private var tagStr: String = ""
    var body: some View {
        VStack(spacing: 0){
            Spacer()
            Text("修改名称")
                .font(.system(size: 16).bold())
                .foregroundColor(Color(.zk333333))
                .frame(height:52)
                .frame(alignment: .center)
            
            TextField("输入标签",text: $tagStr)
                .overlay(RoundedRectangle(cornerRadius: 6)
                    .stroke(Color(UIColor.zkCCCCCC), lineWidth: 1))
                .frame(height: 35)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
            
            HStack {
                Button(action: {
                    tagEndEdit?("")
                }, label: {
                    Text("取消")
                        .foregroundColor(Color(.zk999999))
                        .font(.system(size: 14).bold())
                        .frame(minWidth: 10,maxWidth: .infinity,minHeight: 60)
                })
                
                Rectangle()
                    .fill(Color(UIColor.zkColor("#C4C4C4")))
                    .frame(width: 1,height:30)

                Button(action: {
                    tagEndEdit?(tagStr)
                }, label: {
                    Text("确定")
                        .foregroundColor(Color(.zk3179E5))
                        .font(.system(size: 14).bold())
                        .frame(minWidth: 10,maxWidth: .infinity,minHeight: 60)
                })
            }
        }
        .frame(width: UIScreen.main.bounds.size.width - 80)
        .background(Color.white)
        .cornerRadius(15)
    }
}

struct EditTagAlertView_Previews: PreviewProvider {
    static var previews: some View {
        EditTagAlertView()
    }
}
