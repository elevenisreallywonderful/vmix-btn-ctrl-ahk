vInputSelectWindowClassName := "WindowsForms10.Window.8.app.0.141b42a_r8_ad1"
vListBoxClassName := "WindowsForms10.ListBox.app.0.141b42a_r8_ad1"
vItemIndex := 19

CheckActiveWindow() {
    try {
        hwnd := WinGetID("ahk_class " vInputSelectWindowClassName)
        if (hwnd) {
            listboxHwnd := GetListboxHandle(hwnd)
            RemoveListBoxItem(listboxHwnd, vItemIndex)
        }
    } catch Error as e {
    }
}

GetListboxHandle(parentHwnd) {
    items := WinGetControlsHwnd("ahk_id " parentHwnd)
    for hwnd in items {
        className := WinGetClass("ahk_id " hwnd)
        text := WinGetTitle("ahk_id " hwnd)
        if (InStr(className, vListBoxClassName)) {
            return hwnd
        }
    }
}

RemoveListBoxItem(listboxHwnd, index) {
    itemCount := SendMessage(0x018B, 0, 0, listboxHwnd)
    if (index >= 0 && index < itemCount) {
        SendMessage(0x0182, index, 0, listboxHwnd)
    }
}

SetTimer(CheckActiveWindow, 200)