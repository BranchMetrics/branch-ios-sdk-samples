# branch-ios-sdk-samples
Samples demonstrating how to use Branch IOS SDK

## Purpose

The purpose of this app is to assist developers integrating the Branch iOS SDK.
It provides simple use cases that integrate most of the Android Advanced Features found here: https://help.branch.io/developers-hub/docs/ios-advanced-features

### *Features Implemented*
- Create a Content Reference
- Create Deep Link
- Share Deep Link
- Read Deep Link
- Create QR Code
- Navigate to Content
- Track ATT Opt-In and Opt-Out
- Track Users
- Track Events
- Handle Links in Your Own App
- Set Initialization Metadata
- Include Apple's ATTrackingManager

### *How to Route to Content*
1. Build and run the app on your device or emulator
2. Click the share button on the top of the Home Page
3. Send the link to Messages, or copy and paste it into a text editor
4. Click on the Branch Link. The app should open and route to the page it was coded for.
5. (Optional) Test again by modifying link information in the ShareBranchLink() function

## Home Page:

- App Creates a Branch Link on App Load at the top of the screen

- Send Custom Purchase Event, Add To Cart Event, and Change Background Color Event using the Buttons

- Create a QR Code / Share Branch Link with Navigation Buttons

- Share button creates a link that modifies the color block page

- QR Code button dims screen. Click anywhere on screen under Navigation Bar to hide QR Code

- Change Background Color button changes the background to a random color

## Color Block Page:

- Color block changes based on "color_block_key" parameter

- Options for "color_block_key" parameter are "red", "green", and "blue"

- If one of the above 3 colors aren't selected, color block defaults to white

## Read Deep Link Page:

- Collects session parameters and stores them

- If a Branch link is clicked to open the app, session parameters are modified to match link parameters.

- Collects install parameters on download and stores them

- Page is scrollable in case parameters are too long for the screen

## Limitations

- Code changes are needed to modify link data on QR Code, Share Sheet, and Generated Branch Link

- Install Parameters are difficult to modify
