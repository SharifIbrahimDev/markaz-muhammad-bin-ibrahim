import sys
import os

try:
    import pypdf
    reader = pypdf.PdfReader(r"kutub_markaz\pdf_editions\5_umdat_al_muwahhid.pdf")
    print(f"Total pages: {len(reader.pages)}")
    for i, page in enumerate(reader.pages):
        text = page.extract_text() or ""
        # Search for headings
        for line in text.splitlines():
            line_s = line.strip()
            if "بَابُ" in line_s or "كِتَابُ" in line_s or "المُقَدِّمَةُ" in line_s or "الخَاتِمَةُ" in line_s or "ثَبَتُ" in line_s or "فِهْرِسُ" in line_s:
                if len(line_s) < 100:
                    print(f"Page {i+1}: {line_s}")
except Exception as e:
    print(f"pypdf error: {e}")
    try:
        import fitz # PyMuPDF
        doc = fitz.open(r"kutub_markaz\pdf_editions\5_umdat_al_muwahhid.pdf")
        print(f"Total pages via PyMuPDF: {len(doc)}")
        for i, page in enumerate(doc):
            text = page.get_text()
            for line in text.splitlines():
                line_s = line.strip()
                if "بَابُ" in line_s or "كِتَابُ" in line_s or "المُقَدِّمَةُ" in line_s or "الخَاتِمَةُ" in line_s or "ثَبَتُ" in line_s or "فِهْرِسُ" in line_s:
                    if len(line_s) < 100:
                        print(f"Page {i+1}: {line_s}")
    except Exception as e2:
        print(f"fitz error: {e2}")
