#! /bin/bash

cd /Users/heath/Desktop

#定义变量

name=Heath
echo $name
echo "参数：$*"
echo "参数个数$#"
echo "输入第一个数"
read a
echo "输入第二个数"
read b
echo $(($a + $b))

