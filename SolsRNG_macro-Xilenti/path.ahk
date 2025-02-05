#Requires AutoHotkey v2.0
#SingleInstance Force

CONFIG_PATH := A_ScriptDir . '\config.ini'
defaultSetting := 0
VIP := loadVIP()
VIP_WALK_SPEED := 1.25
possibleKeys := ['w', 'a', 's', 'd']

loadVIP(){
    return Integer(IniRead(CONFIG_PATH, 'setting', 'vip', defaultSetting))
}

walkSend(key, state){
    Send('{' . key . ' ' . state . '}')
}

press(key, time){
    walkSend(key, 'down')
    walkSleep(time)
    walkSend(key, 'up')
}

diagonalMovement(key1, key2, time){
    walkSend(key1, 'down')
    walkSend(key2, 'down')
    walkSleep(time)
    walkSend(key1, 'up')
    walkSend(key2, 'up')
}

hold(key, time){
    walkSend(key, 'down')
    Sleep(time)
    walkSend(key, 'up')
}

getWalkSleep(time){
    global VIP_WALK_SPEED
    if (!VIP) {
        time *= VIP_WALK_SPEED
    }
    return time
}

walkSleep(time){
    Sleep(getWalkSleep(time))
}

resetCharacter(){
    Send('{Escape}')
    Sleep(500)
    Send('r')
    Sleep(500)
    Send('{Enter}')
    Sleep(2000)
}
collectItem(){
    loop 4 {
        Send('e')
        Sleep(500)
    }
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
    walkSend('RButton', 'down')
    MouseMove(A_ScreenWidth / 2, (A_ScreenHeight*0.25)+5, 50)
    walkSend('RButton', 'up')
    Sleep(200)
}

alignCamera(){
    resetCharacter()
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
    walkSleep(1000)
    walkSend('w', 'down')
    walkSleep(2250)
    walkSend('w', 'up')
    walkSleep(4000)
    walkSend('s', 'down')
    walkSleep(1500)
    upKey()
    diagonalMovement('w', 'a', 500)
    Sleep(200)
}

goToItem(number){
    ;comment the number of the item
    ;that can be seen in the wiki
    ;https://sol-rng.fandom.com/wiki/Items
    ;comment what you used to create the path (vip/non-vip)
    ;and if tested or not
    if (number == 1){
        ;by xilenti
        ;number 26 on wiki
        ;in vip account
        ;tested with non-vip account
        press('a', 1000)
        press('w', 250)
        collectItem()
    }
}

path(){
    goToItem(1)
    alignCharacter()
}

runPath(){
    if WinExist('Roblox') {
        WinActivate('Roblox')
        alignCharacter()
        loop {
            path()
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