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
defaultSetting = {'ahkPath': 'C:\\Program Files\\AutoHotkey\\v2\\AutoHotkey64.exe', 'vip': '0'}

def saveSetting():
    config = configparser.ConfigParser()
    config['setting'] = setting
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
        saveSetting()
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
            print('Enter 1 to install AutoHotkey v2')
            response = input('Enter 2 to enter AutoHotkey v2 path\n')
            if response == '1':
                webbrowser.open('https://www.autohotkey.com/')
                print('The program will now exit')
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

def saveVIP():
    setting['vip'] = '1' if setting['vip'] == '0' else '0'
    saveSetting()
    restart()

getVIP()

def runPath(alignment=True):
    if gw.getWindowsWithTitle('path.ahk'):
        return
    try:
        subprocess.run([setting['ahkpath'], COLLECT_ITEM_PATH, '1' if alignment else '0'])
    except Exception as e:
        print('Autohotkey v2 path might not be of correct directory')
        response = input('do you want to reenter the autohotkey v2 path? (y/n): ')
        if response == 'y':
            setting['ahkpath'] = ''
            saveSetting()
            restart()
        else:
            print(e)
            print('The program will now exit')
            time.sleep(5)
            exit()

os.system('cls')
print(f'current VIP setting: {'Enabled' if setting['vip'] == '1' else 'Disabled'}')
print('Press Shift + F1 to change VIP setting')
print('Press F1 to start macro')
print('Press F2 to stop macro')
print('Press F3 to exit macro')

keyboard.add_hotkey('shift+F1', saveVIP)
keyboard.add_hotkey('F1', runPath)
keyboard.add_hotkey('F4', lambda: runPath(alignment=False))
keyboard.wait('F3')