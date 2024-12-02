//
//  DemoListViewController.swift
//  Spine-Run-iOS
//
//  Created by 高广校 on 2024/11/28.
//

import UIKit
import SwiftUICore
import SwiftUI
import ZKBaseSwiftProject

struct Item {
    var name: String
    var vcClass: UIViewController
}

class DemoListViewController: ZKBaseTblViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView?.snp.updateConstraints { make in
            make.top.equalTo(0)
        }

        self.dataArray.append(Item(name: "伙伴之家", vcClass: ViewController()))
        self.dataArray.append(Item(name: "落", vcClass: TriggerViewController()))
        self.dataArray.append(Item(name: "跑", vcClass: RunViewController()))
//        self.tableView?.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        if let item = self.dataArray[indexPath.row] as? Item {
            var listContentConfiguration = cell?.defaultContentConfiguration()
            listContentConfiguration?.text = item.name
            cell?.contentConfiguration = listContentConfiguration
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = self.dataArray[indexPath.row] as? Item {
            push(item.vcClass)
        }
    }
}



@available(iOS 17.0,*)
#Preview {
    UINavigationController(
        rootViewController: DemoListViewController()
    )
}
