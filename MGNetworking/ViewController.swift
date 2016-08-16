//
//  ViewController.swift
//  MGNetworking
//
//  Created by 高得华 on 16/8/15.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController , MGNetworkDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let delegateBtn = UIButton(type: .Custom)
        delegateBtn.addTarget(self, action:  #selector(ViewController.delegateBtnAct(_:)), forControlEvents: .TouchUpInside)
        delegateBtn.setTitle("DelegateRequest", forState: .Normal)
        delegateBtn.frame = CGRectMake(50, 100, 150, 36)
        delegateBtn.backgroundColor = UIColor.blackColor()
        view.addSubview(delegateBtn)
        delegateBtn.tag = 100
        
        let blockBtn = UIButton(type: .Custom)
        blockBtn.addTarget(self, action: #selector(ViewController.delegateBtnAct(_:)), forControlEvents: .TouchUpInside)
        blockBtn.setTitle("BlockRequest", forState: .Normal)
        blockBtn.frame = CGRectMake(50, 150, 160, 36)
        blockBtn.backgroundColor = UIColor.purpleColor()
        view.addSubview(blockBtn)
        blockBtn.tag = 101
    }

    func delegateBtnAct(sender:UIButton){
        
        if sender.tag == 100 {
            
            NetworkAPI.loadTouTiaoInfo("top", delegate: self, showHUD: true)
        }else if sender.tag == 101 {
            
            NetworkAPI.loadTouTiaoInfo("junshi", success: { (JSON) in

                print("----block------\(JSON)-----block----")

                }, faile: { (NSError) in

                    print("---@@@@@---block----\(NSError)---block--@@@@@@----")
                    
                }, showHUD: true)
        }
    }
    
    
// ------------MGNetworkDelegate------------ \\
    func requestSuccessFinishLoading(result: JSON?) {
        
        print("-----delegate-----\(result!)-----delegate----")
    }
    
    func requestdidFailWithError(error: NSError?) {
        
        print("---@@@@@---delegate----\(error!)---delegate--@@@@@@----")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

