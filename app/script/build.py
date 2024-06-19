'''
Build script for release
'''

import os
from datetime import datetime

builtAt = datetime.now().strftime("%Y-%m-%d %H:%M")

common = [
    '--obfuscate',
    '--split-debug-info=splitMap',
    '--dart-define-from-file=.env',
    f'--dart-define=builtAt="{builtAt}"',
    # '--verbose'
]

android = [
    'flutter',
    'build',
    'apk',
    '--target-platform android-arm64',
    '--split-per-abi',
    *common,
]

os.system(' '.join(android))

androidCopy = [
    'copy',
    r'"build\app\outputs\flutter-apk\app-arm64-v8a-release.apk"',
    '"out"',
]

os.system(' '.join(androidCopy))

windows = ['flutter', 'build', 'windows', *common]

os.system(' '.join(windows))

windowsZip = [
    'bz',
    'c',
    '"out/Mercurius for Windows.zip"',
    'build/windows/x64/runner/Release',
]

os.system(' '.join(windowsZip))
