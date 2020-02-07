//
//  AppDelegate.swift
//  GridPhotoDemo
//
//  Created by Phineas.Huang on 2019/9/19.
//  Copyright © 2019 Phineas. All rights reserved.
//

import UIKit

import Alamofire


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let mn:JsonPlaceholderManager = JsonPlaceholderManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let mainController = storyboard.instantiateViewController(withIdentifier: "ViewController")
        let navigationController = UINavigationController(rootViewController: mainController)
        navigationController.navigationBar.isTranslucent = false
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    

        class Child: NSObject {
            let name: String
            // KVO-enabled properties must be @objc dynamic
            @objc dynamic var age: Int

            init(name: String, age: Int) {
                self.name = name
                self.age = age
                super.init()
            }

            func celebrateBirthday() {
                age += 1
            }
        }

        // Set up KVO
        let mia = Child(name: "Mia", age: 5)
//        let observation = mia.observe(\.age, options: [.initial, .old]) { (child, change) in
//            if let oldValue = change.oldValue {
//                print("\(child.name)’s age changed from \(oldValue) to \(child.age)")
//            } else {
//                print("\(child.name)’s age is now \(child.age)")
//            }
//        }

        print("register")
        let observation =  mia.observe(\.age, options: [.initial, .old, .new, .prior]) { (child, change) in
          // 由此可觀察到各個 option 所做的事
          print("initial \(child.age)")
          print("old \(change.oldValue)")
          print("new \(change.newValue)")
          print("is p \(change.isPrior)")
        }

        // Trigger KVO (see output in the console)
        print("💥birthday")
        mia.celebrateBirthday()
        print("💥birthday")
        mia.celebrateBirthday()
        // Deiniting or invalidating the observation token ends the observation
        observation.invalidate()

        // This doesn't trigger the KVO handler anymore
        mia.celebrateBirthday()
        
        return true
    }

   


}

