# Swift Deep linking Sample for iOS #


* Swift 5.0
* Deployment Target - iOS 13.0
* Devices - iPhone

## Usage example ##

### Update your info.plist file ###

* The very first step to add deep linking support for our app will  be to update our info.plist file. You can open it as a source file and paste the following code snipped either at the top of the document(right after the opening <dict> tag) or at the bottom of your document(right before the </dict></plist> tags).

<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLIconFile</key>
        <string></string>
        <key>CFBundleURLName</key>
        <string>com.wekancode.obepower</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>obepower</string>
        </array>
    </dict>
</array>

* Replace the value of CFBundleURLSchemes which is in my case “obepower” with a unique deep link url scheme that will make sense for your app. Just remember to make it short and unique.  And replace the value of CFBundleURLName with a value of Bundle Identifier of your app.

### Update AppDelegate.swift file ###

* For your app to be able to listen to custom url schema clicks you will need to add the below function to your AppDelegate.swift file. This function is part of UIApplicationDelegate protocol.

func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {        
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DEEP_LINK_CLICKED"), object: url.absoluteString)        
    return true
}

### Update ViewController.swift file ###

* You will need to add the below line to your ViewController.swift file in ViewDidLoad function.

NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: Notification.Name("DEEP_LINK_CLICKED"), object: nil)

### Notification Observer ###

* You will need to add the below function to your ViewController.swift file.

// MARK: - Notification observer        

/** Notification observer */    

@objc func notificationReceived(_ notification: Notification) {       
    let urlString = notification.object as! String       
    let arr: [String] = urlString.components(separatedBy: "=")                
    var viewController = UIViewController()        
    let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)               
    if arr[0] == "obepower://station?stationid" + "." {            
        //Station Page            
        viewController = mainStoryboard.instantiateViewController(withIdentifier: "StationViewController") as! StationViewController
    } else if arr[1] == "1:168565" {            
            //Booking Page            
            viewController = mainStoryboard.instantiateViewController(identifier: "BookingViewController") as! BookingViewController
    }                
        navigationController?.pushViewController(viewController, animated: true) 
}


