---
name: "readme-license-generator"
description: "Generates bilingual (Chinese/English) README and LICENSE files with language switching links and common badges. Invoke when creating a new project or when user needs to add README/LICENSE documentation."
---

# README & LICENSE Generator

This skill generates bilingual (Chinese and English) README and LICENSE files for projects with language switching links, common badges, and standard open-source project structure.

## When to Invoke

- When creating a new project that needs README and LICENSE files
- When user explicitly requests to generate README and LICENSE documentation
- When initializing a project with proper documentation structure
- When user wants to add bilingual support to existing project documentation

## Workflow

### Step 1: Gather Project Information

Ask the user for the following information:

1. **Project name** (项目名称)
2. **Project description** (项目描述) - brief description in both languages
3. **License type** (许可证类型) - choose from:
   - **MIT License** (MIT许可证)
   - **Apache License 2.0** (Apache 2.0许可证)
   - **GNU General Public License v3.0** (GPL v3.0许可证)
   - **BSD 3-Clause License** (BSD 3-Clause许可证)
   - **Mozilla Public License 2.0** (MPL 2.0许可证)
   - **Creative Commons Zero v1.0 Universal** (CC0许可证)
   - **Proprietary/Custom License** (私有/自定义许可证)
   - Other (specify)

4. **Additional information** (optional):
   - Author name (作者姓名)
   - Repository URL (仓库地址)
   - Documentation URL (文档地址)
   - Project website (项目网站)
   - Build status badge URL (构建状态徽章URL)
   - Coverage badge URL (覆盖率徽章URL)
   - Version badge URL (版本徽章URL)
   - License badge URL (许可证徽章URL)
   - Other custom badges (其他自定义徽章)

### Step 2: Generate README.md

Create a `README.md` file with the following structure:

```markdown
# Language Links / 语言链接

[English](#english) | [中文](#chinese)

---

<a name="english"></a>
# [Project Name]

[Brief project description in English]

## Badges

[Insert relevant badges here]

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Features

[List key features]

## Installation

```bash
[Installation commands]
```

## Usage

```bash
[Usage examples]
```

## Documentation

For more detailed documentation, please visit [Documentation URL](link).

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License

This project is licensed under the [License Name] - see the [LICENSE](LICENSE) file for details.

## Contact

- Author: [Author Name]
- Repository: [Repository URL]
- Issues: [Issues URL]

---

<a name="chinese"></a>
# [项目名称]

[项目中文描述]

## 徽章

[插入相关徽章]

## 目录

- [功能特性](#功能特性)
- [安装](#安装)
- [使用](#使用)
- [文档](#文档)
- [贡献](#贡献)
- [许可证](#许可证)
- [联系方式](#联系方式)

## 功能特性

[列出主要功能]

## 安装

```bash
[安装命令]
```

## 使用

```bash
[使用示例]
```

## 文档

更多详细文档，请访问 [文档地址](link)。

## 贡献

欢迎贡献！请阅读 [CONTRIBUTING.md](CONTRIBUTING.md) 了解详情。

## 许可证

本项目采用 [许可证名称] 许可证 - 详情请参阅 [LICENSE](LICENSE) 文件。

## 联系方式

- 作者: [作者姓名]
- 仓库: [仓库地址]
- 问题: [问题地址]
```

### Step 3: Generate LICENSE File

Create a `LICENSE` file based on the selected license type:

#### MIT License Template:

```
MIT License

Copyright (c) [Year] [Author Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

#### Apache License 2.0 Template:

```
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

   Copyright [Year] [Author Name]

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
```

#### GPL v3.0 Template:

```
GNU GENERAL PUBLIC LICENSE
Version 3, 29 June 2007

Copyright (C) [Year] [Author Name]

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

The full text of the GNU General Public License v3.0 can be found at:
https://www.gnu.org/licenses/gpl-3.0.txt
```

#### BSD 3-Clause Template:

```
BSD 3-Clause License

Copyright (c) [Year], [Author Name]
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
```

#### MPL 2.0 Template:

```
Mozilla Public License Version 2.0
==================================

1. Definitions
--------------

1.1. "Contributor"
    means each individual or legal entity that creates, contributes to
    the creation of, or owns Covered Software.

1.2. "Contributor Version"
    means the combination of the Contributions of others (if any) used
    by a Contributor and that particular Contributor's Contribution.

1.3. "Contribution"
    means Covered Software of a particular Contributor.

1.4. "Covered Software"
    means Source Code Form to which the initial Contributor has attached
    the notice in Exhibit A, the Executable Form of such Source Code
    Form, and Modifications of such Source Code Form, in each case
    including portions thereof.

