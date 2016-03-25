
# Apache Cordova Appaloosa Plugin 

This is a plugin to allow you to use Appaloosa SDK to:

  - Check Update and make user to download new version or let him the choice
  - Use Appaloosa Analytics

Please refer to the [official repository][repoOfficial] to have more information

## Prerequisites
- Android 4.0.3+ (API lvl 15)
- An Enterprise account on Appaloosa Store
- A native store must have been created for your account
- At least one login on the native store


## Installation
Just add the plugin to your app:

```sh
$ cordova plugin add https://github.com/sqli/cordova-plugin-appaloosa.git
```
Save it if you want plugin will be added with `cordova prepare` in the futur

```sh
$ cordova plugin -save
```
## Utilisation
When the plugin will be added in the app, you can access to the APIs in `window.Appaloosa` object.
A sample is available [on this repo][repoSample] HAVE TO BE UPDATED!!

###Initialization
Add the following line at the start of your application
```
 Appaloosa.initialisation(YOUR_APPALOOSA_STORE_ID, YOUR_APPALOOSA_STORE_TOKEN, functionOnSucess,functionOnError);
```

###Authorization
This library provides an app authorization mechanism. Via Appaloosa web admin on https://www.appaloosa-store.com, you can manage a per device access. It works by sending device information to the Appaloosa servers. In case of an offline access to your app, the status is read from a protected file on the device.
```
 Appaloosa.authorization(functionOnSuccess,functionOnError);
```
The twice function have status in parameters. Use it and the ``Appaloosa.status`` to compare return value.

###Analytics

To record analytics on your app usage, simply add the following line at the start of your application. Be careful to be authorized before with `Appaloosa.authorization` function.

```
 Appaloosa.startAnalytics(functionOnSuccess,functionOnError);
```
###Auto-Update
This library allows you to encourage updates by forcing the download of the new update when the application starts. Simply add the following line to your code :

```
 Appaloosa.autoUpdate(functionOnSuccess,functionOnError);
```
If your prefer to leave the choice to the user to download or not the update, the following method will suit your needs :
```
 Appaloosa.autoUpdateWithMessage(title, message, functionOnSuccess,functionOnError);
```


[repoOfficial]: <https://github.com/appaloosa-store/appaloosa-android-tools>
[repoSample]:<https://github.com/appaloosa-store/appaloosa-android-tools>
