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
        currentActiveHandle := WinGetID(title)
        windowClassName := WinGetClass("ahk_id " currentActiveHandle)
        if (windowClassName && InStr(windowClassName, vInputSelectWindowClassName)) {
            listboxHwnd := GetListboxHandle(currentActiveHandle)
            RemoveListBoxItem(listboxHwnd, vItemIndex)
        }

    } catch Error as e {
    }
}

GetListboxHandle(parentHwnd) {
    items := WinGetControlsHwnd("ahk_id " parentHwnd)

    for hwnd in items {
        className := WinGetClass("ahk_id " hwnd)
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

Display(text) {
    local x, y
    MouseGetPos(&x, &y)
    ToolTip(text, x + 10, y + 10)
    Sleep(1000)
    ToolTip
}

SetTimer(TimerCallback, 200)