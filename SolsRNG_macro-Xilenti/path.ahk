#Requires AutoHotkey v2.0
#SingleInstance Force

CONFIG_PATH := A_ScriptDir . '\config.ini'
settingVIP := Integer(IniRead(CONFIG_PATH, 'setting', 'vip'))
VIP_WALK_SPEED := 1.25
possibleKeys := ['w', 'a', 's', 'd', 'i', 'o']
cameraSensitivity := Float(IniRead(CONFIG_PATH, 'setting', 'camera_sensitivity'))

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
    if (!settingVIP) {
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
    Send('e')
    Sleep(200)
}

playerJump(){
    press('Space', 50)
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
    MouseMove(A_ScreenWidth / 2, (A_ScreenHeight*0.25)+(5/(cameraSensitivity/4)), 100*(cameraSensitivity/4))
    walkSend('RButton', 'up')
    Sleep(200)
}

alignCamera(){
    resetCharacter()
    Send('\')
    Sleep(200)
    loop 4 {
        Send('{Left}')
        Sleep(200)
    }
    loop 3 {
        Send('{Up}')
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

alignCharacter(index){
    if (index = 1){
        diagonalMovement('d', 'w', 2250)
        press('d', 5000)
        diagonalMovement('d', 's', 1500)
        diagonalMovement('a', 'w', 250)
    } else if (index = 2){
        diagonalMovement('a', 'w', 2500)
        press('a', 3500)
        diagonalMovement('a', 'w', 2500)
        diagonalMovement('d', 's', 250)
    } else if (index = 3){
        diagonalMovement('s', 'a', 3000)
        press('s', 3500)
        diagonalMovement('s', 'd', 1500)
        diagonalMovement('a', 'w', 350)
    } else if (index = 4){
        walkJump('s', 0)
        press('s', 6500)
        press('a', 1650)
        press('s', 2850)
        press('d', 500)
        press('s', 1000)
        diagonalMovement('s', 'a', 2500)
        diagonalMovement('w', 'd', 100)
    }
    Sleep(200)
}

goToItem(index){
    if (index = 1){
        ;number 26 on wiki
        press('a', 1350)
        press('w', 350)
    } else if (index = 2){
        ;number 13 on wiki
        press('w', 1000)
        diagonalMovement('d', 'w', 1750)
        walkJump('d', 1250)
    } else if (index = 3){
        ;number 25 on wiki
        press('d', 750)
        walkJump('w', 650)
        press('w', 1150)
    } else if (index = 4){
        ;number 22 on wiki
        walkJump('s', 2000)
        press('s', 2500)
        press('d', 1350)
        press('s', 1000)
    } else if (index = 5){
        ;number 13 on wiki
        press('w', 1000)
        walkJump('a', 250)
        press('a', 1250)
        walkJump('s', 250)
        press('s', 2250)
    } else if (index = 6){
        ;number 21 on wiki
        press('d', 750)
        press('w', 1850)
    } else if (index = 7){
        ;number 15 on wiki
        press('d', 2000)
        walkJump('w', 0)
        press('w', 1000)
        press('s', 650)
        press('a', 2000)
    } else if (index = 8){
        ;number 28 on wiki
        walkJump('a', 0)
        walkJump('a', 250)
        press('w', 3500)
    } else if (index = 9){
        ;number 31 on wiki
        press('a', 1500)
    } else if (index = 10){
        ;number 16 on wiki
        walkJump('s', 250)
        press('a', 1650)
    } else if (index = 11){
        ;number 17 on wiki
        press('d', 1650)
        press('s', 4750)
    } else if (index = 12){
        ;number 27 on wiki
    } else if (index = 13){
        ;number 5 on wiki
        walkJump('w', 650)
        press('w', 850)
        press('a', 3850)
    } else if (index = 14){
        ;number 4 on wiki
        walkJump('s', 0)
        press('s', 1000)
        press('a', 1000)
    } else if (index = 15){
        ;number 30 on wiki
        walkJump('d', 250)
        press('d', 2000)
        press('w', 500)
        press('d', 1500)
    }
    Sleep(200)
    collectItem()
}

pathBranch(index){
    if (index = 1){
        ;all made in vip account
        ;and all tested in non-vip account
        goToItem(1)
        goToItem(2)
        goToItem(3)
        goToItem(4)
        goToItem(5)
    } else if (index = 2){
        ;all made in vip account
        ;and all tested in non-vip account
        goToItem(6)
        goToItem(7)
        goToItem(8)
        goToItem(9)
        goToItem(10)
        goToItem(11)
    } else if (index = 3){
        ;all made in vip account
        ;and all tested in non-vip account
        goToItem(12)
        goToItem(13)
        goToItem(14)
        goToItem(15)
    }
    resetCharacter()
}

path(){
    pathBranch(1)
    alignCharacter(2)
    pathBranch(2)
    alignCharacter(3)
    alignCharacter(4)
    pathBranch(3)
    alignCharacter(1)
}

runPath(){
    if WinExist('Roblox'){
        WinActivate('Roblox')
        alignCamera()
        alignCharacter(1)
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