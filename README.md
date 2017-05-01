> 应用启动统计模块


### Usage
---
1.导入HFAppStatistics.h头文件
2.在应用启动时，调起统计接口。

````
[[HFAppStatistics sharedInstance] setAppID:@"12345678"];
[[HFAppStatistics sharedInstance] recordAppUseCountWithURL:@"https://v.juhe.cn/toutiao/index" navigationController:navigationC]; 

````
