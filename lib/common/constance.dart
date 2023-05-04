import 'package:mercurius/index.dart';

/// Mercurius 基础常数
class MercuriusConstance {
  /// 联系 url
  static const String contactUrl = 'https://github.com/Cierra-Runis/';

  /// 亮色模式下的颜色集
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF0061A2), // 普通按钮前景色
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFD1E4FF), // 浮动按钮背景色
    onPrimaryContainer: Color(0xFF001D36),
    secondary: Color(0xFF535F70),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD6E4F7),
    onSecondaryContainer: Color(0xFF0F1C2B),
    tertiary: Color(0xFF6A5778),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFF2DAFF),
    onTertiaryContainer: Color(0xFF251432),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFDFCFF), // 主要容器背景色
    onBackground: Color(0xFF1A1C1E),
    surface: Color(0xFFFDFCFF), // 标题栏和卡片背景颜色
    onSurface: Color(0xFF1A1C1E), // 最基础字体色
    surfaceVariant: Color(0xFFDFE2EB),
    onSurfaceVariant: Color(0xFF42474E),
    outline: Color(0x8A000000), // 下划线，选项小字，你记颜色
    onInverseSurface: Color(0xFFF1F0F4),
    inverseSurface: Color(0xFF2F3033),
    inversePrimary: Color(0xFF9DCAFF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFFDFCFF),
    outlineVariant: Color(0xFFC3C7CF),
    scrim: Color(0xFF000000),
  );

  /// 暗色模式下的颜色集
  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFFB787), // 普通按钮前景色
    onPrimary: Color(0xFF502400),
    primaryContainer: Color(0xFF363636), // 浮动按钮背景色
    onPrimaryContainer: Color(0xCCE1E1E1), // 浮动按钮前景色
    secondary: Color(0xFFE5BFA8),
    onSecondary: Color(0xFF422B1B),
    secondaryContainer: Color(0xFF5B4130),
    onSecondaryContainer: Color(0xFFFFDCC7),
    tertiary: Color(0xFFCACA93),
    onTertiary: Color(0xFF31320A),
    tertiaryContainer: Color(0xFF48491F),
    onTertiaryContainer: Color(0xFFE6E6AD),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF242424), // 主要容器背景色
    onBackground: Color(0xFFECE0DA),
    surface: Color(0xFF303030), // 标题栏和卡片背景颜色
    onSurface: Color(0xFFECE0DA), // 最基础字体色
    surfaceVariant: Color(0xFF52443C),
    onSurfaceVariant: Color(0xFFD7C3B8),
    outline: Color(0x8AFFFFFF), // 下划线，选项小字，你记颜色
    onInverseSurface: Color(0xFF201A17),
    inverseSurface: Color(0xFFECE0DA),
    inversePrimary: Color(0xFF964900),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF181818),
    outlineVariant: Color(0xFF303030),
    scrim: Color(0xFF000000),
  );
}

/// 日记相关常数
class DiaryConstance {
  /// 将心情字符串如 `'开心'` 映射为 `UniconsLine.smile`
  static const Map<String, IconData> moodMap = {
    '开心': UniconsLine.smile,
    '一般': UniconsLine.meh_closed_eye,
    '生气': UniconsLine.angry,
    '困惑': UniconsLine.confused,
    '失落': UniconsLine.frown,
    '大笑': UniconsLine.laughing,
    '难受': UniconsLine.silent_squint,
    '大哭': UniconsLine.sad_crying,
    '我死': UniconsLine.smile_dizzy,
  };

  /// 将天气字符串如 `'100'` 映射为 `QWeatherIcon.code_100`
  static const Map<String, IconData> weatherMap = {
    '100': QWeatherIcon.code_100,
    '101': QWeatherIcon.code_101,
    '104': QWeatherIcon.code_104,
    '303': QWeatherIcon.code_303,
    '305': QWeatherIcon.code_305,
    '307': QWeatherIcon.code_307,
    '400': QWeatherIcon.code_400,
    '402': QWeatherIcon.code_402,
    '501': QWeatherIcon.code_501,
  };

  /// 将天气字符串如 `'100'` 映射为 `'晴'`
  static const Map<String, String> weatherCommitMap = {
    '100': '晴',
    '101': '多云',
    '104': '阴',
    '303': '雷暴',
    '305': '小雨',
    '307': '大雨',
    '400': '小雪',
    '402': '大雪',
    '501': '雾',
  };
}

/// 数独相关常数
class SudokuConstance {
  /// 将字符串如 `'初级'` 映射为 `Icons.child_friendly_rounded`
  static const Map difficultyIconMay = {
    '初级': Icons.child_friendly_rounded,
    '中级': Icons.child_care_rounded,
    '高级': Icons.school_rounded,
    '大师级': Icons.biotech_rounded,
  };

  /// 将字符串如 `'初级'` 映射为数字 `18`
  static const Map difficultyMap = {
    '初级': 18,
    '中级': 27,
    '高级': 36,
    '大师级': 54,
  };
}

/// `API` 所需的 `key`
class ApiKeyConstance {
  /// 和风天气 `api` 所需开发者 `key`
  static const String qWeatherKey = 'a13fc8e191d14cc0930bc07c6660d900';

  /// 高德 `api` 所需开发者 `key`
  static const String aMapKey = 'eb5254d31736ca5298ad4d68fae76c09';
}

