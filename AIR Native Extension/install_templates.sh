#!/bin/bash

echo 'Installing project template for AIR Native Extensions (ANE) for iOS'

BASE_TEMPLATE_PATH="$HOME/Library/Developer/Xcode/Templates"
PROJECT_TEMPLATE_DST_DIR="$BASE_TEMPLATE_PATH/Project Templates/AIR Native Extension/"

force=
forceCopy=
uninstall=

usage(){
cat << EOF
usage: $0 [options]
 
Install/update project templates for AIR Native Extension
 
OPTIONS:
   -f	force overwrite if a previous version of the AIR Native Extension project templates exist
   -h	this help
   -u	uninstall Xcode 4 AIR Native Extension project templates. (CAUTION: This removes everything in "$PROJECT_TEMPLATE_DST_DIR". Use with extreme care)
EOF
}

while getopts "fhu" OPTION; do
	case "$OPTION" in
		f)
			force=1
			forceCopy="-f"
			;;
		h)
			usage
			exit 0
			;;
		u)
			uninstall=1
			;;
	esac
done

uninstall_xcode4_ane_project_templates(){
	if [[ -d $PROJECT_TEMPLATE_DST_DIR ]];  then
		echo "Removing project templates: \"${PROJECT_TEMPLATE_DST_DIR}\""
		rm -rf "$PROJECT_TEMPLATE_DST_DIR"
	fi
}

install_xcode4_ane_project_templates(){
	if [[ -d "$PROJECT_TEMPLATE_DST_DIR" ]];  then
		if [[ $force ]]; then
			echo "Overwriting the files in: \"${PROJECT_TEMPLATE_DST_DIR}\""
		else
			echo "Project templates already installed. To force a re-install use the '-f' parameter."
			exit 1
		fi
	else
		echo "Creating destination directory: \"${PROJECT_TEMPLATE_DST_DIR}\"..."
		mkdir -p "$PROJECT_TEMPLATE_DST_DIR"
	fi

	echo "Copying Project Templates..."
	cp -r $forceCopy "./AIR Native Extension for iOS.xctemplate" "$PROJECT_TEMPLATE_DST_DIR"
	cp -r $forceCopy "./Basic.xctemplate" "$PROJECT_TEMPLATE_DST_DIR"
	cp -r $forceCopy "./iOSBasic.xctemplate" "$PROJECT_TEMPLATE_DST_DIR"
}


if [[ $uninstall ]]; then
	uninstall_xcode4_ane_project_templates
else
	install_xcode4_ane_project_templates

fi



