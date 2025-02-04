#Requires AutoHotkey v2.0
#SingleInstance Force

CONFIG_PATH := A_ScriptDir . '\config.ini'
defaultSetting := 0
VIP := loadVIP()
VIP_WALK_SPEED := 1.25
possibleKeys := ['w', 'a', 's', 'd']
alignment := Integer(A_Args[1])

loadVIP(){
    return Integer(IniRead(CONFIG_PATH, 'setting', 'vip', defaultSetting))
}

walkSend(key, state){
    Send('{' . key . ' ' . state . '}')
}

hold(key, time){
    Send('{' . key . ' down}')
    Sleep(time)
    Send('{' . key . ' up}')
}

getWalkSleep(time){
    global VIP_WALK_SPEED
    if (VIP) {
        time *= VIP_WALK_SPEED
    }
    return time
}

walkSleep(time){
    Sleep(getWalkSleep(time))
}

reset(){
    Send('{Escape}')
    Sleep(500)
    Send('r')
    Sleep(500)
    Send('{Enter}')
    Sleep(2000)
}

fixZoom(){
    hold('i', 2000)
    hold('o', 750)
    Sleep(200)
}


fixCameraAngle(){
    CoordMode('Mouse', 'Client')
    SendMode('Event')
    MouseMove(A_ScreenWidth / 2, A_ScreenHeight * 0.25, 5)
    Send('{RButton down}')
    MouseMove(A_ScreenWidth / 2, (A_ScreenHeight*0.25)+5, 50)
    Send('{RButton up}')
    Sleep(200)
}

alignCamera(){
    reset()
    Send('\')
    Sleep(200)
    loop 4 {
        Send('a')
        Sleep(200)
    }
    loop 3 {
        Send('w')
        Sleep(200)
    }
    Send('{Enter}')
    Sleep(200)
    Send('{Enter}')
    Sleep(200)
    Send('\')
    Sleep(200)
    fixZoom()
    fixCameraAngle()
}

alignCharacter(){
    alignCamera()
    walkSend('d', 'down')
    walkSend('w', 'down')
    walkSleep(1750)
    walkSend('w', 'up')
    walkSleep(5000)
    walkSend('s', 'down')
    walkSleep(2000)
    upKey()
    walkSend('w', 'down')
    walkSend('a', 'down')
    walkSleep(500)
    upKey()
    Sleep(200)
}

runPath(){
    if WinExist('Roblox') {
        WinActivate('Roblox')
        if (alignment) {
            alignCharacter()
        }
        MsgBox('Path unavailable')
        loop {
            ;insert path here
        } 
    } else {
        MsgBox('Roblox not found')
        ExitApp()    
    }
}

upKey(){
    for key in possibleKeys {
        walkSend(key, 'up')
    }
}

runPath()

F2::{
    upKey()
    ExitApp()
}

F3::{
    upKey()
    ExitApp()
}