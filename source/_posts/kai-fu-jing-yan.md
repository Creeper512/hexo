---
title: 开服经验之谈
tags: 开服
abbrlink: 15587
date: 2022-07-03 13:37:26
---

**粗体为重点内容。**

## 最基本的常识
* **不要使用网上的服务器整合包去直接开一个服务器**，因为这样你学不到什么东西
  如果你正准备开一个服务器的话，则可以使用那些整合包来学习一下（我就是这样学习开服的）
* 宣传服务器，**最好是腐竹本人去B站上发视频宣传**，建议标签内包含大量和Minecraft有关的内容，另外视频要包含能突出你服务器特色的内容，还有标题最好是 “我的世界服务器招人” 这种的
  *不怕被举报或者脸皮厚可以加个 “美女” 标签*
* **不建议在服务器没有宣传的情况下就把服务器搞到云服务器上**，建议当玩家积累到一定数量，并且都很活跃时再迁移到云服务器，否则这样是在浪费钱
* 如果你是个新手，**建议参考服务器整合包和MCBBS上的服务器搭建教程去学习如何开服**
* 适当听取玩家意见，**如果有个玩家说能不能给我点东西，请不要惯着他，否则以后他会一直跟你要东西，把你当成ATM**
  **当有玩家提出了一个漏洞时并且你能够修复，请立即去修复**，否则可能会流失玩家
  当有玩家想要一个新功能时，请站在在其他玩家、服务器存档寿命的角度去选择加不加这个功能
* 想要留住玩家，不让他们退坑，请适当增加服务器玩法
* **一定要定期备份服务器**，你永远都不会知道你的玩家下一秒会干什么。我是每天半夜三点服务器自动备份至 OneDrive。
* 当服务器玩家增多时，建议多招些OP，否则你会天天被玩家私聊+艾特
  如果要招OP的话，建议招那些游玩时间长，而且几乎没有熊过其他玩家建筑的人，最好还要会指令
  如果不想招，建议给服务器多加些安全插件，比如圈地、箱子锁、方块记录、反作弊、举报啥的，此外还建议在服务器的群里搞个能自动回答玩家问题的机器人（说实话机器人搭建一点也不难）
* **想留住玩家，就要给服务器增加亿些独有的特色**，B站、MCBBS上没特色的服务器太多了。
* **不要天天给玩家发福利，请适度发福利。**否则玩家会天天跟你要福利。
* **强烈建议生存服开启反矿透。**
* **你应该使用问卷+审核方式招募 OP，而不是一上来就招一大堆 OP。**
* 遇到脑残玩家（例如不让生存服玩家使用原版的 TNT 这种的），建议直接踢了。

## 服务器插件、性能和优化
* **开插件服建议选择 Paper 端或其分支（如 Purpur）**，如果你想开生电服，建议使用 Spigot，追求卓越性能，请使用 Paper 并在配置文件中关闭和红石相关的修改。
* 如果想要开模组服，并且想要加 Spigot 的插件，建议选择 Arclight/CatServer/Mohist。如果你想要模组兼容性最佳并且你技术能力比较好，建议选择 Sponge，但是 Sponge 插件太少，所以说平时开模组服还是用 Forge + Bukkit 端吧。
* 不建议使用你在 java.com 下载的 Java 来开服，**建议使用 AdoptOpenJDK 的 OpenJ9 VM 来开服**，这样可以获得最佳性能，但是 OpenJ9 的兼容性不是很好，有个帖子也说 OpenJ9 降低了近 10% 的 CPU 性能。如果你不考虑服务器的内存占用，建议使用阿里巴巴的龙泉 OpenJDK。
* **开模组服，一定要封禁一些比较逆天、有Bug的东西**，否则就等着玩家把你存档搞崩吧。
* **不管你是开什么服务器，一定要加个方块记录的插件，并且将查询插件开放给玩家**，这样当某名玩家的房子被炸的时候，玩家可以通过记录插件查询谁干的。（我建议用 CoreProtect）
* 有能力的话，建议使用 Linux 来开服，我两个服务器分别在 CentOS、Ubuntu 上开。
* **不要乱加插件**，除非是开源插件，否则你永远也不知道插件里有没有后门
  建议在 MCBBS 上寻找插件，我在 MCBBS 上基本找不到有后门的插件。
  **不要尝试安装付费插件的破解版。** 大概率有后门。
