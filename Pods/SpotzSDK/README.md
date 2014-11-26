Spotz SDK
==========

## Adding the Spotz SDK framework to your project

Just add the following line to your Podfile:
```
pod 'SpotzSDK', :git => 'https://github.com/localz/Spotz-iOS-SDK.git'
```

Changelog
=========
**1.0.5**
* Added spotz ranging

**1.0.4**
* Fixed issues with refreshing spotz
* Updated spotz data from NSArray to NSDictionary

**1.0.3**
* Added support for iOS 8

**1.0.2**
* Fixed initialisation issues.

**1.0.1**
* Initial public release.

How to use the SDK
==================

**Currently only devices that support Bluetooth Low Energy (iPhone 4s or above, running iOS 7 or better) are able to make use of the Spotz SDK**. It is safe to include the SDK on earlier versions of iOS or devices that don't support Bluetooth Low Energy. 

There are only 4 actions to implement - **configure, initialize, start services and listen!**

*Refer to the sample app code for a working implementation of the SDK.*

In AppDelegate's didFinishLaunchingWithOptions add the following:

**1. Set authorization message**

For iOS 8 or later, please add the following key to Info.plist with a message that will be presented to the user when they first start the app.
```
NSLocationAlwaysUsageDescription
```

**2. Initialize the Spotz SDK**

Swift
```
    SpotzSDK.initializeWithAppId("<Enter your app ID here>", clientKey: "<Enter your client key here>", delegate: self, withOptions:nil)
```

Objective-C
```
    [SpotzSDK initializeWithAppId:@"<Enter your app ID here>" clientKey:@"<Enter your client key here>" delegate:self withOptions:nil];
```

When initialization is successful, it will call the spotzSDKInitSuccessfull delegate

**3. Start services**

Swift
```
func spotzSDKInitSuccessfull() {
    NSLog("SpotzSDK initialized successfully")
    SpotzSDK.startServices()
}

func spotzSDKInitFailed(error: NSError!) {
    // Spotz failed to initialise
    NSLog("Error %@", error)
}
```

Objective-C
```
#pragma mark - SpotzSDK delegates
- (void)spotzSDKInitSuccessfull
{
    NSLog(@"SpotzSDK initialized successfully");
    [SpotzSDK startServices];
}

- (void)spotzSDKInitFailed:(NSError *)error
{
    // Spotz failed to initialise
    NSLog(@"Error %@",error);
}
```

You can place this listener where it makes sense

**4. Listen for notifications**

Swift
```
// set up to recieve notifications from a spot
NSNotificationCenter.defaultCenter().addObserverForName(SpotzInsideNotification, object: nil, queue: nil) { (note:NSNotification!) -> Void in
  if note.object != nil {
    var data: NSDictionary! = note.object as NSDictionary

    var spotz = data["spotz"] as Spotz!
    var beacon = data["beacon"] as SpotzBeacon!
        
    NSLog("Beacon detected with UUID: %@ major: %i minor: %i",beacon.uuid,beacon.major,beacon.minor)
    NSLog("Show spotz details")
    // Do something amazing here
  }
}

NSNotificationCenter.defaultCenter().addObserverForName(SpotzRangingNotification, object: nil, queue: nil) { (note:NSNotification!) -> Void in
  if note.object != nil {
    var data: NSDictionary! = note.object as NSDictionary
                
    var spotz = data["spotz"] as Spotz!
    var acc = data["accuracy"] as NSNumber!
    var clBeacon = data["CLBeacon"] as CLBeacon?
                
    NSLog("Show spotz ranging details")
    // Do something else amazing here

  }
}
```

Objective-C
```
[[NSNotificationCenter defaultCenter] addObserverForName:SpotzInsideNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
	if (note.object)
	{
	    NSDictionary *data = note.object;

      	    Spotz *spotz = data[@"spotz"];
      	    SpotzBeacon *beacon = data[@"beacon"];
       
       	    NSLog(@"Beacon detected with UUID: %@ major: %i minor: %i",beacon.uuid,beacon.major,beacon.minor);
       	    NSLog(@"Show spotz details");

       	    // Do something amazing here
       	}
}];

[[NSNotificationCenter defaultCenter] addObserverForName:SpotzRangingNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        if (note.object)
	{
	    NSDictionary *data = note.object;
        
            Spotz *spotz = data[@"spotz"];
            NSNumber *acc = data[@"accuracy"];
	    CLBeacon *clBeacon = data[@"CLBeacon"];
        
            NSLog(@"Show spotz ranging details");
	
	    // Do something else amazing here
	}
}];
```

You can listen for the following notifications:

- SpotzInsideNotification
- SpotzOutsideNotification
- SpotzRangingNotification

When available, both Spotz and SpotzBeacon objects will be returned in the note.object's NSDictionary in both SpotzInsideNotification and SpotzOutsideNotification.
When/if using CLBeacon, remember to @import CoreLocation at the top of your file.

Contribution
============

For bugs, feature requests, or other questions, [file an issue](https://github.com/localz/Spotz-iOS-SDK/issues/new).

License
=======

Copyright 2014 Localz Pty Ltd

