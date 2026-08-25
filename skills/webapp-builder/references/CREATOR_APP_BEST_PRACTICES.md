# Creator App Master Architecture & Logic Guide (Comprehensive Reference)

เอกสารนี้คือ **คลังความรู้เชิงลึกและลอจิกมาตรฐาน (Master Blueprint & Best Practices)** สำหรับการสร้าง Single Page Application (SPA) ด้วย Vanilla JavaScript + Vite + Google Drive Sync + Responsive UI โดยสรุปถอดบทเรียนจากการพัฒนาแบรนด์ Creator Content Planner App ที่ผ่านการปรับแต่งจนได้ประสิทธิภาพสูงสุด

---

## 1. Project Architecture & File Organization
โครงสร้างไฟล์ที่เป็นระเบียบ น้ำหนักเบา ไม่พึ่งพา Framework ใหญ่ (React/Vue/Angular) แต่ได้ความเร็วและง่ายต่อการดูแลรักษา:

```text
my-creator-app/
├── index.html                   # Entry HTML Shell & Layout
├── package.json                 # Project Metadata & Dependencies
├── vite.config.js               # Vite config (bundled singlefile output)
└── src/
    ├── main.js                  # Entry point, Hash-Router, Theme/Lang init
    ├── store.js                 # State Management, Event Emitter, LocalStorage
    ├── i18n.js                  # Pure Single-Language Dictionary (EN / TH)
    ├── google-drive.js          # Serverless Google Drive Smart Sync
    ├── utils.js                 # Helper functions (esc, date format, image resize)
    ├── components/
    │   ├── modal.js             # Reusable Modal, Image Zoom, Teleprompter
    │   ├── toast.js             # Toast Notification system
    │   ├── calendar-grid.js     # Responsive Monthly/Weekly Calendar Component
    │   └── editable-table.js    # Dual-Layout Data Table (PC Table / Mobile Cards)
    └── views/                   # View modules (render functions)
        ├── dashboard.js         # Analytics & Overview charts
        ├── products.js          # Products data view
        ├── content.js           # Main Content Planner view
        ├── calendar.js          # Monthly Calendar view (with Quick Edit)
        ├── channels.js          # Channel Performance Tracker view
        ├── sponsors.js          # Brand Deals & Rate Card view
        ├── brand.js             # Media Kit & Brand Identity view
        └── settings.js          # System Preferences & Dropdown Manager
```

---

## 2. State Management & LocalStorage Persistence (`store.js`)

### 🔑 Key Concepts:
1. **Custom Event Emitter:** เมื่อข้อมูลใน Store เปลี่ยนแปลง ให้ส่งสัญญาณ `emit('change', collectionName)` เพื่อให้ UI รีเฟรชเฉพาะส่วน
2. **Timestamp Tracking:** ทุก Record ต้องมี `createdAt` และ `updatedAt` (ISO String) เพื่อใช้ในการเปรียบเทียบ Conflict ตอนซิงก์ข้อมูล
3. **Tombstone Pattern:** เมื่อผู้ใช้ลบรายการ **อย่าลบวัตถุออกจาก LocalStorage ทันที** ให้บันทึกรหัสลงในรายการ `_deletedIds` (Tombstone) เพื่อใช้แจ้งระบบ Remote Sync ว่ารายการนี้ถูกลบแล้ว ป้องกันข้อมูลเด้งกลับมา

```javascript
// Example Record Structure
{
  id: "CNT-2026-001",
  title: "รีวิวหูฟังบลูทูธไร้สาย",
  status: "🎬 Scripting",
  publishedDate: "2026-08-15",
  createdAt: "2026-08-01T10:00:00.000Z",
  updatedAt: "2026-08-11T20:00:00.000Z",
  _deleted: false
}
```

---

## 3. Serverless Database: Google Drive "Smart Sync" (`google-drive.js`)

ใช้ Google Drive App Data Folder เป็นฐานข้อมูลหลังบ้านฟรี ปลอดภัย ข้อมูลเป็นของผู้ใช้ 100%:

### 🔄 Conflict Resolution Algorithm (Last-Write-Wins):
1. **อ่านไฟล์ Local และ Remote JSON**
2. **เปรียบเทียบ Record By Record ผ่าน `id`:**
   - หากมีรหัสตรงกันทั้ง Local และ Remote ให้เทียบ `updatedAt` -> **Record ที่อัปเดตล่าสุดชนะ**
   - หากมีใน Local แต่ไม่มีใน Remote -> ตรวจสอบว่าเคยลบไหม ถ้าไม่เคยลบให้ส่งขึ้น Remote
   - หากรหัสถูกระบุใน Tombstones (`_deletedIds`) -> ให้ทำการลบออกจากทั้งสองฝั่งอย่างถาวร
3. **บันทึกผลลัพธ์กลับไปยังทั้ง LocalStorage และ Google Drive**

---

## 4. Responsive Dual-Layout UI (PC vs Mobile)

ตารางข้อมูลขนาดใหญ่ (Data Tables) จะพังทันทีเมื่อเปิดบนหน้าจอมือถือ วิธีแก้ปัญหาคือการทำ **Dual-Layout Components**:

### 💻 PC Desktop View (min-width: 768px):
- Render เป็น HTML `<table>` หรือ CSS Grid แบบความหนาแน่นสูง
- มีระบบ **Excel-style Column Filter**, Sorting, และ Search bar