/// 用户协议相关常数
class AgreementContentConstance {
  /// 协议更新时间
  static const String agreementContentUpdateDate = '更新于 2022 年 11 月 18 日';

  /// 协议内容
  static const String agreementContent = '''
欢迎使用 Cierra_Runis 提供的 Mercurius 软件及服务。

本次 Cierra_Runis 编写了《Mercurius 用户协议》（以下简称「本协议」）。

为了更好的使用 Mercurius，请您仔细阅读本协议，如您对本协议有任何异议或疑问，您可以选择停止使用 Mercurius。若您使用 Mercurius 提供的服务，或在 Mercurius 中发布任何内容（即「内容」），均视为您（即「用户」）完全接受本协议项下的全部条款。

一、使用规则
1. Mercurius 将给予每个用户一个用户帐号及相应的密码，该用户帐号和密码由用户负责保管；用户应当对以其用户帐号进行的所有活动和事件负法律责任。
2. 用户须对在 Mercurius 的注册信息的真实性、合法性、有效性承担全部责任，用户不得冒充他人；不得利用他人的名义发布任何信息；不得恶意使用注册帐号导致其他用户误认；否则 Mercurius 有权立即停止提供服务，收回其帐号并由用户独自承担由此而产生的一切法律责任。
3. 用户直接或通过各类方式间接使用 Mercurius 服务和数据的行为，都将被视作已无条件接受本协议全部内容；若用户对本协议的任何条款存在异议，请停止使用 Mercurius 所提供的全部服务。
4. Mercurius 是一个信息分享、传播及获取的平台，用户通过 Mercurius 发表的信息为公开的信息，其他第三方均可以通过 Mercurius 获取用户发表的信息，用户对任何信息的发表即认可该信息为公开的信息，并单独对此行为承担法律责任；任何用户不愿被其他第三人获知的信息都不应该在 Mercurius 上进行发表。
5. 用户承诺不得以任何方式利用 Mercurius 直接或间接从事违反中国法律以及社会公德的行为，Mercurius 有权对违反上述承诺的内容予以删除。
6. 用户不得利用 Mercurius 服务制作、上载、复制、发布、传播或者转载如下内容：
- 反对中华人民共和国宪法所确定的基本原则的；
- 危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；
- 损害国家荣誉和利益的；
- 煽动民族仇恨、民族歧视，破坏民族团结的；
- 侮辱、滥用英烈形象，否定英烈事迹，美化粉饰侵略战争行为的；
- 破坏国家宗教政策，宣扬邪教和封建迷信的；
- 散布谣言，扰乱社会秩序，破坏社会稳定的；
- 散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；
- 侮辱或者诽谤他人，侵害他人合法权益的；
- 宣扬、教唆使用外挂、私服以及木马的相关内容的；
- 发布任何经本平台合理判断为不妥当或者本平台未认可的软件、文件等在内的主页地址或者链接的；
- 含有中华人民共和国法律、行政法规禁止的其他内容的信息。

  如果用户在使用 Mercurius 的过程中违反了相关法律法规或本协议约定，相关国家机关或机构可能会对您提起诉讼、罚款或采取其他制裁措施，并要求 Cierra_Runis 给予协助。用户应自行承担全部责任，Cierra_Runis 不承担任何责任。
7. Mercurius 有权对用户使用 Mercurius 的情况进行审查和监督，如用户在使用 Mercurius 时违反任何上述规定，Mercurius 或其授权的人有权要求用户改正或直接采取一切必要的措施（包括但不限于更改或删除用户上传的内容、暂停或终止用户使用 Mercurius 的权利）以减轻用户不当行为造成的影响。

二、Cierra_Runis 的义务
1. Cierra_Runis 同意通过互联网络根据本协议约定，为用户提供 Cierra_Runis 的 Mercurius 软件及服务。
2. Cierra_Runis 保存增值服务的兑换记录，保存期限为自用户兑换之日起 180 日。
3. 在使用 Cierra_Runis 增值服务的过程中，用户有权向 Cierra_Runis 要求协助调取兑换记录和转移记录，Cierra_Runis 应要求用户提供并核实与其注册身份信息相一致的个人有效身份信息或证明，核实用户所提供的个人有效身份信息或证明与所注册的身份信息相一致的，应当予以协助提供。用户没有提供其个人有效身份信息或证明，或者用户提供的个人有效身份信息或证明与所注册的身份信息不一致的，Cierra_Runis 有权拒绝用户前述请求。

三、用户的义务
1. 用户应自行准备上网所需的设备（如电脑、手机等电子设备）。
2. 用户应自行负担使用服务过程中的流量、电信、网络使用等费用。
3. 遵守本协议的约定、其他相关规则和制度的规定服务条款；遵守中华人民共和国相关法律法规。

四、免责声明
1. Mercurius 不能对用户上传内容的正确性进行保证。
2. 用户在 Mercurius 发表的内容仅表明其个人的立场和观点，并不代表 Mercurius 的立场或观点。作为内容的发表者，需自行对所发表内容负责，因所发表内容引发的一切纠纷，由该内容的发表者承担全部法律及连带责任。 Mercurius 不承担任何法律及连带责任。
3. Mercurius 不保证网络服务一定能满足用户的要求，也不保证网络服务不会中断，对网络服务的及时性、安全性、准确性也都不作保证。
4. 对于因不可抗力或 Mercurius 不能控制的原因造成的网络服务中断或其它缺陷，Mercurius 不承担任何责任，但将尽力减少因此而给用户造成的损失和影响。

五、知识产权声明
1. Cierra_Runis 依法享有服务的一切合法权益包括但不限于其中涉及的计算机软件著作权、美术作品著作权和专利权等知识产权等，或已从合法权利人处取得合法授权从而有权为用户提供 Cierra_Runis 相关服务。
2. Cierra_Runis 提供的服务可能涉及第三方知识产权，如该第三方对用户在 Cierra_Runis 服务中使用该知识产权有要求的，用户应当遵守该等要求。
3. 本协议未明确授予用户的权利均由 Cierra_Runis 保留。
4. 用户不得修改、改编、翻译 Cierra_Runis 服务所使用的软件、技术、材料等，或者创作与之相关的派生作品，不得通过反向工程、反编译、反汇编或其他类似行为获得其的源代码，否则由此引起的一切法律后果由用户负责，Cierra_Runis 将依法追究违约方的法律责任。
5. 用户不得擅自删除、掩盖或更改 Cierra_Runis 的版权声明。

六、协议修改
1. 根据互联网的发展和有关法律、法规及规范性文件的变化，或者因业务发展需要，Mercurius 有权对本协议的条款作出修改或变更，一旦本协议的内容发生变动，Mercurius 将会直接在 Mercurius 软件内公布修改之后的协议内容，该公布行为视为 Mercurius 已经通知用户修改内容。Mercurius 也可采用电子邮件或私信的传送方式，提示本协议的修改、服务变更、或其它重要事项。
2. 根据互联网的发展和有关法律、法规及规范性文件的变化，或者因业务发展需要，Mercurius 有权对本协议的条款作出修改或变更，一旦本协议的内容发生变动，Mercurius 将会直接在 Mercurius 软件内公布修改之后的协议内容，该公布行为视为 Mercurius 已经通知用户修改内容。Mercurius 也可采用电子邮件或私信的传送方式，提示本协议的修改、服务变更、或其它重要事项。

七、用户传播的信息与投诉处理
1. 用户通过 Cierra_Runis 提供的服务发送或传播的信息包括但不限于文字、图片、链接均由用户自行承担责任。
2. 用户发送或者传播的内容应当有合法的来源，传播的相关内容应为用户所有或者用户获得了授权。
3. 如果用户发送或传播的内容违法、违规或侵犯他人权利的，Cierra_Runis 有权根据实际情况采取删除原内容、冻结用户账号等措施。
4. 如果用户被其他用户举报或用户举报他人，视情况考量后，Cierra_Runis 有权将争议中相关方的主体信息、联系方式、投诉相关内容等必要信息提供给相关当事方或相关部门，以便及时解决投诉纠纷，保护各方合法权益。
5. 用户应保证在举报处理程序中提供的信息、材料、证据等的真实性、合法性、有效性负责。

八、用户所提供内容的知识产权及授权
1. Cierra_Runis 尊重知识产权并注重保护用户享有的各项权利。在参与 Cierra_Runis 的服务中，用户可能需要通过上传、发布等各种方式 Cierra_Runis 提供内容。在此情况下，用户仍然享有此等内容的完整知识产权。
2. 用户在此明确同意，您在提供前述内容的同时，不可撤销地授予本平台及其关联公司一项全球性的、永久的免费许可，允许 Cierra_Runis 使用、传播、展示此等内容。

九、法律适用和管辖
1. 本协议的生效、履行、解释及争议的解决均适用中华人民共和国法律。本条款因与中华人民共和国现行法律相抵触而导致部分无效，不影响其他部分的效力。双方同意，解决争议时，应以您同意的最新版用户协议为准。
2. 如果就本协议内容发生或执行产生任何争议，应本着友好协商的态度解决；协商不顺利时，则争议各方均一致同意将争议提交到相关司法部门按照其程序进行。裁决为一裁终局，对各方均有法律约束力。

十、未成年人使用条款
1. Cierra_Runis 十分注重未成年人的身心发展的健康。若用户为未成年人，应在监护人监护、指导下阅读本协议，并在取得监护人的同意后使用 Cierra_Runis 的产品和服务。
2. 监护人应指导子女上网应该注意的安全问题，防患于未然。Cierra_Runis 不鼓励未成年人在服务中有不合适的消费行为，如有消费，未成年人应请监护人操作或在监护人明示同意下操作。
3. 对于未成年人的隐私保护，Cierra_Runis 将严格按照公布的《Mercurius 隐私政策》中阐述的方式执行。
4. 未成年人用户涉世未深，面对信息时代爆炸的信息量容易被网络虚像信息所迷惑，处理事态的方法还不够成熟同时缺乏自我保护的能力，容易被别有用心的人利用。因此，未成年人用户在使用本服务时应注意以下事项，提高安全意识，加强自我保护：
    1. 分辨出网络与现实的界限，不要沉迷于网络影响日常的学习生活。
    2. 填写个人资料时需要提高警惕，加强个人保护意识，以免不法分子对个人生活造成骚扰。
    3. 应在监护人或老师的指导下，正确使用网络。
    4. 避免与陌生网友随意会面或参与联谊活动，以免不法分子有机可乘，危及自身安全。

十一、其他约定
1. 本协议所有条款的标题仅为方便阅读，本身并无实际涵义，不能作为本协议及相关条款涵义解释的依据。
2. 如本协议中的任何条款因任何原因被判定为完全或部分无效或不具有执行力的，本协议的其他条款仍应有效并有执行力。
3. Cierra_Runis 不行使、未能及时行使或者未充分行使本协议或者按照法律规定所享有的权利，不应被视为放弃该权利，也不影响 Cierra_Runis 在未来行使该权利。
4. 如果用户对本协议或 Mercurius 软件及服务有意见或建议，可与 Cierra_Runis 取得联系，Cierra_Runis 会给予必要的帮助。
''';
}

