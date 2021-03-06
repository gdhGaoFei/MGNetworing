//
//  MGNetworkItem.swift
//  MGNetworking
//
//  Created by 高得华 on 16/8/15.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON
import MBProgressHUD

class MGNetworkItem: NSObject {
    
    var hud:MBProgressHUD?
    
    //    //网络请求中的GET,Post,DELETE
    func requestWithtype(networkType:MGAsiNetWorkType,
                         URLString:String,
                         params:[String:AnyObject],
                         showHUD:Bool,
                         delegate:MGNetworkDelegate?,
                         successBlock:MGNetworkSuccessBlock?,
                         failureBlock:MGNetworkFailureBlock?){
        
        if showHUD {
            print("正在加载数据...")
            let windowHUD = UIApplication.sharedApplication().keyWindow
            hud = MBProgressHUD(window: windowHUD)
            windowHUD?.addSubview(hud!)
            hud?.show(true)
            //            SVProgressHUD.showWithStatus("正在加载,请稍后...")
        }
        
        switch networkType {
        case MGAsiNetWorkType.requestTypeGet:
            
            Alamofire.request(.GET, URLString, parameters: params).responseJSON {(response) in
                self.hud?.hide(true)
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("--")
                
                failureBlock?(response.result.error!)
                delegate?.requestdidFailWithError(response.result.error)
                
                    return
                }
                
                if let value = response.result.value {
                    let dict = JSON(value)
                    successBlock?(dict)
                    delegate?.requestSuccessFinishLoading(dict)
                }
            }
        case .requestTypePost:
            Alamofire.request(.POST, URLString, parameters: params).responseJSON {(response) in
                self.hud?.hide(true)
                guard response.result.isSuccess else {
                   failureBlock?(response.result.error!)
                   delegate?.requestdidFailWithError(response.result.error)
                    return
                }
                
                if let value = response.result.value {
                    let dict = JSON(value)
                    successBlock?(dict)
                    delegate?.requestSuccessFinishLoading(dict)
                }
            }
        case .requestTypeDelegate://待完善
            
            Alamofire.request(.DELETE, URLString, parameters: params).responseJSON{response in
                self.hud?.hide(true)
                guard response.result.isSuccess else {
                   failureBlock?(response.result.error!)
                   delegate?.requestdidFailWithError(response.result.error)
                    return
                }
                
                if let value = response.result.value {
                    let dict = JSON(value)
                    successBlock?(dict)
                    delegate?.requestSuccessFinishLoading(dict)
                }
            }
        }
    }
    
//---------------- //功能待完善，勿用\\----------------------------\\
    //关于文件上传的方法
     //fileURL实例:let fileURL = NSBundle.mainBundle().URLForResource("Default",withExtension: "png")
    func upload(URLString:String,
                fileURL:NSURL,
                delegate:MGNetworkDelegate?,
                block:MGNetworkUploadClosureBlock?,
                successBlock:MGNetworkSuccessBlock?,
                failureBlock:MGNetworkFailureBlock?) {

        
        Alamofire.upload(.POST, URLString, file: fileURL).progress {(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
                block?(nil,nil,bytesWritten ,totalBytesWritten,totalBytesExpectedToWrite)
            }.responseJSON { response in
               
                guard response.result.isSuccess else {
                  failureBlock?(response.result.error!)
                  delegate?.requestdidFailWithError(response.result.error!)
                    return
                }
                
                if let value = response.result.value {
                    let dict = JSON(value)
                    successBlock?(dict)
                    delegate?.requestSuccessFinishLoading(dict)
                }
        }
    }

    
//---------------- //功能待完善，勿用\\----------------------------\\
    //关于文件下载的方法
    //下载到默认路径let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
    let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
    //默认路径可以设置为空,因为有默认路径
    func download(type:MGAsiNetWorkType,
                  URLString:String,
                  delegate:MGNetworkDelegate?,
                  block:MGNetworkUploadClosureBlock?,
                  successBlock:MGNetworkSuccessBlock?,
                  failureBlock:MGNetworkFailureBlock?) {

        switch type {
        case .requestTypeGet:
            Alamofire.download(.GET, URLString, destination: destination)
                .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
                    block?(nil,nil,bytesRead, totalBytesRead, totalBytesExpectedToRead)
                }
                .response { (request, response, _, error) in
                    block?(response,error,nil,nil,nil)
            }
            break
        case .requestTypePost:
            Alamofire.download(.POST, URLString, destination: destination)
                .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
                    block?(nil,nil,bytesRead, totalBytesRead, totalBytesExpectedToRead)
                }
                .response { (request, response, _, error) in
                    block?(response,error,nil,nil,nil)
            }
        default:break
        }
    }
}


