@echo off
chcp 65001 >nul
title 一键上传项目到GitHub（已修复main错误）
color 0A

echo ==============================================
echo          Windows 一键提交到 GitHub
echo              自动：添加+提交+推送
echo ==============================================
echo.

:: ===================== 配置区 =====================
set "GIT_REPO_URL=https://github.com/beautifularticless/Java-Elite-Handbook.git"
set "COMMIT_MSG=自动提交：更新项目文件"
:: ==================================================

echo 正在检查 Git 是否安装...
git --version >nul 2>&1
if errorlevel 1 (
    echo 错误：未检测到 Git，请先安装 Git！
    pause
    exit /b 1
)
echo Git 环境正常。
echo.

:: 初始化仓库
if not exist .git (
    echo 正在初始化本地 Git 仓库...
    git init
    git remote add origin %GIT_REPO_URL%
)

:: 拉取最新
git pull origin main --allow-unrelated-histories >nul 2>&1
git pull origin master --allow-unrelated-histories >nul 2>&1

:: 添加文件
echo 正在添加所有文件...
git add .

:: 提交（关键修复）
echo 正在提交文件...
git commit -m "%COMMIT_MSG%"

:: 强制创建 main 分支（解决你的错误）
git branch -M main

:: 推送
echo 正在推送到 GitHub...
git push -u origin main

echo.
echo ==============================================
echo              上传完成！🎉
echo ==============================================
echo.

pause