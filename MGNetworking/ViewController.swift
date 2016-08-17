//
//  ViewController.swift
//  MGNetworking
//
//  Created by 高得华 on 16/8/15.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

/** 初次学习Swift语言，好多地方都需要改进，请各位大牛指点。QQ：1043902770 谢谢！
 * 本人参考了OC中我比较喜欢常用的一种二次开发网络封装：超强 AFN 封装，它包含了Block及delegate和action三种方法进行网络请求。按照它的思想进行了封装此网络请求
 * 使用的网络请求的方法是参考另一个swift版本的 “Swift 请求类,一般请求就用它” 网络请求，一些必要的方法是按照此网络请求的方法进行做的。
 * 再次感谢所用的人员贡献。非常感谢！
 */


/**
 * 在这里强调一下使用此 网络请求的二次开发需要导入的第三方库：
 * Alamofire、MBProgressHUD、SVProgressHUD、SwiftyJSON
 * 初次学习swift还有好多地方不太明白，还需要继续的努力。请各位多多指点，共同学习，共同进步。
 */

/**
 * 目前本人的工作完成的情况：GET及POST请求使用 block和Delegate已经完成，能够正常使用。文件上传和文件下载没有亲测，请慎用。
 * 代理的方法并不是我想要的，如何将代理中的方法弄成可选性的，暂时还在继续学习。所以能使用block请使用block，勿用delegate。
 *本人希望得到大神的指点，谢谢！
 */

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

