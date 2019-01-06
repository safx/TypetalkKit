# TypetalkKit

[![TravisCI](http://img.shields.io/travis/safx/TypetalkKit.svg?style=flat)](https://travis-ci.org/safx/TypetalkKit)
[![codecov.io](https://codecov.io/github/safx/TypetalkKit/coverage.svg?branch=master)](https://codecov.io/github/safx/TypetalkKit?branch=master)
![Platform](https://img.shields.io/cocoapods/p/TypetalkKit.svg?style=flat)
![License](https://img.shields.io/cocoapods/l/TypetalkKit.svg?style=flat)
![Version](https://img.shields.io/cocoapods/v/TypetalkKit.svg?style=flat)
![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)

TypetalkKit is an unofficial web API client for Typetalk.

* [Typetalk API Overview](http://developer.nulab-inc.com/docs/typetalk)

## Basic Usage

The following code gets user's topics and prints these.

```swift
TypetalkAPI.sendRequest(GetTopics(spaceKey: spaceKey)) { result in
    switch result {
    case .Success(let ts):
        for i in ts {
            print(i)
        }
    case .Failure(let error):
        // error
    }
}
```

TypetalkKit supports almost all Typetalk API.

If you want to know further information about API, please visit [official page](http://developer.nulab-inc.com/docs/typetalk).

## Features

* Pure Swift API
* Full REST API support with [APIKit](https://github.com/ishkawa/APIKit)
* Streaming API support with [Starscream](https://github.com/daltoniam/Starscream)

## Authorization

To use TypetalkKit, you need to register your app at [the Official Developer page](https://typetalk.in/my/develop/applications) first.

When you register your app, choose "Authorization Code" for Grant Type and set URI including custom URL scheme,
which should be unique to complete authorization process.

In your app, set developer settings:

```swift
TypetalkAPI.setDeveloperSettings(
    clientId:     "Your ClientID",
    clientSecret: "Your SecretID",
    redirectURI:  "Your custome scheme",    // e.g. typetalkkit+<YOUR_APP_ID>://auth/success
    scopes: [Scope.my, Scope.topic_read])
```

And then call `authorize`.

```swift
TypetalkAPI.authorize { (error) -> Void in
   ...
}
```

TypetalkKit use Safari for Typetalk's authorization process.
You, thearefore, have to add a custom URL scheme for "redirect URI" to your `Info.plist` in order to switch back to your app from Safari.

When your app is back from Safari, call `TypetalkAPI.authorizationDone` in your `application(openURL, sourceApplication, annotation)` as follows:

```swift
func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
    if TypetalkAPI.isRedirectURL(url) && sourceApplication? == "com.apple.mobilesafari" {
        return TypetalkAPI.authorizationDone(URL: url)
    }
    return false
}
```

If you don't call `authorizationDone`, the callback of `authorize` never be called.

In OS X, you can use `TypetalkAPI.authorizationDone` in `handleGetURLEvent` as follows:

```swift
func handleGetURLEvent(event: NSAppleEventDescriptor?, replyEvent: NSAppleEventDescriptor?) {
    if let ev = event,
        url_str = ev.descriptorForKeyword(AEKeyword(keyDirectObject))?.stringValue,
        url = NSURL(string: url_str) where TypetalkAPI.isRedirectURL(url) {
            TypetalkAPI.authorizationDone(URL: url)
    }
}
```

For more information of Typetalk's authorization, please see [official page](http://developer.nulab-inc.com/docs/typetalk/auth).

## Install

### CocoaPods

    pod 'TypetalkKit'

### Carthage

	github "safx/TypetalkKit"

### Manual Install

1. Add TypetalkKit as a submodule:

        git submodule add https://github.com/safx/TypetalkKit.git

1. Add TypetalkKit.xcodeproj to your project.
1. Add TypetalkKit to "Target Dependencies" of "Build Phases" tab of your app's target.
1. Add "Copy Files" to copy TypetalkKit.framework:
    1. Click "+" button, and select "New Copy Files Phase" to add "Copy Files" to choose.
    1. Set the "Destination" to "Frameworks", and add TypetalkKit.framework.
