//
//  NavBarViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Abdul-Mujib Aliu on 3/25/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class NavBarViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Make color of title
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        self.navigationBar.tintColor = .white
        self.navigationBar.isTranslucent = false
        
        self.navigationBar.barTintColor = UIColor(red: 113.0/255.0, green: 121.0/255.0, blue: 255.0/255.0, alpha: 1)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
