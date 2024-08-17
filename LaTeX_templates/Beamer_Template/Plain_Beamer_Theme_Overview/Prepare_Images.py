# -*- coding: utf-8 -*-
"""
@author: Uwe Ziegenhagen
"""
import os
import glob


# All files and directories ending with .txt and that don't begin with a dot:
files = glob.glob('./Presentation*.tex')

for file in files:
    print(file)    
    os.system(f'lualatex -interaction=batchmode {file}')
    os.system(f'lualatex -interaction=batchmode {file}')

# Remove files that are not required
files_to_delete = ['log', 'toc', 'aux', 'nav', 'snm', 'out']

for filetype in files_to_delete:
    filelist = glob.glob(f'*.{filetype}')
    for f in filelist:
        os.remove(f)


#Conversion (Ghostscript must be installed and in PATH) 
pdfs = glob.glob('*.pdf')

for pdf in pdfs:
    print(pdf)
    basename = pdf[:-4]
    os.system(f'magick {pdf} Pics/{basename}.png')


pdfs = glob.glob('*.pdf')

with open('OVERVIEW.md','w') as output:
    for pdf in pdfs:
        theme = pdf[13:-4]
        basename = pdf[:-4]
        output.write(f'# {theme}\r\n\r\n')
        for i in range(8):
            output.write(f'![{basename}-{i}](Pics/{basename}-{i}.png)')
        output.write('\r\n')

