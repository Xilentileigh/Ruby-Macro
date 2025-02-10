import os
import subprocess
import sys
import configparser
import time

def install_package(package):
    subprocess.check_call([sys.executable, '-m', 'pip', 'install', package])

requiredPackages = ['pygetwindow', 'webbrowser', 'keyboard']

for package in requiredPackages:
    try:
        __import__(package)
    except ImportError:
        install_package(package)

import pygetwindow as gw
import webbrowser
import keyboard

currentDirectory = os.path.dirname(os.path.abspath(__file__))
COLLECT_ITEM_PATH = f'{currentDirectory}\\path.ahk'
CONFIG_PATH = f'{currentDirectory}\\config.ini'
defaultSetting = {'ahkpath': 'C:\\Program Files\\AutoHotkey\\v2\\AutoHotkey64.exe', 'vip': '0', 'insetting': '0'}

def saveSetting(setting=None):
    config = configparser.ConfigParser()
    config['setting'] = setting if setting is not None else globals()['setting']
    with open(CONFIG_PATH, 'w') as file:
        config.write(file)

def loadSetting():
    try:
        config = configparser.ConfigParser()
        config.read(CONFIG_PATH)
        setting = {section: dict(config[section]) for section in config.sections()}
        setting = setting['setting']
    except:
        setting = defaultSetting
        saveSetting(setting)
    return setting

setting = loadSetting()

def getAhkPath():
    if os.path.exists(setting['ahkpath']):
        return
    else:
        while True:
            os.system('cls')
            print('AutoHotkey v2 path not found')
            print('Please install AutoHotkey v2')
            print('or enter AutoHotkey v2 path')
            print('"AutoHotkey64.exe" for 64 bit operating system')
            print('and "AutoHotkey32.exe" for 32 bit operating system')
            print('Enter 1 to download AutoHotkey v2')
            print('Enter 2 to enter AutoHotkey v2 path')
            response = input()
            if response == '1':
                webbrowser.open('https://www.autohotkey.com/')
                exit()
            elif response == '2':
                setting['ahkpath'] = input('Please enter AutoHotkey v2 path: ').strip('"')
                break
        saveSetting()

getAhkPath()

def getVIP():
    if not setting['vip'] in ['0', '1']:
        setting['vip'] = defaultSetting['vip']
        saveSetting()

def restart():
    python = sys.executable
    os.execv(python, [python] + sys.argv)
            
getVIP()

def runPath():
    if gw.getWindowsWithTitle('path.ahk'):
        return
    try:
        subprocess.run([setting['ahkpath'], COLLECT_ITEM_PATH])
    except Exception as e:
        print('Autohotkey v2 path might not be of correct directory')
        response = input('do you want to re-enter the autohotkey v2 path? (y/n): ')
        if response == 'y':
            setting['ahkpath'] = ''
            saveSetting()
            restart()
        else:
            print(e)
            print('The program will now exit')
            time.sleep(5)
            exit()

def goToSetting():
    setting['insetting'] = '1' if setting['insetting'] == '0' else '0'
    saveSetting()
    restart()

def configureSetting():
    if setting['insetting'] == '1':
        response = input('Enter which setting you want to change: ')
        if response == '1':
            setting['ahkpath'] = input('Please enter AutoHotkey v2 path: ').strip('"')
        elif response == '2':
            setting['vip'] = '1' if setting['vip'] == '0' else '0'
    saveSetting()
    restart()

if setting['insetting'] == '0':
    os.system('cls')
    print('Press Shift + F1 to go into settings')
    print('Press F1 to start macro')
    print('Press F2 to stop macro')
    print('Press F3 to exit macro')
else:
    os.system('cls')
    print('Press Ctrl+Alt+s to change setting')
    print('Press Shift + F1 again to exit')
    for index, key in enumerate(setting, start=1):
        print(f'{index}. {key}: {setting[key]}')
    

keyboard.add_hotkey('shift+F1', goToSetting)
keyboard.add_hotkey('ctrl+alt+s', configureSetting)
keyboard.add_hotkey('F1', runPath)
keyboard.wait('F3')