1.5. "Incompatible With Secondary Licenses"
    means

    (a) that the initial Contributor has attached the notice described
        in Exhibit B to the Covered Software; or

    (b) that the Covered Software was made available under the terms of
        version 1.1 or earlier of the License, but not also under the
        terms of a Secondary License.

1.6. "Executable Form"
    means any form of the work other than Source Code Form.

1.7. "Larger Work"
    means a work that combines Covered Software with other material, in
    a separate file or files, that is not Covered Software.

1.8. "License"
    means this document.

1.9. "Licensable"
    means having the right to grant, to the maximum extent possible,
    whether at the time of the initial grant or subsequently, any and
    all of the rights conveyed by this License.

1.10. "Modifications"
    means any of the following:

    (a) any file in Source Code Form that results from an addition to,
        deletion from, or modification of the contents of Covered
        Software; or

    (b) any new file in Source Code Form that contains any Covered
        Software.

1.11. "Patent Claims" of a Contributor
    means any patent claim(s), including without limitation, method,
    process, and apparatus claims, in any patent Licensable by such
    Contributor that would be infringed, but for the grant of the
    License, by the making, using, selling, offering for sale, having
    made, import, or transfer of either its Contributions or its
    Contributor Version.

1.12. "Secondary License"
    means either the GNU General Public License, Version 2.0, the GNU
    Lesser General Public License, Version 2.1, the GNU Affero General
    Public License, Version 3.0, or any later versions of those
    licenses.

1.13. "Source Code Form"
    means the form of the work preferred for making modifications.

1.14. "You" (or "Your")
    means an individual or a legal entity exercising rights under this
    License. For legal entities, "You" includes any entity that
    controls, is controlled by, or is under common control with You. For
    purposes of this definition, "control" means (a) the power, direct
    or indirect, to cause the direction or management of such entity,
    whether by contract or otherwise, or (b) ownership of more than
    fifty percent (50%) of the outstanding shares or beneficial
    ownership of such entity.

2. License Grants and Conditions
---------------------------------

2.1. Grants

Each Contributor hereby grants You a world-wide, royalty-free,
non-exclusive license:

(a) under intellectual property rights (other than patent or trademark)
    Licensable by such Contributor to use, reproduce, make available,
    modify, display, perform, distribute, and otherwise exploit its
    Contributions, either on an unmodified basis, with Modifications, or
    as part of a Larger Work; and

(b) under Patent Claims of such Contributor to make, use, sell, offer
    for sale, have made, import, and otherwise transfer either its
    Contributions or its Contributor Version.

2.2. Effective Date

The licenses granted in Section 2.1 with respect to any Contribution
become effective for each Contribution on the date the Contributor first
distributes such Contribution.

2.3. Limitations on Grant Scope

The licenses granted in this Section 2 are the only rights granted under
this License. No additional rights or licenses will be implied from the
distribution or licensing of Covered Software under this License.
Notwithstanding Section 2.1(b) above, no patent license is granted by a
Contributor:

(a) for any code that a Contributor has removed from Covered Software;
    or

(b) for infringements caused by: (i) Your and any other third party's
    modifications of Covered Software, or (ii) the combination of its
    Contributions with other software (except as part of its Contributor
    Version); or

(c) under Patent Claims infringed by Covered Software in the absence of
    its Contributions.

This License does not grant any rights in the trademarks, service marks,
or logos of any Contributor (except as may be necessary to comply with
the notice requirements in Section 3.4).

2.4. Subsequent Licenses

No Contributor makes additional grants as a result of Your choice to
distribute the Covered Software under a subsequent version of this
License (see Section 10.2) or under the terms of a Secondary License (if
permitted under the terms of Section 3.3).

2.5. Representation

Each Contributor represents that the Contributor believes its
Contributions are its original creation(s) or it has sufficient rights
to grant the rights to its Contributions conveyed by this License.

2.6. Fair Use

You may make, use, sell, offer for sale, have made, import, and otherwise
transfer Covered Software, provided that You comply with all conditions
of this License.

3. Responsibilities
-------------------

3.1. Distribution of Source Form

All distribution of Covered Software in Source Code Form, including any
Modifications that You create or to which You contribute, must be under
the terms of this License. You must inform recipients that the Source
Code Form of the Covered Software is governed by the terms of this
License, and how they can obtain a copy of this License. You may not
attempt to alter or restrict the recipients' rights in the Source Code
Form.

3.2. Distribution of Executable Form

If You distribute Covered Software in Executable Form then:

(a) such Covered Software must be accompanied by the Corresponding
    Source, which must be distributed under the terms of this License; or

