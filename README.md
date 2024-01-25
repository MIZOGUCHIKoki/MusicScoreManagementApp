[![Ruby on Rails CI](https://github.com/MIZOGUCHIKoki/MusicScoreManagementApp/actions/workflows/rubyonrails.yml/badge.svg)](https://github.com/MIZOGUCHIKoki/MusicScoreManagementApp/actions/workflows/rubyonrails.yml)
[![TextLint](https://github.com/MIZOGUCHIKoki/MusicScoreManagementApp/actions/workflows/textlint.yml/badge.svg)](https://github.com/MIZOGUCHIKoki/MusicScoreManagementApp/actions/workflows/textlint.yml)

# Software Engineering 2023 Group4 ([Development documents](https://www.notion.so/kut-se-group4/dir-en-gray-789a9c3b505e4ac3994a1478477590f0?pvs=4)!)
We are **dir-en-gray** in Kochi University of Technology.
Our documents are 

## 👤Contributors
- [OKUHIRA Shunri](https://github.com/OkuhiraShunri)
- [NAKAMURA Yuki](https://github.com/1250352)
- [TANAKA Ryo](https://github.com/tanakaryo341)
- [MIKAMI Shu](https://github.com/MikamiShu)
- [MIZOGUCHI Koki](https://github.com/MIZOGUCHIKoki)
- [YAMADA Koki](https://github.com/1250382KoukiYamada)
- [YAMAMOTO Yoshihiro](https://github.com/1250385-Yamamoto)

# 🧑‍💻Before pushing
Please run following command and check result before pushing to GitHub.
RuboCop is Ruby linter.
```Bash
$ bundle exec rubocop
```
Rails test does unit and integration tests.
```Bash
$ bundle exec rails test
```

# ⚙️Settings
You can install with only follwing command when you have ruby which version is `3.2.2` and your environment is Linux.
```Bash
$ bash env.sh
```
You should type down your password🔑 when you are asked.
When the flow finish, please run the following commands.
```Bash
$ bundle exec rails migrate
```

## 💡Install via bundler
There is bot called [@dependabot](https://github.com/apps/dependabot), which check update of bundler.
When dependabot updates some packages and [@MIZOGUCHIKoki](https://github.com/MIZOGUCHIKoki) merges to `develop` branch, you should execute following command in this repository.
```Bash
$ bundle install --path vendor/bundle
```
# 📃Documents
We can make the PDF of some documents to run following commands.
```Bash
$ lualatex main.tex
$ lualatex main.tex
```
⚠️ DON'T commit and push anything expect `*.tex`, `*.sty`, `*.cls`
## System proposal document
This document is in `docs/systemProposal`.
## External design document
This document is in `docs/externalDesign`.
## Internal design document
This document is in `docs/internalDesing`.
