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

20150916 2301CST
add code to `didReceiveData` method in `MCManager.m`

20150917 2147CST
Token Update for the day.

20150918 2135CST
Token update 2

20150919 1940CST
add observation for notification to `ChatBoxViewController.m`. 
Declare `didReceiveDataWithNotification` in private section of interface for `ChatBoxViewController.m`.
`didReceiveDataWithNotification` made to read the user info dictionary of the notification, which contains the peer that sent the message and the message itself as an NSData object. From that object we'll get the display name and convert the data into an NSString object. Then, it adds to the text view the peer display name along with its message.

Text is set to text view via performSelectorOnMainThread:withObject:waitUntilDone: method. The data was received in a secondary thread and visual updates should take place on the main thread.

20150919 2020CST
chat client sends messages but formatting and content are broken. Will fix later.

20150920 1020CST
Troubleshooting chat client message issues. I think the notification might not be sending properly. Might've missed a chunk to include there.
Checked out the `sendMyMessage` method in `ChatBoxViewController.m` which includes the text formatting for the chat box. it seems to be in order- outputs `@"I wrote:\n%@\n\n", _txtMessage.text`. Could be that `_txtMessage.text` isn't formatted quite correctly. 
I had added a space in the next line. Fixed that, lets see how it goes.

Okay- on the sender it is saying the message and then I wrote and then your message… Oh, there is a text box at the top. If you click in the table view it also brings up the typing window and hitting send doesn't send anything and shows you a weird thing.

Note: Add blue box around text box for ux, turn off text from clicking on chat box.
Note: on the ipod touch there is no send button- the screen continues to the right off the panel.

But! There is no bug to fix, only features to add, so we will call it good because it is functional and move on.

20150922 1734CST
token update

20150923 1922CST
Next up is the File Exchanger
20150924 2128CST
following instructions on adding ui elements. Note- when selecting prototype cells, you have to select them and then change the type to static cell before you can modify the identifier.

add ui elements
adopt protocols for delegates in `FileSharingViewController.h` and link `tblView` table view controller to main.storyboard.

###Sharing Files
Declare and instantiate `AppDelegate *appDelegate` in `FileSharingViewController.m'. Declare it in private section within the interface, instantiate it in `viewDidLoad`.

20150924 2143CST
create a private method to take the sample files from the application bundle and copy them to the documents directory. Declare the method and an NSString object to keep the documents directory path.

In `copySampleFilesToDocDirIfNeeded`, instantiate an `NSArray` named `paths` as an `NSSearchPathForDirectoriesInDomains` using the arguments `NSDocumentDirectory, NSUserDomainMask, YES`. 
Then set `_documentsDirectory` as an NSString with the value from `paths` at 0.

This specifies and keeps the documents directory path to the `documentsDirectory` object.

Instantiate and specify the path for the sample files and check if they exist in documents directory. If they are not found, copy them from main bundle to documents directory, and log descriptions of files. 
Then return error if there is one.

Call this function in `viewDidLoad`. 

Adding table view functionality. Needs array as datasource. Array must contain all files existing on the documents directory.

Declare in `FileSharingViewController.m` private section `getAllDocDirFiles` and `NSMutableArray arrFiles`.

in `getAllDocDirFiles` implementation declare `fileManager`, `error`, and `NSArray allFiles`. `allFiles` populated with `fileManager` `contentsOfDirectoryAtPath:_documentsDirectory`. 

Add error handling.

return `allFiles`.

Populate `arrFiles` mutable array by calling `getAllDocDirFiles` from `viewDidLoad`.

Set delegate and data source for `_tblFiles` to `self`.

Then, have `_tblFiles` reload data, still in `viewDidLoad`, to make sample files appear on the table view upon view controller loading.

Need to implement the table view delegate and data source required methods.

in required `cellForRowAtIndexPath` method, do some formatting and font selection, identifiers, set the text, and set fonts and size.

set `heightForRowAtIndexPath` to `60.0`.

20150924 2219CST
ran it to test. Got a bug when i try to open the `FileSharingViewController` view, related to the `NSFileManager copyItemAtPath:toPath:error` where the source path is nil.

Dragged files into XCode and added them there. No error, file shows properly.

20150924 2223CST
Adding functionality to enable the app to send a file once it gets selected. When tapping on a table view row, a list of all peers will appear to allow selection of peer to send file. Using a `UIActionSheet` object, where each button will represent a peer. Action sheet should appear every time we tap on a row.

in method for actionsheet appearance (`tableView: […] didSelectRowAtIndexPath`, we start with an NSString `selectedFile`, populated with the object from the `indexPath.row` for the selected row. Then we build the UIActionSheet `confirmSending` by allocating an actionsheet, initializing it with the title of the selected file, setting its delegate to `self`, and setting the other buttons to `nil`.

then, we use a `for` loop to add each single peer one by one as a button to the action sheet. 

Set the cancel button, then display the actionsheet.

Keep the selected file name and selected row in two private members, `_selectedFile` and `_selectedRow`. Declare these members up in the interface. 

`UIActionSheet` is apparently deprecated in 8.3, so we're supposed to use a UIAlertController with a PreferredStyle of UIAlertControllerStyleActionSheet instead. 

Well! That's a rabbit hole. For now I'll keep the action sheet. Looks like the alert views have a completely different method of adding buttons. I found a pretty [good article](http://useyourloaf.com/blog/uialertcontroller-changes-in-ios-8.html) on it, but it's complex and worth a look on its own. 

20150924 2315CST
Need to get another device to test if the UIActionSheet isn't working, or just aren't connected to anyone.




