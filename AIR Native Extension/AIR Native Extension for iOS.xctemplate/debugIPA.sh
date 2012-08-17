#!/bin/sh

echo "Please provide the complete path of the IPA before building this target"
PATH_TO_IPA="To BE FILLED BEFORE RUNNING THIS TARGET"

IPA_DIR=`/usr/bin/dirname "$PATH_TO_IPA"`
IPA_NAME=`/usr/bin/basename "$PATH_TO_IPA"`
IPA_BASE_NAME=`/usr/bin/basename "$PATH_TO_IPA" .ipa`

echo $IPA_DIR
echo $IPA_NAME
echo $IPA_BASE_NAME

# change to the proper directory
pushd "$IPA_DIR"

# extract the IPA
cp "$IPA_NAME" "$IPA_NAME".zip
unzip -o "$IPA_NAME".zip
rm "$IPA_NAME".zip

# copy the contents of the IPA to the location xcode wants
cp -r Payload/"$IPA_BASE_NAME".app/ "${CONFIGURATION_BUILD_DIR}/${CONTENTS_FOLDER_PATH}/"
cp -r "$IPA_BASE_NAME".app.dSYM "${CONFIGURATION_BUILD_DIR}/${CONTENTS_FOLDER_PATH}/"

# remove the following files and folders to avoid signature errors when installing the app
rm "${CONFIGURATION_BUILD_DIR}/${CONTENTS_FOLDER_PATH}/_CodeSignature/CodeResources"
rmdir "${CONFIGURATION_BUILD_DIR}/${CONTENTS_FOLDER_PATH}/_CodeSignature"
rm "${CONFIGURATION_BUILD_DIR}/${CONTENTS_FOLDER_PATH}/CodeResources"
rm "${CONFIGURATION_BUILD_DIR}/${CONTENTS_FOLDER_PATH}/PkgInfo" 2>/dev/null


# restore working directory
popd


