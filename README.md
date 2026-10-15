# Xu Han — Academic Homepage

基于你选中的 HugoBlox Academic CV 官方模板，目标网址为 https://han030927.github.io/ 。本仓库保存主页源码，并使用 GitHub Actions 自动部署。

## 两种发布方式（任选一种）

### A. 直接上传静态发布包，操作最少

1. 解压 `han030927.github.io-static.zip`。
2. 在 GitHub 创建公开仓库 `han030927.github.io`（如果已有这个仓库，就打开它）。
3. 将解压后的所有文件和文件夹上传到仓库根目录。根目录应直接看到 `index.html`、`.nojekyll`、`css`、`publications`、`pagefind` 等；不要上传 ZIP 本身，也不要多套一层目录。
4. Settings → Pages → Source 选择 **Deploy from a branch**，Branch 选择 **main**，目录选择 **/(root)**，保存。
5. 等待 GitHub Pages 部署完成后访问 https://han030927.github.io/ 。

此方式无需本机安装 Hugo。以后修改源文件后，需要重新构建、上传静态文件。

### B. 上传源码，让 GitHub 自动构建，适合长期维护

1. 解压 `han030927.github.io-hugoblox-source.zip`。
2. 将其中的文件上传到仓库根目录，包含隐藏目录 `.github`，不要混入静态发布包。
3. Settings → Pages → Source 选择 **GitHub Actions**。
4. 推送至 `main` 后，Actions 中的 **Deploy website to GitHub Pages** 会构建并发布。也可以手动 Run workflow。

推送到 main 会触发构建工作流。首次部署前，需要将 Settings → Pages → Source 设置为 GitHub Actions，否则 configure-pages 步骤可能失败。

## 日常修改位置

- 姓名、简介、研究方向、教育经历、邮箱：`data/authors/me.yaml`
- 首页栏目：`content/_index.md`
- 顶部导航：`config/_default/menus.yaml`
- 配色、字体和深浅模式：`config/_default/params.yaml`
- 论文标题、作者、状态、链接：`content/publications/<论文>/index.md`
- 论文图片：相应论文目录内的 `featured.png` 或 `featured.jpg`
- 头像：原图为 `assets/media/authors/me.jpg`；构建时按 `data/authors/me.yaml` 中的 `avatar_crop` 精确裁切。换照片时同步调整或删除裁切参数。
- 网址：`config/_default/hugo.yaml` 中的 `baseURL`

日期同时保留了机器读取的 start/end 和首页展示的 year。修改教育日期时应同步修改两者。没有添加未经提供的专业名称、导师或工作经历。

已去掉 Talks、Courses、News 和所有演示内容。E2E-MPT 的首页卡片和论文详情页均显示 **Under Review**。

## 本地构建与预览

依赖：Hugo **Extended 0.162.0**、Go、Node.js 22、pnpm 10.14.0。

安装前端依赖：

```sh
pnpm install --frozen-lockfile
```

macOS/Linux：

```sh
pnpm run build
hugo server --disableFastRender
```

Windows PowerShell：

```powershell
./scripts/build-windows.ps1
python -m http.server 8765 --bind 127.0.0.1 --directory public
```

然后打开 http://127.0.0.1:8765/ 。停止预览按 Ctrl+C。Windows 构建脚本处理当前 Hugo 对 pnpm 命令入口的识别问题，不改变全局环境配置。

## 模板与素材来源

- 官方模板：https://github.com/HugoBlox/hugo-theme-academic-cv
- 官方演示：https://academic-demo.netlify.app/
- 保留上游 LICENSE.md 和 Hugo Blox 页脚署名。
- E2E-MPT 框架图来自 https://github.com/han030927/E2EMPT 的 assets/Overview.png。
- BPS 框架图来自 https://github.com/han030927/BPS。
- BIP 卡片为自制文字封面，不是论文实验图；头像来自本人提供的海边生活照，构建时只裁切原图。BIP 封面的矢量源文件保存在 design/。
- 论文和研究图仍遵循原论文及仓库的权利声明。

## 本次模板兼容调整

- `layouts/_partials/functions/build_links.html`：修复上游链接去重 scratch map 写入问题。
- `layouts/_partials/views/`：论文框架图完整展示、状态标签、作者及 Paper/arXiv/Code 链接，改进响应式卡片间距。
- `layouts/_partials/hbx/blocks/resume-biography-3/block.html`：首页按钮图标和头像处理。
- 没有升级官方锁定的 Hugo Blox 模块版本。
