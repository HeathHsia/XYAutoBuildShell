#! /bin/bash

# 计时
SECONDS=0

#脚本设置在与项目相同的路径下,项目默认名为Demo
project_path=$(pwd)

#取当前时间字符串添加到文本结尾
now=$(date +"%Y_%m_%d_%H_%M_%S")
#指定项目的scheme名称
scheme="Demo"
#指定要打包的配置名
configuration="Release"
#指定打包所使用的provisioning profile名称（发布描述文件名称）
provisioning_profile='demo_pro_file'
#指定打包所使用的输出方式 app-store,package ad-hoc enterprise development developer-id
export_method='app-store'

#指定项目地址 非pod集成的项目
project_path="$project_path/Demo.xcodeproj"

#如果是pod集成的项目.xworkspace
#workspace_path="$project_path/Demo.xcodeproj"

#指定输出路径
output_path="$project_path/buildResult"
#指定输出归档文件地址
archive_path="$output_path/build_demo_${now}.xcarchive"
#指定输出ipa地址
ipa_path="$output_path/build_demo_${now}.ipa"
ipa_name="build_demo_${now}.ipa"
optionsSevPlistPath="$project_path/Demo/info.plist"

#输出设置的变量值
echo "************workspace path: ${workspace_path}*********"
echo "************archive path: ${archive_path}*************"
echo "************ipa path: ${ipa_path}*******"
echo "************profile: ${provisioning_profile}******"

#xctool工具打包命令
# clean下xcworkspace
#xctool export -project ${workspace_path} -scheme ${scheme} -configuration ${configuration}
# 根据指定项目，scheme，configuration与输出路径打包出archive文件
#xctool  build -project ${workspace_path} -scheme ${scheme} -configuration ${configuration} -archive ${archive_path}
# 使用指定的provisioning profile导出ipa
# xcodebuild命令进行打包ipa文件
#xcodebuild -exportArchive -archivePath ./${scheme}.xcarchive  -exportPath ${output_path} -exportOptionsPlist ${optionsSevPlistPath}  -allowProvisioningUpdates


#fastlane 打包
fastlane gym --project ${project_path} --scheme ${scheme} --clean --configuration ${configuration} --archive_path ${archive_path} --export_method ${export_method} --output_directory ${output_path} --output_name ${ipa_name}
echo "===upload .ipa to PGYER==="

echo "===== Finished. Total time : ${SECONDS}s==="

#系统通知
osascript -e 'display notification "打包成功" with title "任务完成"'