(b) the Covered Software must be accompanied by a notice stating that
    the Source Code is available and information on how to obtain it.

3.3. Distribution of a Larger Work

You may create and distribute a Larger Work under terms of Your choice,
provided that You also comply with the requirements of this License for
the Covered Software. If the Larger Work includes a "NOTICE" text file
as part of its distribution, then any Covered Software must include the
readable attribution notices contained within such NOTICE file, excluding
those notices that do not pertain to any part of the Covered Software
in the Larger Work. You may add Your own attribution notices within
Derivative Works that You distribute.

3.4. Notices

You may not remove or alter the substance of any license notices
(including copyright notices, patent notices, disclaimers of warranty,
or limitations of liability) contained within the Covered Software, or
remove any patent, trademark, or attribution notices from the Source
Code Form.

4. Inability to Comply Due to Statute or Regulation
---------------------------------------------------

If it is impossible for You to comply with any of the terms of this
License with respect to some or all of the Covered Software due to
statute, judicial order, or regulation, then You must: (a) comply with
the terms of this License to the maximum extent possible; and (b)
describe the limitations and the code they affect. Such description must
be placed in a text file included with all distributions of the Covered
Software.

5. Termination
--------------

5.1. The rights granted under this License will terminate automatically
if You fail to comply with any of its terms. However, if You become
compliant, then the rights granted by Contributor for that particular
Contributor are reinstated (a) provisionally, unless and until such
Contributor explicitly and finally terminates Your grants, and (b) on an
ongoing basis, if such Contributor fails to notify You of the
non-compliance by some reasonable means prior to 60 days after You have
come back into compliance.

5.2. If You initiate litigation against any entity by asserting a patent
infringement claim (excluding declaratory judgment actions,
counter-claims, and cross-claims) alleging that such Covered Software
constitutes direct or contributory patent infringement, then any rights
granted to You by this License for that Covered Software shall terminate.

6. Disclaimer of Warranty
-------------------------

Unless required by applicable law or agreed to in writing, Licensor
provides the Covered Software on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied, including, without
limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT,
MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE. You are solely
responsible for determining the appropriateness of using or
redistributing the Covered Software and assume any risks associated
with Your exercise of permissions under this License.

7. Limitation of Liability
---------------------------

Under no circumstances and under no legal theory, whether in tort
(including negligence), contract, or otherwise, unless required by
applicable law (such as deliberate and grossly negligent acts) or agreed
to in writing, shall any Contributor be liable to You for damages,
including any direct, indirect, special, incidental, or consequential
damages of any character arising as a result of this License or out of
the use or inability to use the Covered Software (including but not
limited to damages for loss of goodwill, work stoppage, computer failure
or malfunction, or any and all other commercial damages or losses), even
if such Contributor has been advised of the possibility of such damages.

8. Miscellaneous
----------------

This License and the rights granted hereunder shall be governed by and
construed in accordance with the laws of the jurisdiction in which the
Licensor resides.

Exhibit A - Source Code Form License Notice
-------------------------------------------

This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at https://mozilla.org/MPL/2.0/.

Exhibit B - "Incompatible With Secondary Licenses" Notice
---------------------------------------------------------

This Source Code Form is "Incompatible With Secondary Licenses", as
defined by the Mozilla Public License, v. 2.0.

Copyright [Year] [Author Name]
```

#### CC0 Template:

```
Creative Commons Legal Code

CC0 1.0 Universal

    CREATIVE COMMONS CORPORATION IS NOT A LAW FIRM AND DOES NOT PROVIDE
    LEGAL SERVICES. DISTRIBUTION OF THIS DOCUMENT DOES NOT CREATE AN
    ATTORNEY-CLIENT RELATIONSHIP. CREATIVE COMMONS PROVIDES THIS
    INFORMATION ON AN "AS-IS" BASIS. CREATIVE COMMONS MAKES NO WARRANTIES
    REGARDING THE USE OF THIS DOCUMENT OR THE INFORMATION OR WORKS
    PROVIDED HEREUNDER, AND DISCLAIMS LIABILITY FOR DAMAGES RESULTING
    FROM THE USE OF THIS DOCUMENT OR THE INFORMATION OR WORKS PROVIDED
    HEREUNDER.

Statement of Purpose

The laws of most jurisdictions throughout the world automatically confer
exclusive Copyright and Related Rights (defined below) upon the creator
and subsequent owner(s) (each and all, an "owner") of an original work of
authorship and/or a database (each, a "Work").

