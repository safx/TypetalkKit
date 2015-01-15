# TypetalkKit

[![TravisCI](http://img.shields.io/travis/safx/TypetalkKit.svg?style=flat)](https://travis-ci.org/safx/TypetalkKit)
![Platform](https://img.shields.io/cocoapods/p/TypetalkKit.svg?style=flat)
![License](https://img.shields.io/cocoapods/l/TypetalkKit.svg?style=flat)
![Version](https://img.shields.io/cocoapods/v/TypetalkKit.svg?style=flat)

## Basic Usage

The following code gets user's topics and prints these.

```swift
Client.sharedClient.getTopics { (topics, error) -> Void in
    if error != nil {
        // error
    } else if let ts = topics? {
        for i in ts {
            println("\(i)")
        }
    }
}
```

TypetalkKit supports all Typetalk API.

If you want information in detail, please visit [official page](http://developer.nulab-inc.com/docs/typetalk).

## Authorization

> TypetalkKit currently only supports "Authorization Code". "Client Credentials" is not supported.

To use TypetalkKit, you need to register your app at [the Official Developer page](https://typetalk.in/my/develop/applications).

When you register your app, choose "Authorization Code" for Grant Type and set URI including custom URL scheme,
which should be unique to complete authorization process.

In your app, set developer settings:

```swift
Client.sharedClient.setDeveloperSettings(
    clientId:     "Your ClientID",
    clientSecret: "Your SecretID",
    redirectURI:  "Your custome scheme",    // e.g. typetalkkit+<YOUR_APP_ID>://auth/success
    scopes: [Scope.my, Scope.topic_read])
```

And then call `authorize`.

```swift
Client.sharedClient.authorize { (error) -> Void in
   ...
}
```

TypetalkKit use Safari for Typetalk's authorization process.
You, thearefore, have to add a custom URL scheme for "redirect URI" to your `Info.plist`
in order to switch back to your app from Safari.

When your app is back from Safari, call `Client.sharedClient.authorizationDone` in your `application(openURL, sourceApplication, annotation)` as follows:

```swift
func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
    if Client.sharedClient.isRedirectURL(url) && sourceApplication? == "com.apple.mobilesafari" {
        return Client.sharedClient.authorizationDone(URL: url)
    }
    return false
}
```

If you don't call `authorizationDone`, the callback of `authorize` never be called.

For more information of Typetalk's authorization, please see [official page](http://developer.nulab-inc.com/docs/typetalk/auth).

## Install

### Manual Install

1. Add TypetalkKit as a submodule:

        git submodule add https://github.com/safx/TypetalkKit.git

1. Add TypetalkKit.xcodeproj to your project.
1. Add TypetalkKit to "Target Dependencies" of "Build Phases" tab of your app's target.
1. Add "Copy Files" to copy TypetalkKit.framework:
    1. Click "+" button, and select "New Copy Files Phase" to add "Copy Files" to choose.
    1. Set the "Destination" to "Frameworks", and add TypetalkKit.framework.
