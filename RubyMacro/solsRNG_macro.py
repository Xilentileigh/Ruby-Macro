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
CONFIG_PATH = f'{currentDirectory}\\config.ini'
COLLECT_ITEM_PATH = f'{currentDirectory}\\collectItem.ahk'
defaultSetting = {
    'ahk_path': 'C:\\Program Files\\AutoHotkey\\v2\\AutoHotkey64.exe',
    'vip': '0',
    'path_segment1': '1',
    'path_segment2': '1',
    'path_segment3': '1',
    'path_segment4': '1',
    'camera_sensitivity': '0',
    'escape_menu': '1',
    'in_setting': '0',
}

def saveSetting(setting=None):
    config = configparser.ConfigParser()
    config['setting'] = setting if setting is not None else globals()['setting']
    with open(CONFIG_PATH, 'w') as file:
        config.write(file)

def loadSetting():
    if not os.path.exists(CONFIG_PATH):
        setting = defaultSetting
        saveSetting(setting)
    config = configparser.ConfigParser()
    config.read(CONFIG_PATH)
    setting = {section: dict(config[section]) for section in config.sections()}
    setting = setting['setting']
    if any(key not in setting for key in defaultSetting):
        setting = defaultSetting
        saveSetting(setting)
    return setting

setting = loadSetting()

def checkSetting():
    if not os.path.exists(setting['ahk_path']):
        while True:
            os.system('cls')
            print('AutoHotkey v2 not found. Please install AutoHotkey v2')
            print('or enter AutoHotkey v2 path, if you had already installed it')
            print('"AutoHotkey64.exe" for 64 bit operating system')
            print('and "AutoHotkey32.exe" for 32 bit operating system')
            print('Enter 1 to download AutoHotkey v2')
            print('Enter 2 to enter AutoHotkey v2 path')
            response = input()
            if response == '1':
                webbrowser.open('https://www.autohotkey.com/')
                exit()
            elif response == '2':
                setting['ahk_path'] = input('Please enter AutoHotkey v2 path: ').strip('"')
                break
    if not setting['vip'] in ['0', '1']:
        setting['vip'] = defaultSetting['vip']
    if not 0 <= float(setting['camera_sensitivity']) <= 100:
        setting['camera_sensitivity'] = defaultSetting['camera_sensitivity']
    if not setting['in_setting'] in ['0', '1']:
        setting['in_setting'] = defaultSetting['in_setting']
    if not setting['path_segment1'] in ['1', '0']:
        setting['path_segment1'] = defaultSetting['path_segment1']
    if not setting['path_segment2'] in ['1', '0']:
        setting['path_segment2'] = defaultSetting['path_segment2']
    if not setting['path_segment3'] in ['1', '0']:
        setting['path_segment3'] = defaultSetting['path_segment3']
    if not setting['path_segment4'] in ['1', '0']:
        setting['path_segment4'] = defaultSetting['path_segment4']
    if not setting['escape_menu'] in ['1', '2']:
        setting['escape_menu'] = defaultSetting['escape_menu']
    saveSetting()
        
checkSetting()

def restart():
    python = sys.executable
    os.execv(python, [python] + sys.argv)

def goToSetting():
    setting['in_setting'] = '1' if setting['in_setting'] == '0' else '0'
    saveSetting()
    restart()

def configureSetting():
    if setting['in_setting'] == '0':
        return
    sys.stdin.flush()
    response = input('Enter which setting you want to change: ')
    if response == '1':
        setting['ahk_path'] = input('Please enter AutoHotkey v2 path: ').strip('"')
    elif response == '2':
        setting['vip'] = '1' if setting['vip'] == '0' else '0'
    elif response == '3':
        setting['path_segment1'] = '1' if setting['path_segment1'] == '0' else '0'
    elif response == '4':
        setting['path_segment2'] = '1' if setting['path_segment2'] == '0' else '0'
    elif response == '5':
        setting['path_segment3'] = '1' if setting['path_segment3'] == '0' else '0'
    elif response == '6':
        setting['path_segment4'] = '1' if setting['path_segment4'] == '0' else '0'
    elif response == '7':
        setting['camera_sensitivity'] = float(input('Please enter your roblox sensitivity: '))
    elif response == '8':
        setting['escape_menu'] = '1' if setting['escape_menu'] == '2' else '2'
    saveSetting()
    restart()

def runPath():
    if gw.getWindowsWithTitle('path.ahk'):
        return
    try:
        subprocess.run([setting['ahk_path'], COLLECT_ITEM_PATH, 'auto'])
    except Exception as e:
        print('Autohotkey v2 path might not be of correct directory')
        response = input('do you want to re-enter the autohotkey v2 path? (y/n): ')
        if response != 'y':
            print(e)
            print('The program will now exit in 5 seconds')
            time.sleep(5)
            exit()
        setting['ahk_path'] = input('Please enter AutoHotkey v2 path: ').strip('"')
        saveSetting()
        restart()

if setting['in_setting'] == '0':
    os.system('cls')
    print('Press Alt + s to go into settings')
    print('Press F1 to start macro')
    print('Press F2 to stop macro')
    print('Press F3 to exit macro')
else:
    os.system('cls')
    print('Press Ctrl+Alt+s to change setting')
    print('Press Alt + s again to exit')
    for index, key in enumerate(setting, start=1):
        print(f'{index}. {key}: {setting[key]}')

keyboard.add_hotkey('alt+s', goToSetting)
keyboard.add_hotkey('ctrl+alt+s', configureSetting)
keyboard.add_hotkey('F1', runPath)
keyboard.wait('F3')