/// 引入声明相关常数
class DeclarationContentConstance {
  /// 协议更新时间
  static const String declarationContentUpdateDate = '更新于 2023 年 1 月 14 日';

  /// 协议内容
  static const String declarationContent = '''
欢迎使用 Cierra_Runis 提供的 Mercurius 软件及服务。

本次 Cierra_Runis 编写了《Mercurius 引入声明》（以下简称「本声明」）。

一、字体声明
1. Mercurius 引入了 Saira 字体作为 Mercurius 的主要字体。[License](Saira)

二、图标声明
1. Mercurius 引入了 Material Icons 作为 Mercurius 的主要图标。[License](Material_Icons)
2. Mercurius 引入了 unicons 作为 Mercurius 的次要图标。[License](unicons)
''';

  /// 协议明细
  static const Map license = {
    'Saira': '''
Copyright 2020 The Saira Project Authors (https://github.com/Omnibus-Type/Saira)

This Font Software is licensed under the SIL Open Font License, Version 1.1.
This license is copied below, and is also available with a FAQ at:
http://scripts.sil.org/OFL


-----------------------------------------------------------
SIL OPEN FONT LICENSE Version 1.1 - 26 February 2007
-----------------------------------------------------------

PREAMBLE
The goals of the Open Font License (OFL) are to stimulate worldwide
development of collaborative font projects, to support the font creation
efforts of academic and linguistic communities, and to provide a free and
open framework in which fonts may be shared and improved in partnership
with others.

The OFL allows the licensed fonts to be used, studied, modified and
redistributed freely as long as they are not sold by themselves. The
fonts, including any derivative works, can be bundled, embedded,
redistributed and/or sold with any software provided that any reserved
names are not used by derivative works. The fonts and derivatives,
however, cannot be released under any other type of license. The
requirement for fonts to remain under this license does not apply
to any document created using the fonts or their derivatives.

DEFINITIONS
"Font Software" refers to the set of files released by the Copyright
Holder(s) under this license and clearly marked as such. This may
include source files, build scripts and documentation.

"Reserved Font Name" refers to any names specified as such after the
copyright statement(s).

"Original Version" refers to the collection of Font Software components as
distributed by the Copyright Holder(s).

"Modified Version" refers to any derivative made by adding to, deleting,
or substituting -- in part or in whole -- any of the components of the
Original Version, by changing formats or by porting the Font Software to a
new environment.

"Author" refers to any designer, engineer, programmer, technical
writer or other person who contributed to the Font Software.

PERMISSION & CONDITIONS
Permission is hereby granted, free of charge, to any person obtaining
a copy of the Font Software, to use, study, copy, merge, embed, modify,
redistribute, and sell modified and unmodified copies of the Font
Software, subject to the following conditions:

1) Neither the Font Software nor any of its individual components,
in Original or Modified Versions, may be sold by itself.

2) Original or Modified Versions of the Font Software may be bundled,
redistributed and/or sold with any software, provided that each copy
contains the above copyright notice and this license. These can be
included either as stand-alone text files, human-readable headers or
in the appropriate machine-readable metadata fields within text or
binary files as long as those fields can be easily viewed by the user.

3) No Modified Version of the Font Software may use the Reserved Font
Name(s) unless explicit written permission is granted by the corresponding
Copyright Holder. This restriction only applies to the primary font name as
presented to the users.

4) The name(s) of the Copyright Holder(s) or the Author(s) of the Font
Software shall not be used to promote, endorse or advertise any
Modified Version, except to acknowledge the contribution(s) of the
Copyright Holder(s) and the Author(s) or with their explicit written
permission.

5) The Font Software, modified or unmodified, in part or in whole,
must be distributed entirely under this license, and must not be
distributed under any other license. The requirement for fonts to
remain under this license does not apply to any document created
using the Font Software.

TERMINATION
This license becomes null and void if any of the above conditions are
not met.

DISCLAIMER
THE FONT SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT
OF COPYRIGHT, PATENT, TRADEMARK, OR OTHER RIGHT. IN NO EVENT SHALL THE
COPYRIGHT HOLDER BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
INCLUDING ANY GENERAL, SPECIAL, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL
DAMAGES, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF THE USE OR INABILITY TO USE THE FONT SOFTWARE OR FROM
OTHER DEALINGS IN THE FONT SOFTWARE.
''',
    'Material_Icons': '''
    Apache License
    Version 2.0, January 2004
    http://www.apache.org/licenses/

    TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

    1. Definitions.

      "License" shall mean the terms and conditions for use, reproduction,
      and distribution as defined by Sections 1 through 9 of this document.

      "Licensor" shall mean the copyright owner or entity authorized by
      the copyright owner that is granting the License.

      "Legal Entity" shall mean the union of the acting entity and all
      other entities that control, are controlled by, or are under common
      control with that entity. For the purposes of this definition,
      "control" means (i) the power, direct or indirect, to cause the
      direction or management of such entity, whether by contract or
      otherwise, or (ii) ownership of fifty percent (50%) or more of the
      outstanding shares, or (iii) beneficial ownership of such entity.

      "You" (or "Your") shall mean an individual or Legal Entity
      exercising permissions granted by this License.

      "Source" form shall mean the preferred form for making modifications,
      including but not limited to software source code, documentation
      source, and configuration files.

      "Object" form shall mean any form resulting from mechanical
      transformation or translation of a Source form, including but
      not limited to compiled object code, generated documentation,
      and conversions to other media types.

      "Work" shall mean the work of authorship, whether in Source or
      Object form, made available under the License, as indicated by a
      copyright notice that is included in or attached to the work
      (an example is provided in the Appendix below).

      "Derivative Works" shall mean any work, whether in Source or Object
      form, that is based on (or derived from) the Work and for which the
      editorial revisions, annotations, elaborations, or other modifications
      represent, as a whole, an original work of authorship. For the purposes
      of this License, Derivative Works shall not include works that remain
      separable from, or merely link (or bind by name) to the interfaces of,
      the Work and Derivative Works thereof.

      "Contribution" shall mean any work of authorship, including
      the original version of the Work and any modifications or additions
      to that Work or Derivative Works thereof, that is intentionally
      submitted to Licensor for inclusion in the Work by the copyright owner
      or by an individual or Legal Entity authorized to submit on behalf of
      the copyright owner. For the purposes of this definition, "submitted"
      means any form of electronic, verbal, or written communication sent
      to the Licensor or its representatives, including but not limited to
      communication on electronic mailing lists, source code control systems,
      and issue tracking systems that are managed by, or on behalf of, the
      Licensor for the purpose of discussing and improving the Work, but
      excluding communication that is conspicuously marked or otherwise
      designated in writing by the copyright owner as "Not a Contribution."

      "Contributor" shall mean Licensor and any individual or Legal Entity
      on behalf of whom a Contribution has been received by Licensor and
      subsequently incorporated within the Work.

    2. Grant of Copyright License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      copyright license to reproduce, prepare Derivative Works of,
      publicly display, publicly perform, sublicense, and distribute the
      Work and such Derivative Works in Source or Object form.

    3. Grant of Patent License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      (except as stated in this section) patent license to make, have made,
      use, offer to sell, sell, import, and otherwise transfer the Work,
      where such license applies only to those patent claims licensable
      by such Contributor that are necessarily infringed by their
      Contribution(s) alone or by combination of their Contribution(s)
      with the Work to which such Contribution(s) was submitted. If You
      institute patent litigation against any entity (including a
      cross-claim or counterclaim in a lawsuit) alleging that the Work
      or a Contribution incorporated within the Work constitutes direct
      or contributory patent infringement, then any patent licenses
      granted to You under this License for that Work shall terminate
      as of the date such litigation is filed.

    4. Redistribution. You may reproduce and distribute copies of the
      Work or Derivative Works thereof in any medium, with or without
      modifications, and in Source or Object form, provided that You
      meet the following conditions:

      (a) You must give any other recipients of the Work or
          Derivative Works a copy of this License; and

      (b) You must cause any modified files to carry prominent notices
          stating that You changed the files; and

      (c) You must retain, in the Source form of any Derivative Works
          that You distribute, all copyright, patent, trademark, and
          attribution notices from the Source form of the Work,
          excluding those notices that do not pertain to any part of
          the Derivative Works; and

      (d) If the Work includes a "NOTICE" text file as part of its
          distribution, then any Derivative Works that You distribute must
          include a readable copy of the attribution notices contained
          within such NOTICE file, excluding those notices that do not
          pertain to any part of the Derivative Works, in at least one
          of the following places: within a NOTICE text file distributed
          as part of the Derivative Works; within the Source form or
          documentation, if provided along with the Derivative Works; or,
          within a display generated by the Derivative Works, if and
          wherever such third-party notices normally appear. The contents
          of the NOTICE file are for informational purposes only and
          do not modify the License. You may add Your own attribution
          notices within Derivative Works that You distribute, alongside
          or as an addendum to the NOTICE text from the Work, provided
          that such additional attribution notices cannot be construed
          as modifying the License.

      You may add Your own copyright statement to Your modifications and
      may provide additional or different license terms and conditions
      for use, reproduction, or distribution of Your modifications, or
      for any such Derivative Works as a whole, provided Your use,
      reproduction, and distribution of the Work otherwise complies with
      the conditions stated in this License.

   5. Submission of Contributions. Unless You explicitly state otherwise,
      any Contribution intentionally submitted for inclusion in the Work
      by You to the Licensor shall be under the terms and conditions of
      this License, without any additional terms or conditions.
      Notwithstanding the above, nothing herein shall supersede or modify
      the terms of any separate license agreement you may have executed
      with Licensor regarding such Contributions.

    6. Trademarks. This License does not grant permission to use the trade
      names, trademarks, service marks, or product names of the Licensor,
      except as required for reasonable and customary use in describing the
      origin of the Work and reproducing the content of the NOTICE file.

    7. Disclaimer of Warranty. Unless required by applicable law or
      agreed to in writing, Licensor provides the Work (and each
      Contributor provides its Contributions) on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
      implied, including, without limitation, any warranties or conditions
      of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
      PARTICULAR PURPOSE. You are solely responsible for determining the
      appropriateness of using or redistributing the Work and assume any
      risks associated with Your exercise of permissions under this License.

    8. Limitation of Liability. In no event and under no legal theory,
      whether in tort (including negligence), contract, or otherwise,
      unless required by applicable law (such as deliberate and grossly
      negligent acts) or agreed to in writing, shall any Contributor be
      liable to You for damages, including any direct, indirect, special,
      incidental, or consequential damages of any character arising as a
      result of this License or out of the use or inability to use the
      Work (including but not limited to damages for loss of goodwill,
      work stoppage, computer failure or malfunction, or any and all
      other commercial damages or losses), even if such Contributor
      has been advised of the possibility of such damages.

    9. Accepting Warranty or Additional Liability. While redistributing
      the Work or Derivative Works thereof, You may choose to offer,
      and charge a fee for, acceptance of support, warranty, indemnity,
      or other liability obligations and/or rights consistent with this
      License. However, in accepting such obligations, You may act only
      on Your own behalf and on Your sole responsibility, not on behalf
      of any other Contributor, and only if You agree to indemnify,
      defend, and hold each Contributor harmless for any liability
      incurred by, or claims asserted against, such Contributor by reason
      of your accepting any such warranty or additional liability.

    END OF TERMS AND CONDITIONS

    APPENDIX: How to apply the Apache License to your work.

      To apply the Apache License to your work, attach the following
      boilerplate notice, with the fields enclosed by brackets "[]"
      replaced with your own identifying information. (Don't include
      the brackets!)  The text should be enclosed in the appropriate
      comment syntax for the file format. We also recommend that a
      file or class name and description of purpose be included on the
      same "printed page" as the copyright notice for easier
      identification within third-party archives.

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
''',
    'unicons': '''
BSD 3-Clause License

Copyright (c) 2020, Pedro Lemos
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
'''
  };
}

