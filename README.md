# NAB_Assignment Tuan Diep

Language: Swift
Architecture: MVVM
About the API Key, I do not store the raw string in the code, I encrypted it to the UInt array, and decode it whenever I use to protect the sensitive data. (It's not the best case, I could store the api key on the firebase cloud or something like this but it is unnessesary)

* Application Folder Structure:

├── Modules
│   ├── Screen
│       ├── Model
│       ├── View Model
│       └── View
├── Resources
├── Reuseables

Resources folder contains all off asset or configuration files like info.plist, Assets.xcassets, etc.
Reuseables foler contains extensions, Manager or Service files
Modules is the main folder, it contains all of scenes and the main architecture of the app

* There is no third party libary so no need to set up the cocoa pod here

* Done Items:
1. Use Swift to develop the application.
2. MVVM is the architecture of this application.
3. UI is the same with the attachment. I added new Setting Screen for more easier to change the data setting without change the setting parameters (units, cnt).
4. Writed Unit Tests.
5. Acceptance Tests.
6. I hanlded the error exceptions like wrong data format, no internet connection, server error. Also I add the mechanism to help user can reload the request. At some cases, the reload button is not show like no result for the city name or something like that.
7. I use UserDefault to save the setting data. because the setting data is not a sensitive data, no need to use the keychain for other secure methods.
8. Accessibility for Disability Supports:
 	* VoiceOver: Use a screen reader.
 	* Supports the smallest ios screen: iPhone SE gen 2
 

