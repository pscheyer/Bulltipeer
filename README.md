20150906 1207CST init readme

#Bulltipeer
Bulltipeer is a project to build a multipeer connectivity chat client with a built-in 'Bull' script that responds to specific inputs with outputs. Some ideas for the bull are 'Toro!' responding with 'Snort!', and 'Ole!' responding with 'smashes china shop.'


Our programming pattern will be from [AppCoda](http://www.appcoda.com/intro-multipeer-connectivity-framework-ios-programming/).

20150907 1704CST
That site suggests a tabbed app with 3 tabs. 


###Demo App, Adding a new Tab, 
20150907 1848CST- 
Added 3-tab views. Used steps from [this tutorial saved in templates](How to Create a Tabbed App.md). That covers through the section titled __'Connections View Controller: Setup the Interface'__

###__'Connections View Controller: Setup the Interface'__
20150907 1905CST
added interface builder, IBOactions, and similar, according to tutorial. This is the first tutorial i've found that actually makes that simple.

20150907 1927CST
added MCManager Class, an NSObject containing the multipeer components in its .h- `MCPeerID`, `MCSession`, `MCBrowserViewController`, and `MCAdvertiserAssistant`. 
.h also contains public methods `setupPeerAndSessionWithDisplayName`, `setupMCBrowser`, `advertiseSelf`.

.m init changes include all those public methods, as well as items for session functions.
`peer` is called when peers change their state, meaning when they connect or disco. 
`didReceiveData` is for receiving new data from a peer. This one is a delegate for messages.
`didStartReceivingResourceWithName` and `didFinish` are called when a resource is received.
`didReceiveStream' is for handling incoming streams.

the `SetupPeerAndSessionWithDisplayName` function sets the `_peerID`, `_session`, and `session.delegate` items.

`setupMCBrowser` performs the critical step of initializing the session object, using the peerID for initialization. The source has some good notes about the serviceType.

`advertiseSelf` toggles the advertising feature of the device.


We also make changes in `AppDelegate.h`, declaring an object of our class and importing it. In `AppDelegate.m` we add alloc/init for our class to 'didFinishLaunchingWithOptions'.

Next section.

###The Discovery Phase
20150907 1943CST
we're modding `ConnectionsViewController.h` to make it conform to the *MCBrowserViewControllerDelegate* protocol. 

20150907 1946CST
now adding app delegate to `ConnectionsViewController.m` `viewDidLoad` function.

Instantiate the `appDelegate` using the `sharedApplication` class method, allowing us to call required public methods of `mcManager` object. Call `setupPeerAndSessionWithDisplayName` and `advertiseSelf`. Hand a default display name to setup in case they didn't specify.

Adding code to `browseForDevices:IBAction` method in `ConnectionsViewController.m`. 

Claims that we should be able to see the stuff work. I've got a black screen. 20150907 1952CST begin troubleshooting.

20150907 2006CST problem was extra code from other answer which manually set up button names. Changing procedure in tab bar tutorial.

20150907 2012CST 
implementing functions for Done and Cancel buttons via delegate methods of `MCBrowserViewControllerDelegate`. Added them to `ConnectionsViewController.m`. 


###Peer Display Name And The Advertiser State



