# Geek_SougouIME
搜狗拼音输入法隐私保护增强版  
本人基于搜狗拼音输入法第三方修改版再度暴力修改  
**（原始版本10.3.0.4581，2021年4月29日更新）**  
目标着重于隐私保护  
本版本在第三方修改版的基础上，增加以下修改特性：
* 暴力阻止绝大部分尝试联网的请求，一刀切
* 禁止后台输入字数统计
* 调整右键菜单布局，删除没用的按钮和选项
* 删除使用手写输入提示
* 删除候选词使用搜狗搜索选项
* 禁止记录、生成部分日志文件
* 禁止联网推荐皮肤
* 保留离线词库、皮肤安装功能
* 保留第三方账户登录功能（仅登录，不会上报数据）
* （可选）解除对于SogouExe.exe、SogouSvc.exe的依赖
* 所有修改不加壳不加花，保证安全透明

本版本适用于：  
 - **极度隐私敏感人士**
 - **防火墙联网审计爱好者**
 - **任务管理器查看员**
 - **电脑系统洁癖患者**
 - **~~国产软件~~（伪）爱好者**
 
使用方式  
1.先下载、安装原始第三方修改版  
2.将三个可执行程序分别替换到对应的目录（可能需要WinPE、重新启动）  
2.5(可选)导入SogouUpdate.reg，并删除SogouExe目录下的SogouExe.exe、SogouSvc.exe
   注意：此处假设您的安装路径为D:\Program Files\SogouInput
   如果安装位置与此不一致，需要先修改为您的安装路径，再导入
3.enjoy~

![image](https://user-images.githubusercontent.com/43743875/115141145-61587a80-a06d-11eb-874b-51d307af597d.png)

附 原始修改版下载地址([https://pan.lanzous.com/igwtYop7b1i](https://pan.lanzous.com/igwtYop7b1i))  
附 原始修改版修改记录([原贴](https://www.423down.com/587.html))：  
* 去广告，精简优化，免升级，有效阻止程序相关广告弹窗！
* 纯净无广告，无多余干扰提示，默认无不必要联网程序驻留！
* 默认阻止检测升级请求、下载释放广告程序收集相关信息推送广告行为
* 可选：云计算候选、词库更新及账户配置同步、工具箱和扩展管理器组件
* 删除：所有搜狗广告程序（广告获取模块、搜狐新闻弹窗、勋章推荐弹窗）
* 删除：搜索提示, 网址直达, 修复器, 核心服务, 网络更新, 辅助工具, 崩溃反馈等文件
* 删除：图片表情, 人工语音, 皮肤推荐, 皮肤盒子/flash皮肤等，可在工具箱安装扩展
* 取消：搜索候选, 节日/皮肤推荐/flash皮肤模式, 词条/升级/新勋章/活跃天数等提示
* 安装程序：支持Windows 10 Metro模式，32位和64位系统，支持检测可覆盖安装
