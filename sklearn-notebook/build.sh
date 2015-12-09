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

build python2/base sklearn_notebook2
build python2/large large_notebook2
build python2/large-mkl large_notebook2_mkl

build python2/caffe caffe

build python3/base sklearn_notebook3
build python3/large large_notebook3 
build python3/large-mkl large_notebook3_mkl

