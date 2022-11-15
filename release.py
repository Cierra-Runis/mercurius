'''
自动化 python 脚本
release.py
'''

import os
import re

REG_STR = {
    'release_yml': r'tag: "v(.*)"',
}

FILE_DIR = {
    'release_yml': r'.github\workflows\releases.yml',
    'body_md': r'body.md'
}


def get_current_version_str_from_release_yml() -> str:
    '''
    从 release.yml 文件中获取当前版本的字符串
    '''
    file = open(FILE_DIR['release_yml'], 'r', encoding='utf-8')
    text = file.read()
    result = re.search(REG_STR['release_yml'], text).group(1)
    file.close()
    return result


def release_model():
    '''
    release 模块
    '''
    print('-- release.py --')
    release_version_str = get_current_version_str_from_release_yml()
    print(f'> 正在发布 v{release_version_str}')
    os.system('git add .')
    os.system(f'git commit -m "v{release_version_str}"')
    os.system('git push')
    print(f'> 已发布 v{release_version_str}')


if __name__ == '__main__':

    # 进入 release 模块
    release_model()
