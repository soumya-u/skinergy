This application performs image to text transcription and stores this text into a CSV, where it can then be processed appropriately. This application utilizes Firebase, namely the MLKit portion.

<br><br>
Before opening the project, type the following command on your terminal:<br>
<b><i>$ pod install</b></i><br>
This will install the following required pods: <br>
'Firebase/Core', '\~> 5.2.0'
<br>
'Firebase/MLVision', '\~> 5.2.0' 
<br>
'Firebase/MLVisionTextModel', '~> 5.2.0'
<br><br>
Make sure to install cocoapods with the following command:<br>
<b><i>$ sudo gem install cocoapods</b></i><br>
<br>
You would also need to add GoogleService-Info.plist file to your project for firebase integration in order to use MLKit.
Refer <a href="https://console.firebase.google.com/u/1/project/mlkit-in-ios/overview">these </a> easy steps for the same. You will have to login to your gmail account for accessing the console to firebase.
<br>
<br>
<!-- ![textdetect](https://user-images.githubusercontent.com/14230368/41650378-89a77834-749b-11e8-8d25-a72a2eb4b157.gif) -->
