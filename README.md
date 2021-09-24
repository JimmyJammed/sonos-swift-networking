Sonos Swift Networking
========

[![License](https://img.shields.io/cocoapods/l/Swinject.svg?style=flat)](https://github.com/JimmyJammed/sonos-swift-networking)
[![Platforms](https://img.shields.io/badge/platform-iOS%20%7C%20macOS-lightgrey.svg)](https://github.com/JimmyJammed/sonos-swift-networking)
[![SPM](https://github.com/JimmyJammed/sonos-swift-networking/actions/workflows/swift.yml/badge.svg)](https://github.com/JimmyJammed/sonos-swift-networking/actions/workflows/swift.yml)
[![Swift Version](https://img.shields.io/badge/Swift-5.0-F16D39.svg?style=flat)](https://developer.apple.com/swift)
[![Twitter](https://img.shields.io/badge/twitter-@jimmy_jammed-blue.svg?style=flat)](http://twitter.com/jimmy_jammed)

Sonos Swift Networking is a wrapper for the Sonos API's.

## Sonos Swift SDK
Want an out-of-the-box solution to integrating your app with Sonos? Check out the [Sonos Swift SDK](https://github.com/JimmyJammed/sonos-swift-sdk) which is built on top of this library.

## How To Get Started
1. Create a Sonos Developer account [here](https://developer.sonos.com)
1. Then setup a new integration [here](https://integration.sonos.com/integrations)
1. Lastly, grab the **Key Name**, **Key** and **Secret** from your new integration

## Installation
Sonos Swift Networking supports the following installation methods:

### Swift Package Manager

In `Package.swift` add the following:

```swift
dependencies: [
    .package(url: "https://github.com/JimmyJammed/sonos-swift-networking", from: "1.0.0")
],
targets: [
    .target(
        name: "MyProject",
        dependencies: ["SonosNetworking"]
    )
    ...
]
```

###### Note: Sonos Swift Networking requires the following Swift Package dependencies:

[AFNetworking](https://github.com/AFNetworking/AFNetworking)
<br />
[Mocker](https://github.com/WeTransfer/Mocker.git) *- for unit testing*

## Usage
Using Sonos Swift Networking is pretty straightforward and should look familiar to most networking requests.

### Important
You will need to follow the [Authorization Steps](https://developer.sonos.com/reference/authorization-api/) to generate an Authorization Code in order to use any of the APIs provided by Sonos Swift Networking.
This library does support the Authorization Token *(and Refresh Token)* API's, but ***cannot*** create the Authorization Code directly, as it requires the user to interact with the Sonos Authorization URL from within a browser or web view.
<br>
You will need to implement your own solution for creating an Authorization Code.
<br>
Alternatively, you can use the [Sonos Swift SDK](https://github.com/JimmyJammed/sonos-swift-sdk) as it solves this problem with provided support for creating Authorization Codes.

### Example
Here is an example for fetching the current volume of a specified `Player`:

```
PlayerGetVolumeNetwork(accessToken: <ACCESS_TOKEN>, playerId: <PLAYER_ID>) { data in
	guard let data = data else {
		// Handle missing response data...
		return
	}
	// Success! Parse the data...
} failure: { error in
	// Handle API error response...
}.performRequest()
```

All API operations are documented in the codebase and have unit tests implemented, so take a look at those for further examples.

## Subscribe API's
It is important to note that the `subscribe/unsubscribe` API operations do require a separate server to be setup in order to receive real-time events when your Sonos devices are updated. 

This is not something that can be directly implemented in the client. You will need to setup a server using a provider of your choice *(AWS, etc)*.

You can however test these API's with a quick and easy method:

1. Create a free webhook server [here](https://webhook.site).
2. Go to your integration on the [Integrations](https://integration.sonos.com/integrations) page of the Sonos Developer Portal.
3. In the Credentials tab, set the **Event Callback URL** to the URL you copied in Step #2.
4. Fire any of the `subscribe` API operations then make a change directly on your Sonos device and you should observe events being reported to the webhook server you setup in Step #1.
5. **These steps are only intended for testing the `subscribe/unsubscribe` API's and are not a viable solution for a production-ready app.**

## Requirements

| Sonos Swift Networking Version | Sonos Swift Networking Version | Minimum iOS Target  | Minimum macOS Target  | Minimum watchOS Target  | Minimum tvOS Target  |                                   Notes |
|:--------------------:|:--------------------:|:---------------------------:|:----------------------------:|:----------------------------:|:----------------------------:|:-------------------------------------------------------------------------:|
| 1.0.0 | 1.0.0 | iOS 14 | 10.12 | x | x | Xcode 12+ is required. |

## Supported Sonos APIs

Here is a list of the currently supported Sonos API's:

* [x] [Authorization](https://developer.sonos.com/reference/authorization-api/)
	* [x] [Create Authorization Code](https://developer.sonos.com/reference/authorization-api/create-authorization-code/) 
	* [x] [Create Token](https://developer.sonos.com/reference/authorization-api/create-token/) 
	* [x] [Refresh Token](https://developer.sonos.com/reference/authorization-api/refresh-token/) 
* [x] [Control API](https://developer.sonos.com/reference/control-api/)
	* [x] [Audio Clip](https://developer.sonos.com/reference/control-api/audioclip/)
		* [x] cancelAudioClip
		* [x] loadAudioClip
		* [x] subscribe
		* [x] unsubscribe
	* [x] [Favorites](https://developer.sonos.com/reference/control-api/favorites/)
		* [x] getFavorites
		* [x] loadFavorites
		* [x] subscribe
		* [x] unsubscribe
	* [x] [Groups](https://developer.sonos.com/reference/control-api/groups/)
		* [x] createGroup
		* [x] getGroups
		* [x] modifyGroupMembers
		* [x] setGroupMembers
		* [x] subscribe
		* [x] unsubscribe
	* [x] [Group Volume](https://developer.sonos.com/reference/control-api/group-volume/)
		* [x] getVolume
		* [x] setMute
		* [x] setRelativeVolume
		* [x] setVolume
		* [x] subscribe
		* [x] unsubscribe
	* [x] [Home Theater](https://developer.sonos.com/reference/control-api/hometheater/)
		* [x] getOptions
		* [x] loadHomeTheaterPlayback
		* [x] setOptions
		* [x] setTvPowerState
	* [x] [Households](https://developer.sonos.com/reference/control-api/households/)
		* [x] getVolume
		* [x] setMute
		* [x] setRelativeVolume
		* [x] setVolume
		* [x] subscribe
		* [x] unsubscribe
	* [x] [Music Service Accounts](https://developer.sonos.com/reference/control-api/musicserviceaccounts/)
		* [x] match
	* [x] [Playback](https://developer.sonos.com/reference/control-api/playback/)
		* [x] getPlaybackStatus
		* [x] loadLineIn
		* [x] pause
		* [x] play
		* [x] seek
		* [x] seekRelative
		* [x] setPlayModes
		* [x] skipToNextTrack
		* [x] skipToPreviousTrack
		* [x] togglePlayPause
		* [x] subscribe
		* [x] unsubscribe
	* [x] [Playback Metadata](https://developer.sonos.com/reference/control-api/playback-metadata/)
		* [x] getMetaDataStatus
		* [x] subscribe
		* [x] unsubscribe
	* [x] [Playback Session](https://developer.sonos.com/reference/control-api/playbacksession/)
		* [x] createSession
		* [x] joinSession
		* [x] joinOrCreateSession
		* [x] loadCloudQueue
		* [x] loadStreamUrl
		* [x] refreshCloudQueue
		* [x] seekRelative
		* [x] skipToItem
		* [x] suspend
		* [x] subscribe
		* [x] unsubscribe
	* [x] [Player Volume](https://developer.sonos.com/reference/control-api/playervolume/)
 		* [x] getVolume
 		* [x] setMute
 		* [x] setRelativeVolume
 		* [x] setVolume
		* [x] subscribe
		* [x] unsubscribe
	* [x] [Playlists](https://developer.sonos.com/reference/control-api/playlists/)
		* [x] getPlaylist
		* [x] getPlaylists
		* [x] loadPlaylist
		* [x] subscribe
		* [x] unsubscribe
	* [x] [Settings](https://developer.sonos.com/reference/control-api/settings/)
		* [x] getPlayerSettings
		* [x] setPlayerSettings
		* [x] subscribe
		* [x] unsubscribe
* [ ] [Cloud Queue API](https://developer.sonos.com/reference/cloud-queue-api/)
	* [ ] *TBD*
* [ ] [Sonos Music API](https://developer.sonos.com/reference/sonos-music-api/)
 	* [ ] *TBD*


## Unit Tests

Sonos Swift Networking includes a suite of unit tests within the Tests subdirectory. You can also look at these for examples on how to use each API operation.

## Contribution Guide

A guide to [submit issues](https://github.com/JimmyJammed/sonos-swift-networking/issues), to ask general questions, or to [open pull requests](https://github.com/JimmyJammed/sonos-swift-networking/pulls) are [here](CONTRIBUTING.md).

## Credits

Sonos Swift Networking is an open source project and unaffiliated with Sonos Inc.

And most of all, thanks to Sonos Swift Networking's [growing list of contributors](https://github.com/JimmyJammed/sonos-swift-networking/contributors).

## License

Sonos Swift Networking is released under the MIT license. See [LICENSE](https://github.com/JimmyJammed/sonos-swift-networking/blob/main/LICENSE) for details.
