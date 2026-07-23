# Firebase 設定教學

## 步驟一：建立 Firebase 專案

1. 前往 [https://console.firebase.google.com](https://console.firebase.google.com)
2. 登入 Google 帳號
3. 點「新增專案」→ 輸入任意名稱（例如：`共用金管理`）→ 繼續
4. 可關閉 Google Analytics（不影響功能）→「建立專案」

---

## 步驟二：建立 Realtime Database

1. 左側選單點「**建構**」→「**Realtime Database**」
2. 點「**建立資料庫**」
3. 選擇資料庫位置（建議：**asia-southeast1**，距離台灣最近）
4. 安全性規則選「**以測試模式開始**」→「啟用」

---

## 步驟三：取得 Firebase Config

1. 左上角點「齒輪⚙️」→「**專案設定**」
2. 下拉找到「**你的應用程式**」區塊
3. 如果沒有應用程式，點「**Web（</>）**」圖示
4. 輸入任意暱稱 → 點「**註冊應用程式**」
5. 複製 `firebaseConfig` 物件（從 `{` 到 `}` 整段）

```javascript
// 看起來像這樣：
{
  "apiKey": "AIzaSy...",
  "authDomain": "xxx.firebaseapp.com",
  "databaseURL": "https://xxx-default-rtdb.asia-southeast1.firebasedatabase.app",
  "projectId": "xxx",
  "storageBucket": "xxx.appspot.com",
  "messagingSenderId": "12345",
  "appId": "1:12345:web:abcde"
}
```

---

## 步驟四：開啟系統並設定

1. 用瀏覽器打開 `index.html`
2. 貼上上一步複製的 JSON config
3. 輸入房間代碼（自訂，三個人共用同一組代碼）
4. 選擇你的身份（第一次使用會自動建立三位預設成員）

---

## 三人共用步驟

1. 第一人完成設定後，系統自動建立房間
2. 將 `index.html` 檔案傳給另外兩人
3. 另外兩人打開後，貼上**相同的** Firebase Config
4. 輸入**相同的**房間代碼
5. 從列表選擇自己的成員身份

---

## 常見問題

**Q: databaseURL 找不到？**
A: 確認有在 Firebase Console 建立「Realtime Database」，不是 Firestore。URL 格式為 `https://xxx.firebasedatabase.app`

**Q: 資料不同步？**
A: 確認三人使用相同的房間代碼

**Q: 想換名字？**
A: 開啟 → 系統設定 → 成員管理，點名字欄位直接編輯

---

## 安全性說明

目前使用「測試模式」（任何人都可讀寫），適合私人使用。
若需要更高安全性，可在 Firebase Console → Realtime Database → 規則，將規則改為：

```json
{
  "rules": {
    "rooms": {
      "$roomId": {
        ".read": true,
        ".write": true
      }
    }
  }
}
```

這樣只有知道房間代碼的人才能存取（透過 URL 路徑隔離）。
