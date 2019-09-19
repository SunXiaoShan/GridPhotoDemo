//
//  ViewController.swift
//  GridPhotoDemo
//
//  Created by Phineas.Huang on 2019/9/19.
//  Copyright © 2019 Phineas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction func actionNextButton(_ sender: Any) {
        switchToJsonPlaceholderPage()
    }
    
    func switchToJsonPlaceholderPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "JsonPlaceholderViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

