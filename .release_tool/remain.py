"""
自动化 python 脚本
remain.py
"""

from enum import Enum
import os
import re
import shutil
import zipfile

import yaml


class RegStr(Enum):
    """
    reg str
    """
    version_str: str = r'(\d+)\.(\d+)\.(\d+)\+(\d+)'


class FileStr(Enum):
    """
    file str
    """
    pubspec_yaml: str = r'pubspec.yaml'
    app_arm64_v8a_release_apk: str = r'build\app\outputs\apk\release\app-arm64-v8a-release.apk'
    release_tool_dir: str = r'.release_tool'
    release_dir: str = r'build\windows\runner\Release'


def get_version_from_pubspec_yaml() -> str:
    """
    从 pubspec.yaml 文件中获取当前版本的字符串
    """
    file = open(FileStr.pubspec_yaml.value, encoding='utf-8')
    data = yaml.load(file, Loader=yaml.FullLoader)
    print(data)
    result = data['version']
    file.close()
    return result


# TODO: 处理注释丢失的问题
def rewrite_current_version_in_pubspec_yaml(new_version: str) -> None:
    """
    修改 pubspec.yaml 文件中的版本号
    """
    with open(FileStr.pubspec_yaml.value, 'r', encoding='utf-8') as f:
        data = yaml.load(f, Loader=yaml.FullLoader)
    data['version'] = new_version
    with open(FileStr.pubspec_yaml.value, 'w', encoding='utf-8') as f:
        f.write(yaml.dump(data))


def is_new_version_legal(current_version: str, new_version: str) -> bool:
    """
    比较版本号大小, 两字符串格式类似 1.0.0+1
    """
    current = re.match(RegStr.version_str.value, current_version)
    new = re.match(RegStr.version_str.value, new_version)

    if int(new[4]) < int(current[4]):
        print(f'> 新构建号 {new[4]} 应该不小于 {current[4]}')
        return False

    for i in range(1, 5):
        if int(new[i]) > int(current[i]):
            # 从最高级一一对比, 某级新版本若大于旧版本, 则确实新版本大
            # 返回 True
            return True
        if int(new[i]) < int(current[i]):
            # 从最高级一一对比, 某级新版本若小于旧版本, 则是新版本小了
            # 返回 False
            return False
    # 运行到这说明俩版本号一样大, 即重新构建该版本
    # 返回 True
    return True


def input_tool(
    first_message: str,
    rule: str,
    error_message: str,
    rule_function: any,
) -> str:
    """
    根据 rule_function 获取合法的值
    """
    # 提醒
    print(f'> {first_message} {rule}: ', end='')
    # 第一次输入
    input_str = input()
    # 当 rule_function(input_str) 返回 false
    # 即不合法时
    while not rule_function(input_str):
        # 重新提醒并输入
        print(f'> {error_message}')
        print(f'> {first_message} {rule}: ', end='')
        input_str = input()
    # 直至输入合法
    return input_str


def copy_tree(src_path: str, dst_path: str) -> None:
    '''
    复制 src_path 文件夹至 dst_path 目录下, 且要求俩者后不接 '/'
    '''
    if not os.path.isdir(src_path):
        print(f'> 所复制 {src_path} 不存在')
    else:
        if os.path.isdir(dst_path):
            shutil.rmtree(dst_path)
        shutil.copytree(src_path, dst_path)
        print(f'> 已复制 {src_path} 至 {dst_path} 下')


def zip_file(src_dir):
    '''
    压缩 src_dir 文件夹
    '''
    zip_name = src_dir + '.zip'
    zip_files = zipfile.ZipFile(zip_name, 'w', zipfile.ZIP_DEFLATED)
    for dirpath, _, filenames in os.walk(src_dir):
        fpath = dirpath.replace(src_dir, '')
        fpath = fpath and fpath + os.sep or ''
        for filename in filenames:
            zip_files.write(os.path.join(dirpath, filename), fpath + filename)

    zip_files.close()
    print(f'> 已压缩 {src_dir}.zip')


def copy_file(src_file: str, dst_path: str) -> None:
    """
    复制 src_file 文件至 dst_path 目录下, 且要求 dst_path 后不接 '/'
    """
    if not os.path.isfile(src_file):
        print(f'> 所复制 {src_file} 不存在')
    else:
        _, file_name = os.path.split(src_file)
        if not os.path.exists(dst_path + '/'):
            os.makedirs(dst_path + '/')
        shutil.copy(src_file, dst_path + '/' + file_name)
        print(f'> 已复制 {src_file} 至 {dst_path} 下')


def main_module() -> None:
    """
    主模块
    """
    # 程序开始
    print('-- main.py --')
    current_version_str = get_version_from_pubspec_yaml()
    input_str = ''

    input_str = input_tool(
        first_message=f'是否更改当前版本 {current_version_str}',
        rule='(y/n)',
        error_message='请只输入 y 或 n',
        rule_function=lambda input_str: input_str == 'y' or input_str == 'n',
    )

    # 若输入的是 'y'
    if input_str == 'y':

        input_str = input_tool(
            first_message='请输入版本号',
            rule='',
            error_message='请确认版本号格式',
            rule_function=lambda input_str: re.search(
                RegStr.version_str.value,
                input_str,
            ),
        )

        # 当新版本号不合法时
        while not is_new_version_legal(current_version_str, input_str):
            # 重新提醒并输入
            print(f'> 请使得新输入的版本号 {input_str} 不小于旧版本号 {current_version_str}')
            input_str = input_tool(
                first_message='请输入版本号',
                rule='',
                error_message='请确认版本号格式',
                rule_function=lambda input_str: re.search(
                    RegStr.version_str.value,
                    input_str,
                ),
            )
        # 直至新版本号合法

        # 写入新版本号至 pubspec.yaml 文件
        # rewrite_current_version_in_pubspec_yaml(input_str)

        # 版本号已修改
        print(f'> 版本号已修改为 {get_version_from_pubspec_yaml()}')

        # 修改版本号后自动构建 apk
        os.system(
            'flutter build apk' + ' --obfuscate' +
            ' --split-debug-info=splitMap' +
            ' --target-platform android-arm64' + ' --split-per-abi', )

        # 并将 build 后的 apk 转移至 .release_tool/
        copy_file(
            src_file=FileStr.app_arm64_v8a_release_apk.value,
            dst_path=FileStr.release_tool_dir.value,
        )

        # 修改版本号后自动构建 exe
        os.system(
            'flutter build windows' +
            ' --obfuscate --split-debug-info=splitMap', )

        # 并将 build 后的 Release 文件夹转移至 .release_tool/
        copy_tree(
            src_path=FileStr.release_dir.value,
            dst_path=f'{FileStr.release_tool_dir.value}/Mercurius for Windows',
        )

        # 并进行压缩和打包
        zip_file(f"{FileStr.release_tool_dir.value}/Mercurius for Windows")

    else:
        # 反之输入的不是 'y'
        print('> 已取消更改版本号')


def release_module():
    '''
    '''


if __name__ == '__main__':

    os.system('cls')

    # 进入 主模块
    main_module()

    # 进入 发布模块
    release_module()
