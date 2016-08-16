//
//  MGNetworkDelegate.swift
//  MGNetworking
//
//  Created by 高得华 on 16/8/16.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

import UIKit
import SwiftyJSON

/**
 *   AFN 请求封装的代理协议
 */
protocol MGNetworkDelegate {
 
    /**
     *   请求结束
     *
     *   @param returnData 返回的数据
     */
     func requestSuccessFinishLoading(result:JSON?)
    
    /**
     *   请求失败
     *
     *   @param error 失败的 error
     */
    func requestdidFailWithError(error: NSError?)
    
    /**
     *   网络请求项即将被移除掉
     *
     *   @param itme 网络请求项
     */
    //func netWorkWillDealloc(item:MGNetworkItem)
}