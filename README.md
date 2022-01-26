# EssentialMode Simple

## Simple? What does it mean?
Deleted all sqllite and CrouchDB functions.Combined esplugin_mysql. 

## Dependencies
- mysql-async  

## 原理
- 玩家進入遊戲時觸發client\main.lua內的es:firstJoinProper通知服務端檢測DB，建立玩家數據或允許登入，建立玩家的服務端基本參數暫存。
旁邊的es:allowedToSpawn用於其他客戶端插件檢測es在客戶端開始運作  
由server\main.lua得知玩家離線儲存玩家數據，得出玩家連接檢測是否有具備識別號，若沒有禁止進入服務器。通知客戶端玩家首次出生了，以及記錄坐標接口。

## Orginal essentialmode readme.md

- https://github.com/kanersps/essentialmode