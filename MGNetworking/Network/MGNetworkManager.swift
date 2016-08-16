//
//  MGNetworkManager.swift
//  MGNetworking
//
//  Created by 高得华 on 16/8/16.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

import UIKit

class MGNetworkManager: NSObject {

    //单例模式 ---- 使用dispatch_once可以保证其中的代码只执行一次
    class func shareMGNetworkManager() -> MGNetworkManager{
        struct Singleton {
            static var onceToken : dispatch_once_t = 0
            static var single:MGNetworkManager?
        }
        
        dispatch_once(&Singleton.onceToken) { 
            Singleton.single = MGNetworkManager()
        }
        
        return Singleton.single!
    }
    
    /**
     *   GET请求通过Block 回调结果
     *
     *   @param url          url
     *   @param paramsDict   paramsDict
     *   @param successBlock  成功的回调
     *   @param failureBlock  失败的回调
     *   @param showHUD      是否加载进度指示器
     */
    class func getRequstWithURL(url:String,
                          paramsDict:[String:AnyObject]?,
                          successBlock:MGNetworkSuccessBlock,
                          failureBlock:MGNetworkFailureBlock,
                          showHUD:Bool) {
        MGNetworkManager.getRequstWithURLSharing(url, paramsDict: paramsDict, successBlock: successBlock, failureBlock: failureBlock, showHUD: showHUD)
    }
    
    /**
     *   通过 Block回调结果
     *
     *   @param url           url
     *   @param paramsDict    请求的参数字典
     *   @param successBlock  成功的回调
     *   @param failureBlock  失败的回调
     *   @param showHUD       是否加载进度指示器
     */
    class func postReqeustWithURL(url:String,
                                  params:[String:AnyObject]?,
                                  successBlock:MGNetworkSuccessBlock,
                                  failureBlock:MGNetworkFailureBlock,
                                  showHUD:Bool){
       
        MGNetworkManager.postReqeustWithSharing(url, params: params!, successBlock: successBlock, failureBlock: failureBlock, showHUD: showHUD)
    }
    
    /**
     *  上传文件
     *
     *  @param url          上传文件的 url 地址
     *  @param paramsDict   参数字典
     *  @param successBlock 成功
     *  @param failureBlock 失败
     *  @param showHUD      显示 HUD
     */
    
    
    
    
    /**
     *   GET请求的公共方法 一下三种方法都调用这个方法 根据传入的不同参数觉得回调的方式
     *
     *   @param url           ur
     *   @param paramsDict   paramsDict
     *   @param target       target
     *   @param action       action
     *   @param delegate     delegate
     *   @param successBlock successBlock
     *   @param failureBlock failureBlock
     *   @param showHUD      showHUD
     */
    class func getRequstWithURLSharing(url:String,
                                       paramsDict:[String:AnyObject]?,
                                       successBlock:MGNetworkSuccessBlock,
                                       failureBlock:MGNetworkFailureBlock,
                                       showHUD:Bool){
        
        MGNetworkHandler.shareMGNetworkHandler().conURL(url, networkType: MGAsiNetWorkType.requestTypeGet, params: paramsDict, showHUD: showHUD, successBlock: successBlock, failureBlock: failureBlock)
    }
    
    /**
     *   发送一个 POST请求的公共方法 传入不同的回调参数决定回调的方式
     *
     *   @param url           ur
     *   @param paramsDict   paramsDict
     *   @param target       target
     *   @param action       action
     *   @param delegate     delegate
     *   @param successBlock successBlock
     *   @param failureBlock failureBlock
     *   @param showHUD      showHUD
     */
    class func postReqeustWithSharing(url:String,
                                      params:[String:AnyObject]?,
                                      successBlock:MGNetworkSuccessBlock,
                                      failureBlock:MGNetworkFailureBlock,
                                      showHUD:Bool) {
       
        MGNetworkHandler.shareMGNetworkHandler().conURL(url, networkType: MGAsiNetWorkType.requestTypePost, params: params, showHUD: showHUD, successBlock: successBlock, failureBlock: failureBlock)
    }
}
