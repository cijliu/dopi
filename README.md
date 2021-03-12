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

计划  
-----
- [x] 系统构建  
- [ ] 多媒体框架  
- [ ] 应用框架  
