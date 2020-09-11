REM @echo OFF
@setlocal ENABLEEXTENSIONS
@set JDKPath="C:\Program Files\Java\jdk1.8.0_131\bin"

REM -- SDKAaptPath is passed by Delphi as an expansion of its internal SDKAaptPath variable
@set SDKAaptPath=%3
@echo SDKAaptPath = %SDKAaptPath%

REM -- SDKApiLevelPath is passed by Delphi as an expansion of its internal SDKApiLevelPath variable
@set SDKApiLevelPath=%4
@echo SDKApiLevelPath = %SDKApiLevelPath%

REM -- JavaDxPath is passed by Delphi as an expansion of its internal JavaDxPath variable
@set JavaDxPath=%5
@echo JavaDxPath = %JavaDxPath%

@set HostAppPath=%1\Build

REM -- Delete existing R.java related classes
@rmdir /Q /S %HostAppPath%\Android64\src
@rmdir /Q /S %HostAppPath%\Android64\obj
@mkdir %HostAppPath%\Android64\src
@mkdir %HostAppPath%\Android64\obj
@echo -----------

REM -- Create R.java for resources for Widget
%SDKAaptPath% package -f -m -M %1\Widget\AndroidManifest.xml -I %SDKApiLevelPath% -S %1\Widget\res -J %HostAppPath%\Android64\src

REM -- Copy any additional java files across ready for compilation
copy %1\Widget\src\*.java %HostAppPath%\Android64\src\com\embarcadero\widgettestapp\
@echo -----------

REM -- Compile R.java into R$ classes for Widget
%JDKPath%\javac -verbose -d %HostAppPath%\Android64\obj -classpath %SDKApiLevelPath%;%HostAppPath%\Android64\obj -sourcepath %HostAppPath%\Android64\src %HostAppPath%\Android64\src\com\embarcadero\widgettestapp\*.java
@echo -----------

REM -- Rebuild the classes.dex to include the R$ classes ** must add all the jars in the library and the path to the R$ class files

REM -- Android64 system jar files are in the /android/release folder in the Delphi installation for some reason, so link those in instead
call %JavaDxPath% --dex --verbose --output=%HostAppPath%\Android64\%2\classes.dex "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\android-support-v4.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\cloud-messaging.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-ads-base.17.2.0.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-ads-identifier.16.0.0.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-ads-lite.17.2.0.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-ads.17.2.0.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-analytics-impl.16.0.8.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-analytics.16.0.8.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-base.16.0.1.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-basement.16.2.0.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-gass.17.2.0.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-identity.16.0.0.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-maps.16.1.0.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-measurement-base.16.4.0.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-measurement-sdk-api.16.4.0.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-stats.16.0.1.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-tagmanager-v4-impl.16.0.8.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-tasks.16.0.1.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-android-gms.play-services-wallet.16.0.1.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-firebase.firebase-analytics.16.4.0.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-firebase.firebase-common.16.1.0.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-firebase.firebase-iid-interop.16.0.1.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-firebase.firebase-iid.17.1.1.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-firebase.firebase-measurement-connector.17.0.1.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\com-google-firebase.firebase-messaging.17.5.0.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\fmx.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\google-play-billing.dex.jar" "c:\program files (x86)\embarcadero\studio\20.0\lib\android\release\google-play-licensing.dex.jar" %HostAppPath%\Android64\obj

@echo "Output file is at: %HostAppPath%\Android64\%2\classes.dex"