vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opt = vim.opt

opt.autowrite = true          -- 自動保存を有効にする
opt.clipboard = "unnamedplus" -- システムのクリップボードと同期
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3          -- 太字や斜体の*マークアップを隠す
opt.confirm = true            -- 変更を保存する前に終了する際に確認する
opt.cursorline = true         -- 現在の行のハイライトを有効にする
opt.expandtab = true          -- タブの代わりにスペースを使用する
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true      -- 大文字小文字を区別しない
opt.inccommand = "nosplit" -- インクリメンタル置換のプレビュー
opt.laststatus = 0
opt.list = true            -- 一部の不可視文字（タブなど）を表示
opt.mouse = "a"            -- マウスモードを有効にする
opt.number = true          -- 行番号を表示
opt.pumblend = 10          -- ポップアップのブレンド
opt.pumheight = 10         -- ポップアップの最大エントリ数
opt.relativenumber = true  -- 相対行番号
opt.scrolloff = 4          -- コンテキストの行数
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true      -- インデントを丸める
opt.shiftwidth = 2         -- インデントのサイズ
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false       -- ステータスラインがあるのでモードを表示しない
opt.sidescrolloff = 8      -- コンテキストの列数
opt.signcolumn = "yes"     -- signcolumnを常に表示する（そうしないとテキストが毎回シフトする）
opt.smartcase = true       -- 大文字がある場合は大文字小文字を区別する
opt.smartindent = true     -- インデントを自動的に挿入する
opt.spelllang = { "en" }
opt.splitbelow = true      -- 新しいウィンドウを現在の下に配置する
opt.splitright = true      -- 新しいウィンドウを現在の右に配置する
opt.tabstop = 2            -- タブがカウントするスペースの数
opt.termguicolors = true   -- True colorサポート
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200               -- スワップファイルを保存し、CursorHoldをトリガーする
opt.wildmode = "longest:full,full" -- コマンドライン補完モード
opt.winminwidth = 5                -- ウィンドウの最小幅
opt.wrap = false                   -- 行の折り返しを無効にする

if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append({ C = true })
end

-- Markdownのインデント設定を修正
vim.g.markdown_recommended_style = 0