Certain owners wish to permanently relinquish those rights to a Work for
the purpose of contributing to a commons of creative, cultural and
scientific works ("Commons") that the public can reliably and without fear
of later claims of infringement build upon, modify, incorporate in other
works, reuse and redistribute as freely as possible in any form whatsoever
and for any purposes, including without limitation commercial purposes.
These owners may contribute to the Commons to promote the ideal of a free
culture and the further production of creative, cultural and scientific
works, or to gain reputation or greater distribution for their Work in
part through the use and efforts of others.

For these and/or other purposes and motivations, and without any
expectation of additional consideration or compensation, the person
associating CC0 with a Work (the "Affirmer"), to the extent that he or she
is an owner of Copyright and Related Rights in the Work, voluntarily
elects to apply CC0 to the Work and publicly distribute the Work under its
terms, with knowledge of his or her Copyright and Related Rights in the
Work and the meaning and intended legal effect of CC0 on those rights.

1. Copyright and Related Rights.
A Work made available under CC0 may be protected by copyright and related
or neighboring rights ("Copyright and Related Rights"). Copyright and
Related Rights include, but are not limited to, the following:

  i. the right to reproduce, adapt, distribute, perform, display,
     communicate, and translate a Work;
 ii. moral rights retained by the original author(s) and/or performer(s);
iii. publicity and privacy rights pertaining to a person's image or
     likeness depicted in a Work;
 iv. rights protecting against unfair competition in regards to a Work,
     subject to the limitations in paragraph 4(a), below;
  v. rights protecting the extraction, dissemination, use and reuse of data
     in a Work;
 vi. database rights (such as those arising under Directive 96/9/EC of the
     European Parliament and of the Council of 11 March 1996 on the legal
     protection of databases, and under any national implementation
     thereof, including any amended or successor version of such
     directive); and
vii. other similar, equivalent or corresponding rights throughout the
     world based on applicable law or treaty, and any national
     implementations thereof.

2. Waiver.
To the greatest extent permitted by, but not in contravention of,
applicable law, Affirmer hereby overtly, fully, permanently,
irrevocably and unconditionally waives, abandons, and surrenders all of
Affirmer's Copyright and Related Rights and associated claims and causes
of action, whether now known or unknown (including existing as well as
future claims and causes of action), in the Work (i) in all territories
worldwide, (ii) for the maximum duration provided by applicable law or
treaty (including future time extensions), (iii) in any current or future
medium and for any number of copies, and (iv) for any purpose whatsoever,
including without limitation commercial, advertising or promotional
purposes (the "Waiver"). Affirmer makes the Waiver for the benefit of
each member of the public at large and to the detriment of Affirmer's
heirs and successors, fully intending that such Waiver shall not be
subject to revocation, rescission, cancellation, termination, or any other
legal or equitable action to disrupt the quiet enjoyment of the Work by
the public as contemplated by Affirmer's express Statement of Purpose.

3. Public License Fallback.
Should any part of the Waiver for any reason be judged legally invalid
or ineffective under applicable law, then the Waiver shall be preserved
to the maximum extent permitted taking into account Affirmer's express
Statement of Purpose. In addition, to the extent the Waiver is so judged
Affirmer hereby grants to each affected person a royalty-free, non
transferable, non sublicensable, non exclusive, irrevocable and
unconditional license to exercise Affirmer's Copyright and Related
Rights in the Work (i) in all territories worldwide, (ii) for the maximum
duration provided by applicable law or treaty (including future time
extensions), (iii) in any current or future medium and for any number of
copies, and (iv) for any purpose whatsoever, including without limitation
commercial, advertising or promotional purposes (the "License"). The
License shall be deemed effective as of the date CC0 was applied by
Affirmer to the Work. Should any part of the License for any reason be
judged legally invalid or ineffective under applicable law, such partial
invalidity or ineffectiveness shall not invalidate the remainder of the
License, and in such case Affirmer hereby affirms that he or she will not
(i) exercise any of his or her remaining Copyright and Related Rights in
the Work or (ii) assert any associated claims and causes of action with
respect to the Work, in either case contrary to Affirmer's express
Statement of Purpose.

4. Limitations and Disclaimers.

 a. No trademark or patent rights held by Affirmer are waived, abandoned,
    surrendered, licensed or otherwise affected by this document.
 b. Affirmer offers the Work as-is and makes no representations or
    warranties of any kind concerning the Work, express, implied,
    statutory or otherwise, including without limitation warranties of
    title, merchantability, fitness for a particular purpose, non
    infringement, or the absence of latent or other defects, accuracy, or
    the present or absence of errors, whether or not discoverable, all to
    the greatest extent permissible under applicable law.
 c. Affirmer disclaims all liability to the greatest extent permitted by
    applicable law, for any direct, indirect or consequential loss or
    damage arising from the use of the Work, including without limitation
    loss of goodwill, work stoppage, computer failure or malfunction, or
    any and all other commercial damages or losses.
 d. Affirmer is not obligated to provide support, maintenance, updates,
    or new releases of the Work.
 e. The Work is provided "as is", without any express or implied
    warranties, conditions or representations. You assume all risks
    associated with the use of the Work.

