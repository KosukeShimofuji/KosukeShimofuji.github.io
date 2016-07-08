#!/bin/sh

BUILD_DIR="/tmp/_build_jekyll"
REPO="git@github.com:KosukeShimofuji/KosukeShimofuji.github.io.git"

jekyll build
mkdir -p $BUILD_DIR
git init $BUILD_DIR 
cp -r _site/* $BUILD_DIR
cd $BUILD_DIR
git remote add origin $REPO
git add -A 
git commit -m "Publish Home Page"
git push origin master -f
rm -fr $BUILD_DIR

