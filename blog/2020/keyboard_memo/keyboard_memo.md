@def title = "xで内蔵キーボードを無効にするメモ"
@def tags = ["x11", "i3wm"]

Xで内蔵キーボードを無効にする
=============================

まず,
```
> xinput list
⎡ Virtual core pointer                          id=2    [master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer                id=4    [slave  pointer  (2)]
⎜   ↳ Synaptics TM3336-001                      id=11   [slave  pointer  (2)]
⎣ Virtual core keyboard                         id=3    [master keyboard (2)]
    ↳ Virtual core XTEST keyboard               id=5    [slave  keyboard (3)]
    ↳ Power Button                              id=7    [slave  keyboard (3)]
    ↳ EasyCamera: EasyCamera                    id=10   [slave  keyboard (3)]
    ↳ Ideapad extra buttons                     id=12   [slave  keyboard (3)]
    ↳ Video Bus                                 id=6    [slave  keyboard (3)]
    ↳ HHKB-BT Keyboard                          id=8    [slave  keyboard (3)]
    ↳ HHKB-BT System Control                    id=9    [slave  keyboard (3)]
    ↳ AT Translated Set 2 keyboard              id=13   [slave  keyboard (3)]

```
で内蔵キーボードのIDを調べて(自分の場合は"AT Translated Set 2 keyboard"なのでid=13)
```
> xinput disable 13
```
で無効にできる｡これでノートPCの上にHHKBを置いて使える｡
