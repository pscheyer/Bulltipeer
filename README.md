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
20150908 2307CST
Add text field delegate to `ConnectionsViewController.h` alongside the MCBrowserViewControllerDelegate. 
Add the set command for that delegate to `ConnectionsViewController.m` `viewDidLoad` method.

20150909 2241CST
add `textFieldShouldReturn` delegate method of text field to remove keyboard when return button is tapped, and peerID to get the name set to the text field. We already initialized `peerID` and `session` so we need to set them to nil and then reinitialize using specified name by calling `setupPeerAndSessionWithDisplayName`.

20150913 2159CST
The `textFieldShouldReturn` function checks if the advertiser is on- if so, stop it, and then set the respective object to nil. 

The text field is kept disabled to stop from changing the name while a connection is in progress and disrupting any data exchange.

Added another `IBAction`  function, `toggleVisibility`. Just calls `advertiseSelf` method to set the dvertiser's state according to the switch's state.

Claims we can test the thing. Lets give it a whirl. 

Wow! Worked fine. Best commit that. 20150913 2205CST


###Making a Connection
20150913 2208CST

Add a notification to `MCManager.m`, specifically the session `peerID didChangeState` method. Added an NSDictionary with `peerID` and `state` parameter values as its contents. Post a notification with `MCDidChangeStateNotification` name and the dict object as its user info dictionary.

Need to make `ConnectionsViewController.m` observe for the notification and post it. Add it in `viewDidLoad`, and get ready for errors because we included an undeclared method. 

`peerDidChangeStateWithNotification` goes up in the interface.

Now we need to implement that- the purpose is to make a list of people we've connected to so we can use the disconnect button and disable the text field. We need an array to be used as the datasource for our tableview, so we declare and initialize that.

For the table view to respond to our items the class has to be set as its delegate. While in viewDidLoad we add a couple lines for that. Errors, 'cause we have to adopt the protocols.

Add `UITableViewDelegate` and `UITableViewDataSource` to the `ConnectionsViewController.h` file.

We return to the `.m` to implement our private method for handling the notifications.

`peerDidChangeStateWithNotification` has a few steps. 
First it gets the two objects from the user info dictionary and keep the display name of the connected peer in an NSString.
Then it only performs actions if the state is not `MCSessionStateConnecting`, and then we find the index of the current peer in the array and remove it.
Then we reload the data on the table view, check if there are any peers left, and depending on the bool we set the text field and the disconnect button enable state.

We need required table view delegate and datasource methods.
Whole bunch of stuff, under the pragma mark for the table view delegate and data source methods.

20150913 2230CST
Had a brief bug from misplaced code in peerDidChangeState. Resolved it.

20150913 2230CST
add `disconnect` method. Doesn't quite work properly across both devices… takes a little bit, i guess. A feature. 

###Setup the Chat Interface
20150914 1926CST
Going to do most of this in the interface builder

20150914 2052CST
Spent more than an hour stuck. Eventually found that i have to add a view to a view controller before I can add anything else, or it just fills the entire view controller.

Had to stretch the view measurements a bit to fit the wireframe.

Added properties and IBActions for the buttons to `ChatBoxViewController.h`.

###Let's Chat
In `ChatBoxViewController.m` add import for `AppDelegate.h`, a property for the app delegate, and an instantiation for it in viewDidLoad.

20150915 2118CST
ugh just spent an hour troubleshooting an issue. Made my views in compact and couldn't see them in wAny / hAny. Worth uploading just for that.

