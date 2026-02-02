# Bootstrap Script - Single Entry Point Setup

這個 bootstrap 腳本現在可以作為單一入口點，直接從網上下載並執行。

## 🚀 快速開始

### 一鍵安裝

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/soyccan/dotfiles/refs/heads/yadm/.config/yadm/bootstrap)
```

### 自定義配置

您可以通過環境變數自定義設置：

```bash
# 使用不同的 dotfiles repo
DOTFILES_REPO=https://github.com/yourname/dotfiles.git bash <(curl -fsSL ...)

# 使用不同的分支
DOTFILES_BRANCH=main bash <(curl -fsSL ...)

# 組合使用
DOTFILES_REPO=https://github.com/yourname/dotfiles.git \
DOTFILES_BRANCH=main \
bash <(curl -fsSL https://raw.githubusercontent.com/soyccan/dotfiles/refs/heads/yadm/.config/yadm/bootstrap)
```

## 📋 腳本功能

### 1. Bootstrap 階段（自動執行）

腳本會自動完成以下步驟：

1. **檢查並安裝 YADM**
   - Ubuntu/Debian: 從 apt 或 GitHub 安裝
   - macOS: 通過 Homebrew 安裝
   - 其他系統: 從 GitHub 直接下載

2. **克隆 Dotfiles Repository**
   - 使用 `yadm clone` 克隆您的 dotfiles
   - 默認使用 `https://github.com/soyccan/dotfiles.git` (yadm 分支)
   - 如果已經克隆，會執行 `yadm pull` 更新

3. **設置環境**
   - 正確設置 `SCRIPT_DIR` 指向 `~/.config/yadm`
   - 確保所有依賴文件可用

### 2. 安裝階段

根據您的系統安裝軟體包：

**Ubuntu/Debian:**
- 基礎工具: git, curl, wget, unzip
- 開發工具: neovim, fish, fzf, ripgrep, fd-find
- 語言環境: python3, poetry, node
- 終端工具: bat, eza, htop, iftop
- 更多工具...

**macOS:**
- 通過 Homebrew 安裝類似的工具
- 包括 coreutils 等 macOS 特定需求

**跨平台工具:**
- just, lazydocker, lazygit
- starship, zoxide, uv
- pre-commit, ruff, shell-gpt (通過 uv)

### 3. 配置階段

- **Docker**: 將用戶添加到 docker 組
- **Fish Shell**: 設置為默認 shell (僅 Linux)
- **UFW**: 配置防火牆規則 (僅 Ubuntu)

## 🔧 關鍵改進

### 與原版的差異

1. **新增 `bootstrap_yadm()` 函數**
   - 自動安裝 yadm（如果未安裝）
   - 自動克隆 dotfiles repo（如果未克隆）
   - 更新現有的 dotfiles

2. **改進 `install_yadm_bootstrap()` 函數**
   - 支持多種安裝方式
   - macOS 檢查 Homebrew
   - 提供從 GitHub 直接安裝的後備方案

3. **新增 `clone_dotfiles()` 函數**
   - 使用 `yadm clone` 克隆 repo
   - 使用 `--no-bootstrap` 避免循環
   - 自動 checkout 文件

4. **改進 `add_apt_sources()` 函數**
   - 檢查 apt sources 目錄是否存在
   - 優雅處理缺失的自定義源文件
   - 提供有用的日誌信息

## 📁 目錄結構

腳本期望的 dotfiles 結構：

```
~/.config/yadm/
├── bootstrap           # 這個腳本
├── apt/               # Ubuntu APT sources (可選)
│   ├── docker.sources
│   └── ...
└── ...

~/.local/bin/          # 安裝的二進制文件
├── yadm
├── just
├── lazydocker
└── ...
```

## ⚠️ 注意事項

### Ubuntu/Debian
- 某些操作需要 `sudo` 權限
- 第一次運行可能需要輸入密碼
- 建議在乾淨的系統上運行

### macOS
- 需要先安裝 Homebrew
- 不會自動更改默認 shell（需要手動操作）
- 某些包可能需要額外配置

### 通用
- 腳本使用 `set -o errexit`，任何錯誤都會停止執行
- 可以多次運行腳本（會跳過已安裝的包）
- 網絡連接必須穩定（需要下載大量文件）

## 🐛 故障排除

### YADM 安裝失敗
```bash
# 手動安裝 yadm
mkdir -p ~/.local/bin
curl -fsSL https://github.com/TheLocehiliosan/yadm/raw/master/yadm -o ~/.local/bin/yadm
chmod +x ~/.local/bin/yadm
export PATH="$HOME/.local/bin:$PATH"
```

### Dotfiles 克隆失敗
```bash
# 手動克隆
yadm clone https://github.com/soyccan/dotfiles.git --branch yadm --no-bootstrap
yadm checkout -- .
```

### Homebrew 未找到 (macOS)
```bash
# 安裝 Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 🔗 相關連結

- [YADM 文檔](https://yadm.io/)
- [Dotfiles Repository](https://github.com/soyccan/dotfiles)
- [Bootstrap Script Source](https://raw.githubusercontent.com/soyccan/dotfiles/refs/heads/yadm/.config/yadm/bootstrap)

## 📝 開發

### 測試腳本

```bash
# 本地測試
bash ~/.config/yadm/bootstrap

# 或者 source 進來測試單個函數
source ~/.config/yadm/bootstrap
bootstrap_yadm
```

### 更新腳本

```bash
# 編輯後提交到 repo
cd ~/.config/yadm
git add bootstrap
git commit -m "Update bootstrap script"
yadm push
```

## 📜 許可證

根據您的 dotfiles repository 的許可證。
