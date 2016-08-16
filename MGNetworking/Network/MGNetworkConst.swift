//
//  MGNetworkConst.swift
//  MGNetworking
//
//  Created by 高得华 on 16/8/15.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

import UIKit
import SwiftyJSON

/**
 *  请求类型
 */
enum MGAsiNetWorkType:Int {
    case requestTypeGet, requestTypePost, requestTypeDelegate
}

/**
 *  网络状态
 */
enum ReachabilityType: CustomStringConvertible {
    case WWAN
    case WiFi
    
    var description: String {
        switch self {
        case .WWAN: return "WWAN"
        case .WiFi: return "WiFi"
        }
    }
}
enum ReachabilityStatus: CustomStringConvertible  {
    case Offline
    case Online(ReachabilityType)
    case Unknown
    
    var description: String {
        switch self {
        case .Offline: return "Offline"
        case .Online(let type): return "Online (\(type))"
        case .Unknown: return "Unknown"
        }
    }
}


/**
 *  网络请求超时的时间
 */
let MGAsi_API_TIME_OUT = 20

//关于网络检测枚举
let ReachabilityStatusChangedNotification = "ReachabilityStatusChangedNotification"


//-----创建闭包（OC中的block）
/**
 *  请求开始的回调（下载时用到）
 */
typealias MGNetworkStartBlock  = () -> Void

/**
 *  请求成功回调
 *
 *  @param returnData 回调block
 */
typealias MGNetworkSuccessBlock = (JSON?) -> Void

/**
 *  请求失败回调
 *
 *  @param error 回调block
 */
typealias MGNetworkFailureBlock = (NSError?) -> Void

/**
 *  上传文件的block
 */
typealias MGNetworkUploadClosureBlock = (AnyObject?, NSError?,Int64?,Int64?,Int64?)->Void


