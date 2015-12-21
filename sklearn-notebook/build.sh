#!/bin/bash
build() {
	ORIGPATH=$(pwd)
	echo " * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
	echo " * * * * * * * * * * Building $1 - andaag/$2 * * * * * * * *"
	echo " * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
	cd $1 || exit 1
	docker build --no-cache -t andaag/$2 . || exit 1
	cd $ORIGPATH || exit 1
}

build python3/base sklearn_notebook3
build python3/large large_notebook3 
build python3/large-mkl large_notebook3_mkl

cat python3/base/Dockerfile  | sed 's:notebook3:notebook2:g' | sed 's:install.sh 3:install.sh 2:g' > python2/base/Dockerfile
cat python3/large/Dockerfile  | sed 's:notebook3:notebook2:g' > python2/large/Dockerfile
cat python3/large-mkl/Dockerfile  | sed 's:notebook3:notebook2:g' > python2/large-mkl/Dockerfile
cp python3/base/req.txt python3/base/install.sh python2/base

build python2/base sklearn_notebook2
build python2/large large_notebook2
build python2/large-mkl large_notebook2_mkl

build python2/caffe caffe

