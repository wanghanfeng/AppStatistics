> 应用启动统计模块

### Description
---
1.记录用户使用应用的次数N

2.当用户使用次数N超过提示次数M时，弹框提示用户“感谢您的使用，欢迎您对我们的产品进行评价”，用户可以选择“是”或“否”

    a)是：执行指令C

    b)否：提示框消失，本版本不在提示

3.值N每次安装新版本后消失，本版本不在提示

4.M值，提示语“感谢您的使用，欢迎您对我们的产品进行评价”，C可下发，返回数据格式为JSON.

    a)该功能可手动调起

5.C支持一下几种指令，在主线程中执行

    a)进入App Store评价该产品

    b)打开某个URL，webView加载

    c)清除本地数据信息

6.提示框可以手动调起，也可网络请求

7.数据信息变动及动作控制台会输出LOG

### Usage
---
1.导入HFAppStatistics.h头文件

2.在应用启动时，调起统计接口。

````
[[HFAppStatistics sharedInstance] setAppID:@"12345678"];
[[HFAppStatistics sharedInstance] recordAppUseCountWithURL:@"https://v.juhe.cn/toutiao/index" navigationController:navigationC]; 

````

### Welcome
--- 
欢迎联系我共同维护此框架
