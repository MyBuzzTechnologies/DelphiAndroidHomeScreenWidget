# DelphiAndroidHomeScreenWidget
A sample project showing how to integrate an Android home screen widget into a Delphi Firemonkey Android project

**Note:** this assumes your Delphi setup uses SDK 29, but if not, change the android-29 to android-28 in the PostBuild property within the project options > Build area within Delphi.

This demonstrates a very simple home screen widget hosted by a Delphi app.
**Note**, the widget is written in Java natively, then the relevant resource files (res folder) and .java files for the widget are deployed with the project.

To build the R.java file and incoporate the resulting object files into the classes.dex, it run a script in the Widget folder during the Post-Build process.

This project was built and tested on Delphi 10.3.3 on Android 11.
**Note**: if you're using Delphi 10.3.3 you will need to see the notes in this page for how to patch it to support Android 11 and SDK 29 first:

https://quality.embarcadero.com/plugins/servlet/mobile#issue/RSP-27218

The widget-hosting solution was found by using this excellent article on the Grijjy Blog:
https://blog.grijjy.com/2017/01/30/embed-facebook-sdk-for-android-in-your-delphi-mobile-app-part-2/

**Note**: There is a known limitation with this solution. It works well if the app is built as an APK, but won't work if you build an AAB (App Bundle). We're investigation this and will post an update to this project once we have figured it out.