For more information, please see
<https://creativecommons.org/publicdomain/zero/1.0/>

Copyright [Year] [Author Name]
```

#### Proprietary/Custom License Template:

```
PROPRIETARY LICENSE AGREEMENT

Copyright (c) [Year] [Author Name]

This software and associated documentation files (the "Software") are
proprietary and confidential. All rights reserved.

Permission is hereby granted, subject to the terms and conditions of this
license, to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

1. The above copyright notice and this permission notice shall be included
   in all copies or substantial portions of the Software.

2. The Software may not be redistributed, sublicensed, or made available
   to third parties without express written permission from the copyright
   holder.

3. The Software is provided "AS IS", WITHOUT WARRANTY OF ANY KIND,
   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

4. Any modifications or derivative works based on this Software must
   prominently display this license and the original copyright notice.

5. The copyright holder reserves all rights not expressly granted in this
   license.

For inquiries regarding licensing, please contact [Contact Information].
```

### Step 4: Common Badges

Include the following common badges in the README:

#### Build Status:
- GitHub Actions: `![GitHub Actions](https://github.com/[username]/[repo]/actions/workflows/[workflow].yml/badge.svg)`
- Travis CI: `![Travis CI](https://travis-ci.org/[username]/[repo].svg?branch=main)`
- CircleCI: `![CircleCI](https://circleci.com/gh/[username]/[repo].svg?style=shield)`

#### Code Quality:
- Codecov: `![Codecov](https://codecov.io/gh/[username]/[repo]/branch/main/graph/badge.svg)`
- Coveralls: `![Coveralls](https://coveralls.io/repos/github/[username]/[repo]/badge.svg?branch=main)`
- CodeClimate: `![CodeClimate](https://codeclimate.com/github/[username]/[repo]/badges/gpa.svg)`

#### Version:
- npm: `![npm](https://img.shields.io/npm/v/[package-name])`
- PyPI: `![PyPI](https://img.shields.io/pypi/v/[package-name])`
- GitHub Release: `![GitHub release](https://img.shields.io/github/release/[username]/[repo])`

#### License:
- `![License](https://img.shields.io/badge/license-[license]-blue.svg)`

#### Downloads:
- npm: `![npm](https://img.shields.io/npm/dm/[package-name])`
- PyPI: `![PyPI](https://img.shields.io/pypi/dm/[package-name])`

#### Other:
- `![GitHub issues](https://img.shields.io/github/issues/[username]/[repo])`
- `![GitHub stars](https://img.shields.io/github/stars/[username]/[repo])`
- `![GitHub forks](https://img.shields.io/github/forks/[username]/[repo])`
- `![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)`

### Step 5: Integration with Project Creation

When this skill is invoked during project creation:

1. Ask for all required information (project name, description, license type, etc.)
2. Generate README.md with bilingual content and language switching links
3. Generate LICENSE file with the appropriate license text
4. Place both files in the project root directory
5. Optionally create additional documentation files like:
   - CONTRIBUTING.md (贡献指南)
   - CHANGELOG.md (变更日志)
   - CODE_OF_CONDUCT.md (行为准则)

## Examples

### Example 1: Basic Usage

User: "Create README and LICENSE for my new project"

Assistant: "I'll help you create README and LICENSE files for your project. Please provide the following information:
1. Project name
2. Project description (in both Chinese and English)
3. License type (MIT, Apache 2.0, GPL v3.0, BSD 3-Clause, MPL 2.0, CC0, or Proprietary)
4. Author name
5. Repository URL (optional)
6. Any additional badges you'd like to include (optional)"

### Example 2: With Custom Badges

User: "Create README for my project with build status and coverage badges"

Assistant: "I'll create a README with custom badges. Please provide:
1. Project name and description
2. License type
3. GitHub Actions workflow name (for build status badge)
4. Codecov repository name (for coverage badge)
5. Author and repository information"

## Notes

- Always ensure the language switching links work correctly
- Maintain consistency between Chinese and English versions
- Update badges with actual URLs when available
- Keep the README structure clean and easy to navigate
- Include appropriate contact information and links
