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
    Send('{' . key . ((state) ? ' ' : '') . state . '}')
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

alignCharacter(){
    reset()
    Send('\')
    Sleep(200)
    Send('a')
    Sleep(200)
    loop 4 {
        Send('w')
        Sleep(200)
    }
    Send('{Enter}')
    Sleep(200)
    Send('{Enter}')
    Sleep(200)
    Send('\')
    Sleep(200)
    walkSend('d', 'down')
    walkSleep(1000)
    walkSend('w', 'down')
    walkSleep(2000)
    walkSend('w', 'up')
    walkSleep(5000)
    walkSend('s', 'down')
    walkSleep(2000)
    upKey()
    walkSleep(2000)
}

runPath(){
    if WinExist('Roblox') {
        WinActivate('Roblox')
        if (alignment) {
            alignCharacter()
        }
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