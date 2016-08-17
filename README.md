# MGNetworing
/**

github网址： https://github.com/gdhGaoFei/MGNetworing
多多指教，谢谢！
*/

/** 初次学习Swift语言，好多地方都需要改进，请各位大牛指点。QQ：1043902770 谢谢！
* 本人参考了OC中我比较喜欢常用的一种二次开发网络封装：超强 AFN 封装，它包含了Block及delegate和action三种方法进行网络请求。按照它的思想进行了封装此网络请求
* 使用的网络请求的方法是参考另一个swift版本的 “Swift 请求类,一般请求就用它” 网络请求，一些必要的方法是按照此网络请求的方法进行做的。
* 再次感谢所用的人员贡献。非常感谢！
*/

/**
* 在这里强调一下使用此 网络请求的二次开发需要导入的第三方库：
* Alamofire、MBProgressHUD、SVProgressHUD、SwiftyJSON
*初次学习swift还有好多地方不太明白，还需要继续的努力。请各位多多指点，共同学习，共同进步。
*/

/**
* 目前本人的工作完成的情况：GET及POST请求使用 block和Delegate已经完成，能够正常使用。文件上传和文件下载没有亲测，请慎用。
* 代理的方法并不是我想要的，如何将代理中的方法弄成可选性的，暂时还在继续学习。所以能使用block请使用block，勿用delegate。
*本人希望得到大神的指点，谢谢！
*/


//本人使用 cocoapods 进行导入第三方库的，如下,直接写入就OK啦。

//---------

#s line to define a global platform for your project
platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

target 'MGNetworking' do

pod 'Alamofire'
pod 'SVProgressHUD'
pod 'SwiftyJSON'
pod 'MBProgressHUD'

end

----------//

/**
* 还需要完善的功能：网络动态的检测、上传文件及下载文件、移除单个的网络请求及移除所有的网络请求。
* 网络请求的缓存...等等方面吧。还在学习中...
*/



