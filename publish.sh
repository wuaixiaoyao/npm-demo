#!/usr/bin/env sh

# 发生任何错误时终止
set -e

# 选择版本号
VERSION=$(select-version-cli)
read -p "Releasing $VERSION - are you sure? (y/n)" -n 1 -r
echo # (optional) 空行

if [[ $REPLY =~ ^[Yy]$ ]]; then

    npm version $VERSION --message "[release] $VERSION"

    # changelog
    yarn changelog
    # commmit
    echo '====== begin commit ========='
    git add -A
    git commit -m "[build] $VERSION"

    # publish
    echo '======== begin publish ======='
    echo $VERSION
    npm publish

    # push
    echo '===== begin push ======'
    git push origin develop
    git checkout master
    git rebase develop
    git push origin master
    git checkout develop
    # push tag
    git push origin v$VERSION
    echo '====== push end ======'

else
    echo '请选择版本号'

fi
