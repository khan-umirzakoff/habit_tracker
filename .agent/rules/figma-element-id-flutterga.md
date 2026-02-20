---
trigger: always_on
---

Figma’dagi elementlar `id`lari bilan Flutter’ga eksport qilayotganda layoutni imkon qadar 1:1 (pixel-perfect) va to‘liq responsive qilib tuz. Keyinchalik funksional qilish va production’ga olib chiqish oson bo‘lishi uchun interaktiv komponentlarni (button, icon button, input, switch, checkbox va h.k.) alohida widgetlar sifatida joylashtir: ularni bitta “yaxlit” SVG ichiga birlashtirib yuborma. Dekorativ/background qismlar SVG bo‘lishi mumkin, lekin klik qilinadigan elementlar har biri mustaqil layer/widget bo‘lsin. Constraints/Auto Layout qoidalariga mos ravishda padding, alignment, safe area, breakpoints va turli ekran o‘lchamlarida moslashuvni ta’minla.