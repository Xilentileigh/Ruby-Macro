#Requires AutoHotkey v2.0
#SingleInstance Force

CONFIG_PATH := A_ScriptDir . '\config.ini'
defaultSetting := 0
settingVIP := Integer(IniRead(CONFIG_PATH, 'setting', 'vip', defaultSetting))
VIP_WALK_SPEED := 1.25
possibleKeys := ['w', 'a', 's', 'd', 'i', 'o']

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
    loop 4 {
        Send('e')
        Sleep(500)
    }
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
    MouseMove(A_ScreenWidth / 2, (A_ScreenHeight*0.25)+5, 50)
    walkSend('RButton', 'up')
    Sleep(200)
}

alignCamera(num){
    if (num = 1){
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
    } else if (num = 2){
        Send('{Escape}')
        Sleep(200)
        Send('{Tab}')
        Sleep(200)
        Send('{Down}')
        Sleep(200)
        loop 2 {
            Send('{Right}')
            Sleep(200)
        }
        Sleep(2000)
        loop 2 {
            Send('{Right}')
            Sleep(200)
        }
        Send('r')
        Sleep(200)
        Send('{Enter}')
        Sleep(2000)
    }
}

alignCharacter(num){
    if (num = 1){
        press('s', 1000)
        diagonalMovement('s', 'd', 2250)
        press('s', 4000)
        diagonalMovement('s', 'a', 1500)
        diagonalMovement('w', 'd', 500)
    } else if (num = 2){
        diagonalMovement('w', 'd', 2500)
        press('w', 3500)
        diagonalMovement('w', 'd', 2500)
        diagonalMovement('s', 'a', 250)
    } else if (num = 3){
        diagonalMovement('s', 'd', 1000)
        press('s', 2650)
        press('a', 1500)
    } else if (num = 4){
        diagonalMovement('a', 'w', 3000)
        press('a', 3500)
        diagonalMovement('a', 's', 1500)
        diagonalMovement('w', 'd', 350)
    } else if (num = 5){
        walkJump('a', 0)
        press('a', 6500)
        press('w', 1650)
        press('a', 2900)
        press('s', 500)
        press('a', 1000)
        diagonalMovement('a', 'w', 2500)
        diagonalMovement('d', 's', 100)
    }
    Sleep(200)
}

goToItem(num){
    if (num = 1){
        ;number 26 on wiki
        press('w', 1150)
        press('d', 250)
    } else if (num = 2){
        ;number 13 on wiki
        press('d', 1250)
        diagonalMovement('d', 's', 1500)
        walkJump('s', 1450)
    } else if (num = 3){
        ;number 25 on wiki
        press('s', 700)
        walkJump('d', 650)
        press('d', 1150)
    } else if (num = 4){
        ;number 22 on wiki
        walkJump('a', 2250)
        press('a', 2500)
        press('s', 1350)
        press('a', 1000)
    } else if (num = 5){
        ;number 13 on wiki
        press('d', 1000)
        walkJump('w', 250)
        press('w', 1250)
        walkJump('a', 350)
        press('a', 2250)
    } else if (num = 6){
        ;number 21 on wiki
        press('s', 750)
        press('d', 1850)
        press('s', 2000)
        walkJump('d', 0)
        press('d', 1000)
    } else if (num = 7){
        ;number 15 on wiki
        press('a', 650)
        press('w', 1850)
    } else if (num = 8){
        ;number 28 on wiki
        walkJump('w', 150)
        walkJump('w', 350)
        press('d', 3500)
    } else if (num = 9){
        ;number 31 on wiki
        press('w', 1500)
    } else if (num = 10){
        ;number 16 on wiki
        walkJump('a', 200)
        press('w', 1650)
    } else if (num = 11){
        ;number 17 on wiki
        press('s', 1650)
        press('a', 4750)
    } else if (num = 12){
        ;number 27 on wiki
    } else if (num = 13){
        ;number 5 on wiki
        walkJump('d', 650)
        press('d', 850)
        press('w', 3850)
    } else if (num = 14){
        ;number 4 on wiki
        walkJump('a', 0)
        press('a', 1000)
        press('w', 1000)
    } else if (num = 15){
        ;number 30 on wiki
        walkJump('s', 250)
        press('s', 2000)
        press('d', 500)
        press('s', 1500)
    }
    collectItem()
}

pathBranch(num){
    if (num = 1){
        ;all made in vip account
        ;and all tested in non-vip account
        goToItem(1)
        goToItem(2)
        goToItem(3)
        goToItem(4)
        goToItem(5)
    } else if (num = 2){
        ;all made in vip account
        ;and all tested in non-vip account
        goToItem(6)
        goToItem(7)
        goToItem(8)
        goToItem(9)
        goToItem(10)
        goToItem(11)
    } else if (num = 3){
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
    alignCharacter(4)
    alignCharacter(5)
    pathBranch(3)
    alignCharacter(1)
}

runPath(){
    if WinExist('Roblox'){
        WinActivate('Roblox')
        alignCamera(1)
        alignCharacter(3)
        alignCamera(2)
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