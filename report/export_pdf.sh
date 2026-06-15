#!/usr/bin/env bash
# Export module2_report.md → module2_report.pdf
#
# One-time installs on macOS (run only the ones you do not already have):
#   brew install pandoc node
#   npm install -g @mermaid-js/mermaid-cli
#   # Pick ONE PDF engine (script auto-detects, in this preference order):
#   brew install --cask wkhtmltopdf       # easiest, deprecated but still works
#   # or
#   brew install weasyprint               # nice typography, requires Python
#   # or
#   brew install --cask basictex          # for pandoc --pdf-engine=xelatex
#
# Usage:
#   cd "/Users/liutongtong/Desktop/DST2 ICA/report"
#   bash export_pdf.sh
#
# Output:
#   module2_report.pdf  (Mermaid block is auto-rendered to figures/fig01_architecture.png)

set -euo pipefail
cd "$(dirname "$0")"

SRC="module2_report.md"
OUT="module2_report.pdf"
TMP_MD=".module2_report.tmp.md"
TMP_HTML=".module2_report.tmp.html"
CSS="report.css"
FIG_DIR="figures"

mkdir -p "$FIG_DIR"

# ------ tool checks ------
have() { command -v "$1" >/dev/null 2>&1; }
need() { have "$1" || { echo "❌ Missing $1. Install with: $2"; exit 1; }; }

need pandoc "brew install pandoc"
need mmdc   "brew install node && npm install -g @mermaid-js/mermaid-cli"

PDF_ENGINE=""
if   have wkhtmltopdf; then PDF_ENGINE="wkhtmltopdf"
elif have weasyprint;  then PDF_ENGINE="weasyprint"
elif have xelatex;     then PDF_ENGINE="xelatex"
else
  cat <<'MSG'
❌ No PDF engine found. Install ONE of (preferred order):
   brew install --cask wkhtmltopdf
   brew install weasyprint
   brew install --cask basictex      # then: eval "$(/usr/libexec/path_helper)" && sudo tlmgr update --self
MSG
  exit 1
fi
echo "ℹ️  Using PDF engine: $PDF_ENGINE"

# ------ render Mermaid blocks → PNG, rewrite markdown ------
python3 - "$SRC" "$TMP_MD" "$FIG_DIR" <<'PY'
import pathlib, re, subprocess, sys
src_path, tmp_path, fig_dir = map(pathlib.Path, sys.argv[1:4])
fig_dir.mkdir(exist_ok=True)
text = src_path.read_text()
pattern = re.compile(r"^```mermaid\n(.*?)\n```", re.M | re.S)

# Always emit fig01_architecture.png for the first Mermaid block; numbered after.
def out_name(idx):
    return fig_dir / ("fig01_architecture.png" if idx == 1 else f"fig01_mermaid_{idx}.png")

cursor, idx, parts = 0, 0, []
for m in pattern.finditer(text):
    idx += 1
    parts.append(text[cursor:m.start()])
    src_mmd = fig_dir / f"._mermaid_{idx}.mmd"
    src_mmd.write_text(m.group(1))
    out_png = out_name(idx)
    subprocess.run(
        ["mmdc", "-i", str(src_mmd), "-o", str(out_png),
         "-w", "1800", "-b", "white", "-t", "default"],
        check=True,
    )
    src_mmd.unlink(missing_ok=True)
    parts.append(f"![Mermaid block {idx}]({out_png.as_posix()})\n")
    cursor = m.end()
parts.append(text[cursor:])
tmp_path.write_text("".join(parts))
print(f"ℹ️  Mermaid blocks rendered: {idx}")
PY

# ------ CSS (used by wkhtmltopdf / weasyprint HTML pipeline) ------
cat > "$CSS" <<'CSS'
@page { size: A4; margin: 22mm 20mm; }
body {
  font-family: "Times New Roman", "Songti SC", serif;
  font-size: 11pt; line-height: 1.5; color: #1a1a1a;
}
h1 { font-size: 1.7rem; margin-top: 0; }
h2 { font-size: 1.3rem; border-bottom: 1px solid #ddd; padding-bottom: .2rem; margin-top: 1.4rem; }
h3 { font-size: 1.05rem; margin-top: 1.1rem; }
h1, h2, h3, h4 {
  font-family: -apple-system, "Helvetica Neue", "PingFang SC", sans-serif;
  color: #111; line-height: 1.25;
}
p { margin: .35rem 0 .6rem; }
strong { color: #111; }
table { border-collapse: collapse; width: 100%; margin: .4rem 0 1rem; font-size: 95%; }
th, td { border: 1px solid #c8c8c8; padding: .3rem .55rem; vertical-align: top; }
th { background: #f1f1f1; }
code {
  font-family: Menlo, Consolas, "Liberation Mono", monospace;
  font-size: 92%; background: #f3f3f3; padding: 0 .25em; border-radius: 3px;
}
pre { background: #f6f8fa; padding: .65rem .9rem; border-radius: 6px; overflow-x: auto; }
pre code { background: transparent; padding: 0; }
img { max-width: 100%; display: block; margin: .4rem auto; }
em, i { color: #333; }
blockquote { border-left: 3px solid #ccc; color: #555; padding: 0 .9rem; }
hr { border: none; border-top: 1px solid #ddd; margin: 1.2rem 0; }
CSS

# ------ build the PDF ------
case "$PDF_ENGINE" in
  wkhtmltopdf)
    pandoc "$TMP_MD" \
      -f markdown+pipe_tables+yaml_metadata_block+fenced_code_blocks \
      -t html5 \
      --standalone \
      --css "$CSS" \
      --highlight-style=tango \
      -o "$TMP_HTML"
    wkhtmltopdf \
      --enable-local-file-access \
      --encoding UTF-8 \
      --print-media-type \
      "$TMP_HTML" "$OUT"
    ;;
  weasyprint)
    pandoc "$TMP_MD" \
      -f markdown+pipe_tables+yaml_metadata_block+fenced_code_blocks \
      -t html5 \
      --standalone \
      --css "$CSS" \
      --highlight-style=tango \
      -o "$TMP_HTML"
    weasyprint "$TMP_HTML" "$OUT"
    ;;
  xelatex)
    pandoc "$TMP_MD" \
      -f markdown+pipe_tables+yaml_metadata_block+fenced_code_blocks \
      --pdf-engine=xelatex \
      -V geometry:margin=22mm \
      -V mainfont="Times New Roman" \
      -V CJKmainfont="PingFang SC" \
      -V monofont="Menlo" \
      --highlight-style=tango \
      -o "$OUT"
    ;;
esac

rm -f "$TMP_MD" "$TMP_HTML"
echo "✅ Generated: $(pwd)/$OUT"
