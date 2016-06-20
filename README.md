# Login Screen

![Login](https://github.com/zambur/Login-Screen/blob/master/Examples/LoginExamle.gif)				![Create Account](https://github.com/zambur/Login-Screen/blob/master/Examples/CreateAccountExample.gif)   
**Please note image quality is reduced significantly for .gif format.**   
**The colors and gradients of the application look much better on Apple devices.**   

### Description
This is a sample login screen to be used inside of a mobile app to easily log users into their account. It has many features and animations that make logging in as easy as possible. The back end and user management is handled with Google’s **Firebase** cloud service provider. This handles all login accounts securely storing passwords as well as making sure each account is unique. Since I built this with the intent of append onto another app it will remember logged in users so if you log in and then close the app it will always remember you on that mobile device until you log out. This login also gives users the ability to login or sign up through Facebook, it is registered as a Facebook application so by simply authorizing this app to use your Facebook information you can log in that way. In case you forget your password, users have the ability to reset their password though an email sent to their accounts respected email address.

### Layout
The entire layout of all screens found in the application are positioned with Xcode constraints so no matter what sized Apple device you are viewing this on it will fit to screen size and look the same across all devices.

### Gradient Background
To give the application a color changing gradient I had to first find all the colors that I wanted the background to change through. I did this by writing a separate application that read the Red, Green, Blue (RGB) values of every pixel from a picture that I loaded into it. Once I had enough RGB values I imported those into Swifts UIColor class so I can access them in all classes.
The rest is relatively straight-forward; it is set up as a diagonal gradient that shifts between colors in an array and set to a delay for each color.

### Animations
Animations were fun to work with in this program, well they started out fun and easy until I made all objects have constraints so it can be viewed on all sized devices. When you have at least 4 constraints per object you have to animate each constraint at the same time so the object maintains its shape as it moves across the screen. 

### Install
Locate project directory in terminal and type: `pod install`
