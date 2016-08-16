//
//  NetworkAPI.swift
//  MGNetworking
//
//  Created by 高得华 on 16/8/15.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

import UIKit

class NetworkAPI: NSObject {
    
    class func loadTouTiaoInfo(type:String,
                         success:MGNetworkSuccessBlock,
                         faile:MGNetworkFailureBlock) {
        
        let PATH = BASE_URL + "toutiao/index"
        let params = ["key":"bfc1f26a82392a9c99a5718cb194fc48",
                      "type":type]
        
        MGNetworkManager.getRequstWithURL(PATH, paramsDict: params, successBlock: { (JSON) in
            success(JSON)
            }, failureBlock: { (NSError) in
                faile(NSError)
            }, showHUD: true)
    }
}
