#NoTrayIcon

vInputSelectWindowTitle := "Input Select"
vInputSelectWindowClassName := "WindowsForms10.Window.8.app.0"
vListBoxClassName := "WindowsForms10.ListBox.app.0"
vItemIndex := 19

TimerCallback() {
    try {
        CheckActiveWindow("A")
        CheckActiveWindow(vInputSelectWindowTitle)
    }
    catch Error as e {
    }
}

CheckActiveWindow(title) {
    try {
        activedHandle := WinGetID(title)
        windowClassName := WinGetClass("ahk_id " activedHandle)
        if (windowClassName && InStr(windowClassName, vInputSelectWindowClassName)) {
            listboxHwnd := LB_GetHwnd(activedHandle)
            text := LB_GetItemText(vItemIndex, listboxHwnd)
            if (text == "Zo") {
                LB_RemoveItem(vItemIndex, listboxHwnd)
            }
        }

    } catch Error as e {
    }
}

LB_GetHwnd(parentHwnd) {
    items := WinGetControlsHwnd("ahk_id " parentHwnd)

    for hwnd in items {
        className := WinGetClass("ahk_id " hwnd)
        if (InStr(className, vListBoxClassName)) {
            return hwnd
        }
    }
}

LB_GetItemText(index, hwnd) {
    textLen := SendMessage(0x18A, index, 0, hwnd)
    
    if (textLen > 0) {
        itemText := Buffer(textLen + 1, 0)
        SendMessage(0x189, index, itemText.Ptr, hwnd)

        return StrGet(itemText)
    } else {
        return "Invalid"
    }
}

LB_RemoveItem(index, hwnd) {
    itemCount := SendMessage(0x018B, 0, 0, hwnd)
    if (index >= 0 && index < itemCount) {
        SendMessage(0x0182, index, 0, hwnd)
    }
}

Display(text) {
    local x, y
    MouseGetPos(&x, &y)
    ToolTip(text, x + 10, y + 10)
    Sleep(1000)
    ToolTip
}

SetTimer(TimerCallback, 200)