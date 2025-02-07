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

press(key, time := 50){
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

playerJump(){
    press('Space')
}

walkJump(key, time){
    walkSend(key, 'down')
    walkSleep(time)
    playerJump()
    walkSleep(350)
    walkSend(key, 'up')
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
    press('d', 1000)
    diagonalMovement('d', 'w', 2250)
    press('d', 4000)
    diagonalMovement('d', 's', 1500)
    diagonalMovement('w', 'a', 500)
    Sleep(200)
}

goToItem(number){
    ;comment the number of the item
    ;that can be seen in the wiki
    ;https://sol-rng.fandom.com/wiki/Items
    ;comment what you used to create the path (vip/non-vip)
    ;and if tested or not
    if (number = 1){
        ;number 26 on wiki
        press('a', 1150)
        press('w', 250)
    } else if (number = 2){
        ;not on wiki
        press('w', 1250)
        diagonalMovement('w', 'd', 1500)
        walkJump('d', 1450)
    } else if (number = 3){
        ;number 25 on wiki
        press('d', 700)
        walkJump('w', 650)
        press('w', 1150)
    } else if (number = 4){
        ;number 22 on wiki
        walkJump('s', 2250)
        press('s', 2500)
        press('d', 1350)
        press('s', 1000)
    } else if (number= 5){
        ;number 13 on wiki
        press('w', 1000)
        walkJump('a', 250)
        press('a', 1250)
        walkJump('s', 250)
        press('s', 2250)
    }
    collectItem()
}

pathBranch(number){
    if (number = 1){
        ;path branch made by xilenti
        ;all made in vip account
        ;and all tested in non-vip account
        goToItem(1)
        goToItem(2)
        goToItem(3)
        goToItem(4)
        goToItem(5)
    }
    resetCharacter()
    alignCharacter()
}

path(){
    pathBranch(1)
}

runPath(){
    if WinExist('Roblox') {
        WinActivate('Roblox')
        alignCamera()
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