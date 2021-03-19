dopi 简介
=========
dopi linux开发框架计划，致力于实现一套基于Linux的嵌入式开发集成接口   

  

源码获取  
--------
    git clone https://github.com/cijliu/dopi.git  
    cd dopi


## 构建系统  

**编译前需要确认已经安装了芯片的工具链，例如，海思HI3516EV200平台，需要安装arm-himix100-linux工具链，输入指令查询是否安装。**  

    arm-himix100-linux-gcc -v



* 配置芯片平台  

        make menuconfig    

* 编译系统包  

  * 一键构建uboot、linux、rootfs  

         make bsp  

  * 单独编译uboot  

         make bsp-uboot  

  * 单独编译linux  

         make bsp-linux  

  * 单独打包rootfs  

         make bsp-rootfs  

  **最终输出固件包所在路径：bsp/images**
  
* 编译芯片厂商相关库  

         make vendor  
         
  **这里以海思MPP为例进行整合，最终输出相关文件所在路径：vendor/output**
  
## 构建应用  

**这里使用RTSP作为示例进行演示。** 
* 配置应用  

        make menuconfig    
    
* 编译应用  

        make app    
    

  **最终输出应用所在路径：app/build**  
  **这里因为使用RTSP作为测试，会把测试文件test.h264也放在build目录下，把这两个文件通过FTP传到开发板上**  
* 赋予应用执行权限  

        chmod +x demo    
* 运行应用  

        ./demo    

* 客户端测试 

        rtsp地址：rtsp://192.168.137.25:8554/live    
        
   **这里使用VLC软件，开发板的IP为192.168.137.25的环境下进行测试，最终VLC将循环播放H264文件内容**  

计划  
-----
- [x] 系统构建  
- [ ] 多媒体框架  
- [ ] 应用框架  
