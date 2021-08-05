# !/bin/bash
echo 'begin commit'
git commit -a
# 保证是npmjs，不能使用国内镜像
npm version patch
npm publish
push tag
push branch