/// 隐私政策相关常数
class PrivacyContentConstance {
  /// 协议更新时间
  static const String privacyContentUpdateDate = '更新于 2022 年 11 月 18 日';

  /// 协议内容
  static const String privacyContent = '''
欢迎使用 Cierra_Runis 提供的 Mercurius 软件及服务。

本次 Cierra_Runis 根据最新的《中华人民共和国网络安全法》、《信息安全技术个人信息安全规范》（GB/T 35273-2017）以及其他相关法律法规和技术规范编写了《Mercurius 隐私政策》（以下简称「本政策」），并增加有《未成年人隐私保护声明》。

为了更好的保护您的个人信息，请您仔细阅读本政策，如您对本政策有任何异议或疑问，您可通过本政策第十条中公布的联系方式与 Cierra_Runis 沟通。

一、引言
1. 本政策适用于 Mercurius 安卓端应用程序。
2. 请您在使用 Mercurius 的服务前仔细阅读并充分理解本政策的全部内容。一旦您继续使用 Mercurius 软件及服务，即表示您已经同意 Cierra_Runis 按照本政策使用和处理您的相关信息。
3. Cierra_Runis 会根据相关的法律法规不定时更新本政策，本政策在更新变动后，请确认本政策的新增内容。
4. 请您同意并且理解只有您确认变更后的本政策，Cierra_Runis 才会依据更新变动后的本政策来收集、使用、储存、处理您的个人信息；您有权拒绝更新变更后的本政策。但请您知悉，一旦拒绝同意变更后的本政策将会导致您不能继续完整使用 Mercurius 相关服务和功能。
5. 本政策主要向您说明：
  - Cierra_Runis 收集的信息
  - Cierra_Runis 如何使用这些信息

二、关于 Cierra_Runis
1. Mercurius 由 Cierra_Runis 个人提供产品运营和服务。
2. Cierra_Runis 的基本信息如下：个人网站为 https://github.com/Cierra-Runis 。

三、名词解释
除非另有约定，本政策中使用到的名词，通常仅具有以下定义：

1. 个人信息（出自于GB/T 35273-2017《信息安全技术个人信息安全规范》）
- 是指以电子或者其他方式记录的能够单独或者与其他信息结合识别特定自然人身份或者反映特定自然人活动情况的各种信息。本政策中涉及的个人信息包括自然人的基本资料（包括姓名、生日、性别、住址、电话号码、电子邮箱）、个人身份信息（包括身份证件号码）、个人生物识别信息（包括指纹、面部特征）、网络身份标识信息（包括系统账号、IP地址、邮箱地址以及与前述有关的密码、口令、口令保护答案）、个人财产信息（包括银行账号、口令、交易和消费记录、虚拟货币、虚拟交易、兑换码等虚拟财产信息）、通讯录信息、个人上网记录（包括网站浏览记录、软件使用记录）、个人常用设备信息（包括硬件序列号、硬件型号、设备MAC地址、操作系统类型、软件列表、唯一设备标识符）、个人位置信息（包括大概地理位置、精确定位信息）。
- Cierra_Runis 实际具体收集的个人信息种类以下文描述为准。

2. 个人敏感信息（出自于GB/T 35273-2017《信息安全技术个人信息安全规范》）
- 是指一旦泄露、非法提供或滥用可能危害人身和财产安全，极易导致个人名誉、身心健康受到损害或歧视性待遇等的个人信息。本政策中涉及的个人敏感信息包括您的个人财产信息、个人身份信息（包括身份证件号码）、个人生物识别信息、网络身份标识信息、通讯录信息、精准定位信息、收货地址。
- Cierra_Runis 实际具体收集的个人敏感信息种类以下文描述为准。

3. 设备
- 是指可用于访问 Cierra_Runis 的产品和服务的装置，例如台式计算机、笔记本电脑、平板电脑或智能手机。

4. 唯一设备标识符（专属 ID 或 UUID）
- 是指由设备制造商编入到设备中的一串字符，可用于以独有方式标识相应设备（例如手机的 IMEI 号）。唯一设备标识符有多种用途，其中可在不能使用 Cookie（例如在移动应用程序中）时用以提供广告。

5. IP 地址
- 每台上网的设备都会指定一个编号，称为互联网协议地址（即 IP 地址）。这些编号通常都是根据地理区域指定的。IP 地址通常可用于识别设备连接至互联网时所在的位置。

6. SSL
- SSL（Secure Socket Layer）又称为安全套接层，是在传输通信协议（TCP/IP）上实现的一种安全协议。SSL 支持各种类型的网络，同时提供三种基本的安全服务，均通过使用公开密钥和对称密钥技术以达到信息保密的效果。

7. Cookie
- Cookie是包含字符串的小文件，在您登入和使用网站或其他网络内容时发送、存放在您的计算机、移动设备或其他装置内（通常经过加密）。Cookie同类技术是可用于与Cookie类似用途的其他技术，例如 Web Beacon、Proxy、嵌入式脚本等。

8. 账号
- 当您注册账号并向 Cierra_Runis 提供一些个人信息，您就可以更好的使用 Cierra_Runis 的服务。

9. 去标识化/匿名化
- 是指通过对个人信息的技术处理，使其在不借助额外信息的情况下，无法识别个人信息主体，且处理后的信息不能被复原的过程。

10. 服务器日志
- 通常情况下，Cierra_Runis 的服务器会自动记录您在访问网站时所发出的网页请求。这些服务器日志通常包括您的网络请求、互联网协议地址、浏览器类型、浏览器语言、请求的日期和时间及可以唯一识别您的浏览器的一个或多个 Cookie。

四、Cierra_Runis 收集的信息

1. Cierra_Runis 根据合法、正规、必要的原则，仅收集为了能实现产品功能所需要的必要信息，除此之外 Cierra_Runis 不会收集您的其余信息。

2. Cierra_Runis 主要收集您的个人信息包括两种：
- Cierra_Runis 产品或服务所需要的必要信息，此类信息为产品或服务正常运行的必备信息，您需授权提供 Cierra_Runis 收集。您有权拒绝 Cierra_Runis 收集。但请悉知这会导致您无法使用 Cierra_Runis 的产品或服务。
- 附加功能可能需要用到的信息，此类信息为非核心功能所需要的信息，您可以授权是否授权 Cierra_Runis 采集。如果您拒绝，可能将会导致您享受的服务无法达到 Cierra_Runis 拟达到的效果，但不影响您对核心功能的正常使用。

3. 通常情况下 Cierra_Runis 会在以下场景收集和使用您的个人信息：
- 您在注册账号时所填写的信息。

  例如，您在注册 Mercurius 账号时所填写的邮箱、年龄、性别。

- 您在使用服务时上传的信息。

  例如，头像、用户名等。

  同时，您需理解，手机号码或电子邮箱地址属于您的个人敏感信息，Cierra_Runis 收集该类信息是基于法律法规的相关要求，如您拒绝提供可能导致您无法注册账号并使用相关产品功能，请您谨慎考虑后再选择是否提供。

- 您参加 Cierra_Runis 举办的活动时。

  例如，您参与 Cierra_Runis 线上活动时填写的调查问卷中可能包含您的姓名、电话等信息。

  Cierra_Runis 的部分服务可能需要您提供特定的个人敏感信息来实现特定功能。若您选择不提供该类信息，则可能无法正常使用服务中的特定功能，但不影响您使用服务中的其他功能。若您主动提供您的个人敏感信息，即表示您同意 Cierra_Runis 按本政策所述目的和方式来处理您的个人敏感信息。

- 联系 Cierra_Runis 时。

  例如，您在使用服务中遇见了一些问题需要寻找 Cierra_Runis 来处理，这时您需要提供邮箱、用户名、联系方式等信息。

- 支付过程时。

  例如，当您在 Mercurius 发生支付行为时，需要使用到支付功能。

  在支付过程中，Cierra_Runis 可能会收集您的第三方支付渠道的 user ID （例如支付宝user ID、微信open ID、QQ钱包open ID或银行卡信息）（个人敏感信息）。上述信息为 Cierra_Runis 向您提供您购买商品和（或）服务所必须的信息，Cierra_Runis 无法仅根据该信息获得您的个人财产信息，也不能识别特定自然人身份信息。

- 使用上传服务时。

  例如，您使用了文本上传服务，Cierra_Runis 会把您上传的文本储存在云端，您可以根据需要随时删除在云端的文本，Cierra_Runis 不能泄露用户在云端中上传的文本。

- 为了帮助您更好地使用 Cierra_Runis 的产品或服务时。

  例如，Cierra_Runis 会征求您的授权来获取对于软件的反馈。

五、Cierra_Runis 如何使用这些信息
1. 为了确保服务的安全，帮助 Cierra_Runis 更好地了解 Cierra_Runis 应用程序的运行情况，Cierra_Runis 可能记录相关信息，例如，您使用应用程序的频率、故障信息、总体使用情况、性能数据以及应用程序的来源。Cierra_Runis 不会将 Cierra_Runis 存储在分析软件中的信息与您在应用程序中提供的个人身份信息相结合。
- 产品开发和服务优化，当 Cierra_Runis 的系统出现问题发生故障的时候 Cierra_Runis 会记录和分析故障时产生的信息，优化 Cierra_Runis 的服务。
- Cierra_Runis 会用到您的信息在身份验证上，例如您丢失了您的账号寻找客服人员帮助时，客服人员会使用您在注册账号时填写的信息来对您进行身份验证。
- Cierra_Runis 可能会因为版本的迭代来邀请您参与 Cierra_Runis 的服务调查。

六、信息安全
1. Cierra_Runis 会为您的个人信息安全提供相应的安全保证以防止账号被他人不正当使用，Cierra_Runis 严格遵守法律法规保护用户的私人信息，例如使用加密技术（TLS、SSL等）、匿名化处理等手段来保护您的个人信息。
2. Cierra_Runis 建立了专门的管理制度来确保您的信息安全，例如，Cierra_Runis 会严格限制访问信息的人员范围，要求他们遵守保密义务，并进行审查。如果发生个人信息泄露等安全事件，Cierra_Runis 会启动应急预案阻止事态进一步的加深，并且及时发布公告让您及时了解到事态的进展情况。

七、用户信息
1. 总览
- 您可以通过 Cierra_Runis 的服务分享您的相关信息。需注意的地方是，由于 Mercurius 产品的特性，您在使用过程中匹配的对象信息应自觉遵守相应的法律法规，不得在没有经过他人允许的情况下擅自复制、发布、保存他人的敏感信息。
- 您可以通过设置权限来阻止信息的泄露。但请您注意，这些信息仍可能由其他用户或不受 Cierra_Runis 控制的非关联第三方独立地保存。
- 如您发现 Cierra_Runis 违反法律、行政法规的规定或者双方的约定收集、使用您的个人信息，您可以要求 Cierra_Runis 删除。如您发现 Cierra_Runis 收集、存储的您的个人信息有错误的，您也可以要求 Cierra_Runis 更正。
- 请通过本政策列明的联系方式与 Cierra_Runis 联系。请您理解，由于技术所限、法律或监管要求，Cierra_Runis 可能无法满足您的所有要求，Cierra_Runis 会在合理的期限内答复您的请求。
2. 注销账户
- 如您需要注销账户，请您找到注销入口后，提交注销申请。Mercurius 会审核您所发布过的个人信息，确认无相关争议后完成注销。
- 在注销账户之后，Cierra_Runis 将停止为您提供产品或服务，并依据您的要求，删除您的个人信息，但法律法规另有规定的除外。

八、Cierra_Runis 对未成年人的保护
1. 未成年人使用 Cierra_Runis 的产品与或服务前应取得其监护人的同意。如您为未成年人，在使用 Cierra_Runis 的产品或服务前，应在监护人监护、指导下共同阅读本政策且应在监护人明确同意和指导下使用 Cierra_Runis 的产品或服务、提交个人信息。Cierra_Runis 根据国家相关法律法规的规定保护未成年人的个人信息，只会在法律法规允许、监护人明确同意或保护您的权益所必要的情况下收集、使用或公开披露未成年人的个人信息。
2. 若您是未成年人的监护人，当您对您所监护的未成年人的个人信息有相关疑问时，您可以通过本政策第十条中公示的联系方式与 Cierra_Runis 沟通解决。如果 Cierra_Runis 发现在未事先获得可证实的监护人同意的情况下收集了未成年人的个人信息，则会尽快删除相关数据。

九、适用范围
1. Cierra_Runis 所有的服务都适用于本政策。若本政策与特定服务的隐私指引或声明有不一致之处，请以本政策为准。

十、联系 Cierra_Runis
1. 如您对本政策的内容或使用 Cierra_Runis 的服务时遇到的与隐私保护相关的事宜有任何疑问或进行咨询或投诉时，您均可以通过如下任一方式与 Cierra_Runis 取得联系：
- 您可找到 Mercurius 反馈页面中提交反馈意见
- 您可以写邮件至 byrdsaron@gmail.com
2. Cierra_Runis 会在收到消息的 30 个工作日内回复，但是望您悉知，如果发生和个人信息有关的以下情形，Cierra_Runis 将无法回复您的请求：
- 与国家安全、国防安全有关的；
- 与重大公共利益有关的；
- 与犯罪侦查、起诉和审判等有关的；
- 有充分证据表明您存在恶意行为的；
- 涉及商业秘密的；
- 法律法规等规定的其他情形。
- 对社会可能会造成不良影响的。
''';
}
