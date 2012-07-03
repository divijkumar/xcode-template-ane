xcode-template-ane
==================

This repository contains an XCode template that can be used to create AIR native extensions or ANEs for iOS from within XCode.

Using XCode templates for creating ANEs for iOS
===============================================

In AIR 3, Adobe introduced Native Extensions which provides Flash & AIR developers the capability to extend the AIR runtime. The native extensions mechanism allows one to write native code, wrap it with an ActionScript API and then use it with the rest of the ActionScript code inside of an AIR app.

Some background about Native Extensions
---------------------------------------

The following Adobe devnet articles are extremely useful if you want to know more about Native Extensions.

http://www.adobe.com/devnet/air/native-extensions-for-air.html

http://www.adobe.com/devnet/air/articles/developing-native-extensions-air.html

http://www.adobe.com/devnet/air/articles/extending-air.html

One of the problems faced by developers working on native extensions, is that creating a native extension involves too many steps and there is no seamless integration with the native IDE (which is XCode for iOS AIR Native Extensions).

Here, I am providing an XCode4 project template for iOS that helps Flash developers in getting started with writing native extensions.

Before I begin, let me re-iterate that for writing an AIR application that uses a native extension one needs to create the following.

1. An ActionScript library (or swc) which contains the ActionScript code which calls into the native code.
2. The native code: On iOS one needs to create a CocoaTouch static library containing the native code which is then combined with the SWC (in step 1) and packaged into an ANE (AIR Native Extension) using the ADT tool.
3. The AIR app which uses the ANE generated in step 2.

This XCode4 project template for creating ANEs for iOS will ease step 2.

Installing and using the ANE XCode Project template
---------------------------------------------------

Please ensure that you have XCode4 with iOS5 installed. Also its preferable to close XCode now.

1. In the attached zip (AIR Native Extension.zip) there is a bash script "install_templates.sh". From the command line:

    $ ./install_templates.sh
This will copy the XCode4 project templates for creating AIR Native Extensions for iOS to the relevant folder in the user's home directory, from where XCode will load them when launched.
2. Now launch XCode, click File->New->New Project (Command+Shift+N). You would see a new entry for "AIR Native Extension" under iOS:
[[AIR Native Extension/screenshots/new_project.png]]
3. Click Next and you would see the following options for configuring the XCode project.
[[AIR Native Extension/screenshots/options.png]]
*    The first field is the name of the extension.
*    The second field is a company prefix.
*    The third field is a static field containing the extension identifier which is formed by combining the first and second fields. Please note that the extension identifier mentioned here should be the same as the one specified in the application descriptor of the AIR app that will use this ANE.
*    The fourth field is the complete path to the AIR SDK. (Please ensure that you provide a complete path, without any "~" for HOME dir). The path provided here should be such that, <path_to_AIR_sdk>/bin/adt exists. There is a small quirk that you'd notice here. Even though you provide the complete path to the AIR sdk, the initial "/" vanishes as soon as you tab out of this field. This will be taken care of, so you may safely ignore this.
*    The fifth field is the complete path to the SWC or the ActionScript library file. This is essentially the ActionScript part of your native extension. Here again as soon as you tab out of this field, the initial "/" will vanish. You may ignore this safely.
4. Click Next and you would be asked to select a folder where you want to create your XCode project and keep your native code.
5. Click Next and XCode would create a project for you.
[[AIR Native Extension/screenshots/created_project.png]]


Understanding the generated project ...
---------------------------------------

The project file that is generated contains a source file, a header file and a few supporting files. Lets go over the Project files one by one.

*	Source and Header file: These contain four basic functions namely ExtInitializer, ExtFinalizer, ContextInitializer and ContextFinalizer. These functions are needed for any ANE which the template has already done for you. There is also a fifth function "IsSupported". This is being provided purely to help you get started with writing and exposing native functions that can be called from ActionScript.
*	extension.xml: This file contains the extension identifier and the extension's initialize (ExtInitializer)and finalize (ExtFinalizer) functions.
*	generateANE.sh: As the name suggests, this script is used to generate the ANE file.
* 	platformoptions.xml: More about this later.
* 	Targets: The project contains two targets namely, PACKAGENAME and PACKAGENAME.ane. The first target creates a static library. The second one generates an ANE, by internally invoking the ADT command and uses the static library, extension.xml and the native extension SWC.
For the Debug configuration, the ANE file will be generated in $HOME/Library/Developer/XCode/DerivedData/PROJECTNAME-xxxxxxxxxxxxxxxxxxxxxxxxxxx/Build/Products/Debug-iphoneos/

This ANE may now be used in your AIR app. You may read more on how to do this at 
http://help.adobe.com/en_US/air/extensions/WSf268776665d7970d-2e74ffb4130044f3619-7fff.html#WSdb11516da818ea8d49ce0fe713341ed67cf-7fff 

Specifying additional linker options ...
----------------------------------------
When you write your ANE and link it in your AIR app, the toolchain provided as part of the AIR SDK by default links the ANE against some of the iOS frameworks. However, if your native code needs to link against a framework that is not included in the default list, then you would see a linker error when you try to create your AIR app. You can specify additional linker options via the platformoptions.xml file while creating you ANE. Please refer here for more details.


I hope you find the xcode project template for ANEs on iOS useful and it helps in making the process of writing ANEs simpler for you.

