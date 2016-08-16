//
//  ViewController.swift
//  MGNetworking
//
//  Created by 高得华 on 16/8/15.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NetworkAPI.loadTouTiaoInfo("junshi", success: { (JSON) in
            
            print(JSON)
            
            }) { (error) in
                
                print("错误是----- \(error)------")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

