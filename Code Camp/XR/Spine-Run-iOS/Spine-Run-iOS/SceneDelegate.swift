//
//  SceneDelegate.swift
//  Spine-Run-iOS
//
//  Created by 高广校 on 2024/11/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        initRootViewController()
    }

    func initRootViewController() {
        //初始化 配置
        if let application = UIApplication.shared.delegate as? AppDelegate {
            application.initConfig()
        }
        
        let homepageVc = DemoListViewController()
        let nav = UINavigationController(rootViewController: homepageVc)
        nav.setNavigationBarHidden(true, animated: true)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        //判断离线包加载情况
        let coverVC = GXSplashView(frame: window?.bounds ?? .zero, vc: homepageVc)
        coverVC.frame = window?.bounds ?? .zero
        coverVC.superVc = homepageVc
        coverVC.configFinishCompleted = { webUrl in
//            if let value = CustomUtil.getToken() ,!value.isEmpty {
//                MSBApiConfig.shared.appendHeader(["token":value])
//            }
            //进入App
//            homepageVc.enterWebUrl()
        }
        self.window?.addSubview(coverVC)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