### 📱 Mobile View (max-width: 767px):
- ซ่อน `<table>` แล้ว Render ข้อมูลเป็น **Cards** (`.etable-mobile-card`)
- **Clean UI Principle:** ห้ามใส่ปุ่มลบ/แก้ไขปะปนเกะกะบนหน้าการ์ดข้างนอก
- **Drill-down Concept:** แตะการ์ดเพื่อเปิด **Vertical Detail Modal (Pop-up แนวตั้ง)**
- **Action Buttons in Modal:** ปุ่มลบ (🗑️ ลบรายการนี้) และปุ่มสำคัญ ให้จัดวางเด่นชัดใน Pop-up ด้านบนสุดหรือล่างสุด

---

## 5. Quick Edit Calendar Pop-Up & Teleprompter Integration

### 📅 Calendar View Best Practices:
1. **Single Source of Truth for Dates:** กำหนดให้ปฏิทินอ่านวันที่จาก Field เดียวเท่านั้น (เช่น `publishedDate`) ห้ามอ่านจากทั้ง `plannedDate` และ `publishedDate` พร้อมกัน เพราะจะทำให้การ์ดโผล่ซ้ำ
2. **Quick Edit Form:** Pop-up บนปฏิทินไม่จำเป็นต้องมีทุก Field ให้ใส่เฉพาะ Field สำคัญที่เน้นความเร็ว เช่น ชื่อ, สถานะ, วันที่, ช่องทาง, เสาหลัก, Hook และ Script
3. **Expanded Script Box:** กล่อง `Script & Content Outline` มีเนื้อหาเยอะที่สุด ต้องกำหนดความสูงขั้นต่ำ (`rows="9"`, `min-height: 200px`, `line-height: 1.6`) เพื่อให้อ่านง่าย สบายตา
4. **Teleprompter Button:** มีปุ่ม **`🎬 Teleprompter (อ่านบท)`** สีม่วงเด่นชัดใน Pop-up ดึง Hook + Script มาสร้างเป็นหน้าต่างลอยเลื่อนบทพูดสดหน้ากล้องได้ทันที

---

## 6. Pure Single-Language Dynamic i18n System (`i18n.js`)

### ❌ สิ่งที่ต้องหลีกเลี่ยง (Anti-Pattern):
- ห้ามเขียนข้อความ UI ปน 2 ภาษาด้วยสแลช เช่น `Title / หัวข้อคอนเทนต์` หรือ `Save & Close / บันทึก` เพราะดูไม่เป็นมืออาชีพและรกสายตา

### ✅ วิธีที่ถูกต้อง (Best Practice):
- แยกพจนานุกรมใน `src/i18n.js` ออกเป็นภาษาเดี่ยวบริสุทธิ์ 100%:
  - **`en`**: ภาษาอังกฤษล้วน (เช่น `"Title"`, `"Status"`, `"Save Changes"`, `"Delete Record"`)
  - **`th`**: ภาษาไทยล้วน (เช่น `"ชื่อคอนเทนต์"`, `"สถานะงาน"`, `"บันทึกการแก้ไข"`, `"ลบรายการนี้"`)
- ใช้ฟังก์ชัน helper `t('key')` ในการแสดงผลทุก Element ของ UI
- เมื่อผู้ใช้เปลี่ยนภาษาใน Settings ให้สั่งเปลี่ยนค่า และรีเฟรชหน้าจอ (`window.location.reload()`) เพื่อให้ทั้งแอปเปลี่ยนภาษาทันที

---

## 7. Date Handling & Thai Buddhist Era (พ.ศ.) Conversion

อุปกรณ์มือถือหรือคอมพิวเตอร์ในประเทศไทยมักส่งค่าปีเป็น **พ.ศ. (เช่น 2569)** เมื่อเลือกจาก Date Picker:

### 🛠️ Auto-Conversion Logic:
```javascript
function normalizeToGregorianYear(dateString) {
  if (!dateString) return '';
  const parts = dateString.split('-');
  if (parts.length === 3) {
    let year = parseInt(parts[0], 10);
    if (year > 2400) {
      year -= 543; // แปลง พ.ศ. เป็น ค.ศ.
    }
    return `${year}-${parts[1]}-${parts[2]}`;
  }
  return dateString;
}
```

### 🔒 Strict Deduplication Logic:
ในการดึงข้อมูลมาแสดงบนปฏิทิน ต้องใช้ `Set` หรือ `Map` กรองรหัสซ้ำเสมอ:
```javascript
const seenIds = new Set();
const uniqueItems = monthItems.filter(item => {
  if (seenIds.has(item.id)) return false;
  seenIds.add(item.id);
  return true;
});
```

---

## 8. Git & Multi-Branch Deployment Strategy (UAT -> Main)

สำหรับการพัฒนาแบรนด์ Web App ที่เน้นความปลอดภัย และมีระบบ CI/CD (เช่น Vercel):

1. **พัฒนาและทดสอบบน branch `uat` ก่อนเสมอ:**
   - แก้โค้ด -> อัปเดตเวอร์ชันใน `package.json` และ `src/main.js` (เช่น `v2.2.12`)
   - รัน `npm run build` เพื่อเช็คไวยากรณ์ในเครื่อง local
   - พุชขึ้น `uat`: `git add .` -> `git commit` -> `git push origin uat`
2. **ตรวจสอบบน Vercel UAT Preview:**
   - ส่งลิงก์ UAT ให้ผู้ใช้ลองกดทดสอบจริงบนมือถือและคอมพิวเตอร์
3. **Merge ขึ้น Production เมื่อได้รับการอนุมัติ:**
   - `git checkout main`
   - `git merge uat`
   - `git push origin main`
   - `git checkout uat` (กลับมาสแตนด์บายที่ UAT เหมือนเดิม)
