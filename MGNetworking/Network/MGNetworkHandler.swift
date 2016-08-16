//
//  MGNetworkHandler.swift
//  MGNetworking
//
//  Created by 高得华 on 16/8/16.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

import UIKit
import SystemConfiguration


/**
 * 使用dispatch_once可以保证其中的代码只执行一次
 */
class MGNetworkHandler: NSObject{

    //单例模式
    static func shareMGNetworkHandler() -> MGNetworkHandler {
        struct Singleton {
            static var onceToken: dispatch_once_t = 0
            static var mgNetworkHandler: MGNetworkHandler?
        }
        
        dispatch_once(&Singleton.onceToken, {

            Singleton.mgNetworkHandler = MGNetworkHandler()
        })
        
        return Singleton.mgNetworkHandler!
    }
    
     private override init(){}
    
    /**
     * 网络请求总的 items
     */
    var items = [MGNetworkItem]()
    
    /**
     *   单个网络请求项
     */
    var netWorkItem: MGNetworkItem?
    
    /**
     *  networkError
     */
    let networkError = Bool()
    
    /**
     *  创建一个网络请求项
     *
     *  @param url          网络请求URL
     *  @param networkType  网络请求方式
     *  @param params       网络请求参数
     *  @param delegate     网络请求的委托，如果没有取消网络请求的需求，可传nil
     *  @param showHUD      是否显示HUD
     *  @param successBlock 请求成功后的block
     *  @param failureBlock 请求失败后的block
     *
     *  @return 根据网络请求的委托delegate而生成的唯一标示
     */
    func conURL(url:String,
                networkType:MGAsiNetWorkType,
                params:[String:AnyObject]?,
                showHUD:Bool,
                delegate:MGNetworkDelegate?,
                successBlock:MGNetworkSuccessBlock?,
                failureBlock:MGNetworkFailureBlock?) -> MGNetworkItem? {
        if networkError {
            
            if failureBlock != nil {
                
                failureBlock!(nil)
            }
            
            return nil
        }
        
        netWorkItem = MGNetworkItem()
        netWorkItem!.requestWithtype(networkType, URLString: url, params: params!, showHUD: showHUD,delegate: delegate, successBlock: { (JSON) in
            
            successBlock?(JSON)
            
            }) { (NSError) in
                failureBlock?(NSError)
        }
        
        items.append(netWorkItem!)
        
        return netWorkItem!
    }
    
    
    
    /**
     *   取消所有正在执行的网络请求项
     */
    class func cancelAllNetItems() {
        
        let handler = MGNetworkHandler.shareMGNetworkHandler()
        handler.items .removeAll()
         handler.netWorkItem = nil
    }
    
    /**
    *  //检测网络 监听网络状态的变化
    */

    class func checkConnect()->Bool {
        let status =  MGNetworkHandler.connectionStatus()
        switch status{
        case .Unknown,.Offline:
            //print("无网络")
            return false
        case .Online(.WWAN):
            //print("y有网络")
            return true
        case .Online(.WiFi):
            //print("有wifi请链接")
            return true
        }
    }
    
    //下面是关于网络检测的方法
    class func connectionStatus() -> ReachabilityStatus {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(&zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else {
            return .Unknown
        }
        
        var flags : SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .Unknown
        }
        return ReachabilityStatus(reachabilityFlags: flags)
    }
    
    class func monitorReachabilityChanges() {
        let host = "google.com"
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        let reachability = SCNetworkReachabilityCreateWithName(nil, host)!
        
        SCNetworkReachabilitySetCallback(reachability, { (_, flags, _) in
            let status = ReachabilityStatus(reachabilityFlags: flags)
            
            NSNotificationCenter.defaultCenter().postNotificationName(ReachabilityStatusChangedNotification,
                object: nil,
                userInfo: ["Status": status.description])
            
            }, &context)
        
        SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetMain(), kCFRunLoopCommonModes)
    }
}

extension ReachabilityStatus {
    private init(reachabilityFlags flags: SCNetworkReachabilityFlags) {
        let connectionRequired = flags.contains(.ConnectionRequired)
        let isReachable = flags.contains(.Reachable)
        let isWWAN = flags.contains(.IsWWAN)
        
        if !connectionRequired && isReachable {
            if isWWAN {
                self = .Online(.WWAN)
            } else {
                self = .Online(.WiFi)
            }
        } else {
            self =  .Offline
        }
    }
}
