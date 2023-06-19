"""
自动化 python 脚本
main.py
"""

import os
import re
import shutil
from enum import Enum
import yaml


class RegStr(Enum):
    """
    reg str
    """
    version_str: str = r'(\d+)\.(\d+)\.(\d+)\+(\d+)'
    pubspec_yaml: str = r'version: (\d+\.\d+\.\d+\+\d+)'
    release_yml: str = r'tag: "v(.*)"'
    body_md: str = r'v(.*)'


class FileStr(Enum):
    """
    file str
    """
    pubspec_yaml: str = r'pubspec.yaml'
    release_yml: str = r'.github\workflows\releases.yml'
    body_md: str = r'.release_tool\body.md'
    app_arm64_v8a_release_apk: str = r'build\app\outputs\apk\release\app-arm64-v8a-release.apk'
    release_tool_dir: str = r'.release_tool'


def get_version_from_pubspec_yaml() -> str:
    """
    从 pubspec.yaml 文件中获取当前版本的字符串
    """
    file = open(FileStr.pubspec_yaml.value, encoding='utf-8')
    data = yaml.load(file, Loader=yaml.FullLoader)
    result = data['version']
    file.close()
    return result


def rewrite_tool(file_dir: str, reg: str, repl: str) -> None:
    """
    改写用辅助函数
    """
    file = open(file_dir, 'r+', encoding='utf-8')
    text = file.read()
    file.seek(0, 0)
    text = re.sub(reg, repl, text)
    file.write(text)
    file.close()


def rewrite_current_version_in_pubspec_yaml(new_version: str) -> None:
    """
    修改 pubspec.yaml 文件中的版本号
    """
    rewrite_tool(
        file_dir=FileStr.pubspec_yaml.value,
        reg=RegStr.pubspec_yaml.value,
        repl=f'version: {new_version}',
    )


def rewrite_release_version(new_version: str) -> None:
    """
    修改 release.yml 和 body.md 文件中的版本号
    """

    rewrite_tool(
        file_dir=FileStr.release_yml.value,
        reg=RegStr.release_yml.value,
        repl=f'tag: "v{new_version}"',
    )
    rewrite_tool(
        file_dir=FileStr.body_md.value,
        reg=RegStr.body_md.value,
        repl=f'v{new_version}',
    )


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
        rewrite_current_version_in_pubspec_yaml(input_str)

        # 版本号已修改
        print(f'> 版本号已修改为 {get_version_from_pubspec_yaml()}')

        # 修改版本号后自动构建
        os.system(
            'flutter build apk' + ' --obfuscate' +
            ' --split-debug-info=splitMap' +
            ' --target-platform android-arm64' + ' --split-per-abi', )

        # 并将 build 后的 apk 转移至 .release_tool/
        copy_file(
            src_file=FileStr.app_arm64_v8a_release_apk.value,
            dst_path=FileStr.release_tool_dir.value,
        )

    else:
        # 反之输入的不是 'y'
        print('> 已取消更改版本号')


def release_module() -> None:
    """
    发布模块
    """
    current_version_str = get_version_from_pubspec_yaml()
    input_str = ''

    input_str = input_tool(
        first_message=f'是否发布当前版本 {current_version_str}',
        rule='(y/n)',
        error_message='请只输入 y 或 n',
        rule_function=lambda input_str: input_str == 'y' or input_str == 'n',
    )

    # 若输入的是 'y'
    if input_str == 'y':
        # 修改发布版本
        rewrite_release_version(current_version_str)
        # 打开 body.md 文件进行修改
        print('> 已为你打开 body.md 文件')
        os.startfile(FileStr.body_md.value)

        # 打开文件后询问是否完成
        input_str = input_tool(
            first_message='是否完成修改',
            rule='(y)',
            error_message='请输入 y 以确认修改完成',
            rule_function=lambda input_str: input_str == 'y',
        )

        # 梳理逻辑, 本脚本分为两个模块
        # 1. 通过脚本修改版本号则保证 pubspec.yaml 和 apk 版本一致
        # 2. 通过脚本发布软件保证 pubspec.yaml 和 body.md , tag.md 的版本一致
        # 一般流程为 1 -> 1 -> 1 -> 2 即多次修改版本号后发布, 无异常
        # 提交 release
        print('-- release.py --')
        release_version_str = get_version_from_pubspec_yaml()
        print(f'> 正在发布 v{release_version_str}')
        os.system('git add .')
        os.system(f'git commit -m "🎉 Release v{release_version_str} 🎉"')
        os.system('git push')
        os.system(f'git tag v{release_version_str}')
        os.system('git push --tags')
        print(f'> 已发布 v{release_version_str}')

    else:
        # 反之输入的不是 'y'
        print('> 已取消发布 apk')


if __name__ == '__main__':

    os.system('cls')

    # 进入 主模块
    main_module()

    # 进入 发布模块
    release_module()