* 建议在加某个功能之前先搞个投票，问问玩家要不要加这个功能
* 不建议直接用`java -Xmx1g -Xmx512m -jar 服务器.jar`直接开服，这样的话没啥优化，建议**适当更改**启动参数来开服。分享一下我两个服务器都在用的启动参数（我用的是 OpenJ9 JVM 开服，其他的 JVM 可能用不了）：
  
```bash
$ "/usr/lib/openj9/bin/java" -Xmx1g -Xms1m -Xss340K -Xconmeter:dynamic -Xshareclasses -XcompilationThreads1 -Xaggressive -Xalwaysclassgc -Xtune:virtualized -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -server -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar "purpur-1.16.5-1171.jar" nogui
```

* 不建议没更改服务器配置就开服，这样的话也没啥优化，建议在 MCBBS 上寻找服务器优化教程（一抓一大把），另外我服务器的视距设置为了 5，模组服是 4。
* 如果你是要开个离线模式的服务器，强烈建议加个登录插件，否则别的玩家轻轻松松就能盗了你的号，如果你要开朋友之间玩的服务器的话，可以选择不加，但会有风险。
* **不建议搞外置登录**，否则会流失玩家。我已经被教训过一次了。
* **不要加太多的插件/模组**，这样会影响服务器性能，服务器内存占用升高。
* **不要搞一堆奇奇怪怪的东西**，例如服务器网页地图、数据总览、服务器论坛啥的，很多玩家都不用这些东西，搞了也是白搞，占用服务器资源。
* **不要以为服务器插件是直接拖进文件夹就完事了。**你还需要更改插件配置，还得汉化，还得加权限...
* 建议离线服务器加个 SkinsRestorer 插件，可以让离线玩家显示皮肤，还可以用指令更改皮肤。
* 除非你是小游戏服务器，否则不建议搞计分板。这样可能会遮挡玩家的视线，如果玩家想看自己的信息用菜单不就行了。
* 建议把服务器的 TAB、MOTD 美化好，就像这样：
![l558dyks.png](https://blog.groupserver.xyz/usr/uploads/2022/07/2697419277.png)
![l558ew0t.png](https://blog.groupserver.xyz/usr/uploads/2022/07/4176920554.png)

* 不建议生存服务器安装反作弊插件。
* 选择一个合适的服务器域名、还有服务器名字、Logo能给玩家留下一个好的印象。
* **不要一时贪图便宜，买了个上行宽带小、境外的服务器**。否则延迟飙升，卡的要死。
* 如果你的服务器性能不好，建议不要让玩家频繁跑图。

## 服务器安全
* **如果你买的是云服务器，强烈建议加固服务器。**否则你服务器被黑了就无了。
* 建议使用 Cloudflare 的 SRV 解析隐藏服务器源IP（需要有域名，也不贵，某逊云 xyz 域名首年 8 元），虽然隐藏后用一些技术手段也能查出来，但也总比没隐藏强。
* 想把服务器做大，就要从服务器购买时就隐藏服务器源IP，别让人知道。大服务器很容易受到攻击。
* 1.19 以上的服务器建议加个防止玩家聊天信息被举报的插件。
* 对于小游戏服务器，必须要加个反作弊插件。
* 最好加个防压测的插件，例如 AntiAttackRL。
* 一定要管好你服务器的 OP。
* 如果你买的是面板服务器，建议在服务器人数多了的时候迁移到云服务器，云服务器的可玩性更高。

## 服务器玩家 & 存档寿命
* **不要随便给玩家东西**。他们会在尝到甜头之后会天天跟你要东西。
* **不要搞服务器最强装备什么的。**别问我为什么，我已经被教训过一次了（X2）。
* 如果你想搞个使用服务器货币回收、购买物品的话，建议把价格提高点，否则直接货币泛滥。
* 如果你遇到一个很暴躁的玩家，动不动就退服，然后又回来，建议不要让它回来，也不要把它拉回来，否则你这不仅没有保住服务器玩家，还会祸害别的玩家。
* **服务器腐竹不应该带头开挂，否则会流失玩家。**

## 开服常用资源及网站
* [MCBBS 插件版](https://www.mcbbs.net/forum.php?mod=forumdisplay&fid=138&filter=sortid&sortid=7)、[SpigotMC](https://spigotmc.org) - 找插件专用
* [鬼斩的构建站](https://builds.guizhanss.net/) - 找汉化了的粘液科技附属专用