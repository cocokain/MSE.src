らくらくコード化ツールPython

import pyperclip
offset = input("どこからの記述かを入力(offset): 0x")
reg = input("使用するレジスタを記入(0-F):")
print("クリップボードにhexソースをコピーしたらエンター")
input()
code = ""
lines = pyperclip.paste().split('\n')
for i in range(len(lines)):
    code = f'{code}\n040{reg}0000 {hex(int(offset.lstrip("0"),16) + 4*i)[2:].zfill(8)} {lines[i]}'

pyperclip.copy(code)
