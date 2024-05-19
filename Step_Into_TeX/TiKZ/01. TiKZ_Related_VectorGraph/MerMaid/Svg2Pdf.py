from svglib.svglib import svg2rlg
from reportlab.graphics import renderPDF


drawing = svg2rlg("mindmapExportTest.svg")
renderPDF.drawToFile(drawing, "mindmapExportTest.pdf")