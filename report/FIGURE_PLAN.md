# Figure plan for Module 2 reflective report

Take these screenshots **in this order** and save them under `report/figures/` with the
file names listed below. The report `module2_report.md` already references them as
`figures/figXX_*.png`. **Total: 7 figures** (Figure 1 is a Mermaid diagram embedded in
the markdown — no screenshot needed).

For every image, crop tightly and try to keep the system clock / personal info out of
the frame.

---

## Figure 1 — System architecture and request flow for Module 2

- **Type:** vector diagram (Mermaid, already in the report)
- **Source:** embedded Mermaid block in `module2_report.md` (no screenshot needed)
- **What it shows:** browser → `Module2SearchServlet` / `Module2DetailServlet` →
  `DrugGeneSearchDao` (`DBUtils.execSQL`) → MySQL (`drug` / `gene` / `drug_gene`),
  with the downstream `Module3RiskPreviewServlet` consuming the same DTO.

If your final submission format does not render Mermaid (e.g. Word/PDF), open the
report in Cursor's Markdown preview, screenshot the diagram only, and replace the
Mermaid block with `![Figure 1 …](figures/fig01_architecture.png)`.

---

## Figure 2 — Drug–gene schema (relational structure)

- **Where:** MySQL Workbench
- **Steps:**
  1. Open your local connection → expand `biomed` schema.
  2. Right-click `biomed` → **Reverse Engineer** → keep defaults → finish.
     This produces an EER diagram.
  3. Drag `drug`, `gene`, `drug_gene` onto the canvas. (You can ignore `annovar`,
     `sample`, `drug_label`, `dosing_guideline` for clarity.)
  4. **File → Export → Export as PNG…** save as
     `report/figures/fig02_schema.png`.
- **If Reverse Engineer is unavailable:** run the SQL below in a query tab and screenshot
  the results grid (less elegant but still acceptable):
  ```sql
  USE biomed;
  SHOW CREATE TABLE drug;
  SHOW CREATE TABLE gene;
  SHOW CREATE TABLE drug_gene;
  ```
- **Save as:** `figures/fig02_schema.png`

---

## Figure 3 — Fuzzy search with case-insensitive keyword highlighting

- **Where:** browser (Tomcat must be running)
- **Steps:**
  1. Open `http://localhost:8080/haining_biomed/module2/search?keyword=CYP2C9&page=1`.
  2. Wait until the table renders with `<mark>` highlights (yellow background) on the
     `Gene (highlight)` column.
  3. Take a clean screenshot of the whole content area including the search box, the
     "N row(s). Page 1 of M" line, and the first ~6–8 result rows. Keep the URL bar
     visible.
- **Save as:** `figures/fig03_search_highlight.png`

---

## Figure 4 — Server-side pagination (page 2)

- **Where:** browser
- **Steps:**
  1. Open `http://localhost:8080/haining_biomed/module2/search?keyword=&page=2`
     (empty keyword lists every association; ensure your seed produced >10 rows).
  2. Verify "Page 2 of M" appears at the top and `2` is highlighted at the bottom.
  3. Screenshot the content area + pagination control + URL bar.
- **Save as:** `figures/fig04_pagination_page2.png`

---

## Figure 5 — Detail view (Association summary)

- **Where:** browser
- **Steps:**
  1. From the search list (Figure 3 or 4) click any **Detail** button (e.g. the
     warfarin–CYP2C9 row).
  2. The URL should be of the form
     `…/module2/detail?drugId=PA449906&geneId=CYP2C9&keyword=CYP2C9`.
  3. Screenshot the page so all three sections (Drug, Gene, Association summary) are
     visible. The keyword from the previous page should still be highlighted.
- **Save as:** `figures/fig05_detail.png`

---

## Figure 6 — Downstream consumption by Module 3 (risk preview)

- **Where:** browser
- **Steps:**
  1. On the detail page (Figure 5), click **Open risk assessment preview**.
  2. The URL becomes `…/module3/preview?drugId=…&geneId=…` and a 5-row table renders.
     This proves that another module can fetch the same DTO through a stable URL/key.
  3. Screenshot the full preview page including the URL bar.
- **Save as:** `figures/fig06_module3_preview.png`

---

## Figure 7 — Automated DAO checks (JUnit 4 green)

- **Where:** IntelliJ IDEA
- **Steps:**
  1. In the Project tree open
     `haining_biomed/src/test/java/cn/edu/zju/dao/DrugGeneSearchDaoTest.java`.
  2. Right-click the class name → **Run 'DrugGeneSearchDaoTest'**.
  3. When the four tests pass, screenshot the **Run** panel so it shows the green
     "✓ 4 tests passed" header (you already produced one earlier; keep that, but if
     possible expand the tree so individual test names are visible).
- **Save as:** `figures/fig07_junit.png`

---

## Optional sanity figures (not required for the report; keep locally if you have time)

- IDEA editor view of `DrugGeneSearchDao.searchByKeyword(...)`.
- Workbench `SELECT COUNT(*)` showing the populated tables.

Both are nice to have but are not referenced in the report text below.
