import Foundation

public typealias GroupStatusCodes = String

public typealias QueueAction = String

public typealias TagsData = String

public typealias Capability = String

public typealias PlaybackState = String

public typealias SessionStateEnum = String

public typealias AudioClipState = String

public typealias AudioClipType = String

public typealias LedPatternType = String

public typealias Priority = String

public struct PlaybackAction: Codable, Sendable, Equatable {
    public var `canPlay`: Bool?
    public var `canSkip`: Bool?
    public var `canSkipBack`: Bool?
    public var `canSkipToPrevious`: Bool?
    public var `canSeek`: Bool?
    public var `canPause`: Bool?
    public var `canStop`: Bool?
    public var `canRepeat`: Bool?
    public var `canRepeatOne`: Bool?
    public var `canCrossfade`: Bool?
    public var `canShuffle`: Bool?
    public init(`canPlay`: Bool? = nil, `canSkip`: Bool? = nil, `canSkipBack`: Bool? = nil, `canSkipToPrevious`: Bool? = nil, `canSeek`: Bool? = nil, `canPause`: Bool? = nil, `canStop`: Bool? = nil, `canRepeat`: Bool? = nil, `canRepeatOne`: Bool? = nil, `canCrossfade`: Bool? = nil, `canShuffle`: Bool? = nil) {
        self.`canPlay` = `canPlay`
        self.`canSkip` = `canSkip`
        self.`canSkipBack` = `canSkipBack`
        self.`canSkipToPrevious` = `canSkipToPrevious`
        self.`canSeek` = `canSeek`
        self.`canPause` = `canPause`
        self.`canStop` = `canStop`
        self.`canRepeat` = `canRepeat`
        self.`canRepeatOne` = `canRepeatOne`
        self.`canCrossfade` = `canCrossfade`
        self.`canShuffle` = `canShuffle`
    }
}

public struct PlaybackLoadLineInGroupIdBody: Codable, Sendable, Equatable {
    public var `deviceId`: String?
    public var `playOnCompletion`: Bool?
    public init(`deviceId`: String? = nil, `playOnCompletion`: Bool? = nil) {
        self.`deviceId` = `deviceId`
        self.`playOnCompletion` = `playOnCompletion`
    }
}

public struct HomeTheaterSetOptionsPlayerIdBody: Codable, Sendable, Equatable {
    public var `nightMode`: Bool?
    public var `enhanceDialog`: Bool?
    public init(`nightMode`: Bool? = nil, `enhanceDialog`: Bool? = nil) {
        self.`nightMode` = `nightMode`
        self.`enhanceDialog` = `enhanceDialog`
    }
}

public struct GlobalError: Codable, Sendable, Equatable {
    public var `errorCode`: String?
    public var `reason`: String?
    public init(`errorCode`: String? = nil, `reason`: String? = nil) {
        self.`errorCode` = `errorCode`
        self.`reason` = `reason`
    }
}

public struct PlaybackSeekGroupIdBody: Codable, Sendable, Equatable {
    public var `itemId`: String?
    public var `positionMillis`: Int
    public init(`itemId`: String? = nil, `positionMillis`: Int) {
        self.`itemId` = `itemId`
        self.`positionMillis` = `positionMillis`
    }
}

public struct DirectControl: Codable, Sendable, Equatable {
    public var `clientId`: String
    public var `isSuspended`: Bool
    public var `accountId`: String
    public init(`clientId`: String, `isSuspended`: Bool, `accountId`: String) {
        self.`clientId` = `clientId`
        self.`isSuspended` = `isSuspended`
        self.`accountId` = `accountId`
    }
}

public struct SessionStatus: Codable, Sendable, Equatable {
    public var `sessionId`: String?
    public var `sessionState`: SessionStateEnum?
    public var `sessionCreated`: Bool?
    public var `customData`: String?
    public init(`sessionId`: String? = nil, `sessionState`: SessionStateEnum? = nil, `sessionCreated`: Bool? = nil, `customData`: String? = nil) {
        self.`sessionId` = `sessionId`
        self.`sessionState` = `sessionState`
        self.`sessionCreated` = `sessionCreated`
        self.`customData` = `customData`
    }
}

public struct PlaylistsList: Codable, Sendable, Equatable {
    public var `version`: String?
    public var `playlists`: [Playlist]?
    public init(`version`: String? = nil, `playlists`: [Playlist]? = nil) {
        self.`version` = `version`
        self.`playlists` = `playlists`
    }
}

public struct GroupsModifyGroupMembersGroupIdBody: Codable, Sendable, Equatable {
    public var `playerIdsToAdd`: [String]?
    public var `playerIdsToRemove`: [String]?
    public init(`playerIdsToAdd`: [String]? = nil, `playerIdsToRemove`: [String]? = nil) {
        self.`playerIdsToAdd` = `playerIdsToAdd`
        self.`playerIdsToRemove` = `playerIdsToRemove`
    }
}

public struct QueueItem: Codable, Sendable, Equatable {
    public var `id`: String?
    public var `track`: Track?
    public var `deleted`: Bool?
    public var `policies`: PlaybackPolicy?
    public init(`id`: String? = nil, `track`: Track? = nil, `deleted`: Bool? = nil, `policies`: PlaybackPolicy? = nil) {
        self.`id` = `id`
        self.`track` = `track`
        self.`deleted` = `deleted`
        self.`policies` = `policies`
    }
}

public struct PlaybackStatus: Codable, Sendable, Equatable {
    public var `playbackState`: PlaybackState
    public var `isDucking`: Bool?
    public var `queueVersion`: String?
    public var `itemId`: String?
    public var `positionMillis`: Int?
    public var `previousItemId`: String?
    public var `previousPositionMillis`: Int?
    public var `playModes`: PlayMode?
    public var `availablePlaybackActions`: PlaybackAction?
    public init(`playbackState`: PlaybackState, `isDucking`: Bool? = nil, `queueVersion`: String? = nil, `itemId`: String? = nil, `positionMillis`: Int? = nil, `previousItemId`: String? = nil, `previousPositionMillis`: Int? = nil, `playModes`: PlayMode? = nil, `availablePlaybackActions`: PlaybackAction? = nil) {
        self.`playbackState` = `playbackState`
        self.`isDucking` = `isDucking`
        self.`queueVersion` = `queueVersion`
        self.`itemId` = `itemId`
        self.`positionMillis` = `positionMillis`
        self.`previousItemId` = `previousItemId`
        self.`previousPositionMillis` = `previousPositionMillis`
        self.`playModes` = `playModes`
        self.`availablePlaybackActions` = `availablePlaybackActions`
    }
}

public struct MusicServiceAccount: Codable, Sendable, Equatable {
    public var `userIdHashCode`: String?
    public var `nickname`: String?
    public var `id`: String?
    public var `isGuest`: Bool?
    public var `service`: Service?
    public init(`userIdHashCode`: String? = nil, `nickname`: String? = nil, `id`: String? = nil, `isGuest`: Bool? = nil, `service`: Service? = nil) {
        self.`userIdHashCode` = `userIdHashCode`
        self.`nickname` = `nickname`
        self.`id` = `id`
        self.`isGuest` = `isGuest`
        self.`service` = `service`
    }
}

public struct PlaylistsLoadPlaylistGroupIdBody: Codable, Sendable, Equatable {
    public var `playlistId`: String
    public var `action`: QueueAction?
    public var `playModes`: PlayMode?
    public var `playOnCompletion`: Bool?
    public init(`playlistId`: String, `action`: QueueAction? = nil, `playModes`: PlayMode? = nil, `playOnCompletion`: Bool? = nil) {
        self.`playlistId` = `playlistId`
        self.`action` = `action`
        self.`playModes` = `playModes`
        self.`playOnCompletion` = `playOnCompletion`
    }
}

public struct SessionError: Codable, Sendable, Equatable {
    public var `errorCode`: String?
    public var `reason`: String?
    public init(`errorCode`: String? = nil, `reason`: String? = nil) {
        self.`errorCode` = `errorCode`
        self.`reason` = `reason`
    }
}

public struct PlayerVolumeSetVolumePlayerIdBody: Codable, Sendable, Equatable {
    public var `volume`: Int?
    public var `muted`: Bool?
    public init(`volume`: Int? = nil, `muted`: Bool? = nil) {
        self.`volume` = `volume`
        self.`muted` = `muted`
    }
}

public struct PlayerVolume: Codable, Sendable, Equatable {
    public var `volume`: Int
    public var `muted`: Bool?
    public var `fixed`: Bool?
    public init(`volume`: Int, `muted`: Bool? = nil, `fixed`: Bool? = nil) {
        self.`volume` = `volume`
        self.`muted` = `muted`
        self.`fixed` = `fixed`
    }
}

public struct PlaybackSetPlayModesGroupIdBody: Codable, Sendable, Equatable {
    public var `playModes`: PlayMode
    public init(`playModes`: PlayMode) {
        self.`playModes` = `playModes`
    }
}

public struct GroupCoordinatorChanged: Codable, Sendable, Equatable {
    public var `groupStatus`: GroupStatusCodes
    public var `groupName`: String?
    public var `websocketUrl`: String?
    public var `playerId`: String?
    public init(`groupStatus`: GroupStatusCodes, `groupName`: String? = nil, `websocketUrl`: String? = nil, `playerId`: String? = nil) {
        self.`groupStatus` = `groupStatus`
        self.`groupName` = `groupName`
        self.`websocketUrl` = `websocketUrl`
        self.`playerId` = `playerId`
    }
}

public struct Households: Codable, Sendable, Equatable {
    public var `households`: [Household]?
    public init(`households`: [Household]? = nil) {
        self.`households` = `households`
    }
}

public struct Playlist: Codable, Sendable, Equatable {
    public var `id`: String
    public var `name`: String
    public var `type`: String?
    public var `trackCount`: Int?
    public init(`id`: String, `name`: String, `type`: String? = nil, `trackCount`: Int? = nil) {
        self.`id` = `id`
        self.`name` = `name`
        self.`type` = `type`
        self.`trackCount` = `trackCount`
    }
}

public struct Player: Codable, Sendable, Equatable {
    public var `id`: String
    public var `name`: String
    public var `websocketUrl`: String
    public var `softwareVersion`: String
    public var `apiVersion`: String
    public var `minApiVersion`: String
    public var `isUnregistered`: Bool?
    public var `capabilities`: [Capability]
    public var `deviceIds`: [String]
    public var `devices`: [DeviceInfo]?
    public init(`id`: String, `name`: String, `websocketUrl`: String, `softwareVersion`: String, `apiVersion`: String, `minApiVersion`: String, `isUnregistered`: Bool? = nil, `capabilities`: [Capability], `deviceIds`: [String], `devices`: [DeviceInfo]? = nil) {
        self.`id` = `id`
        self.`name` = `name`
        self.`websocketUrl` = `websocketUrl`
        self.`softwareVersion` = `softwareVersion`
        self.`apiVersion` = `apiVersion`
        self.`minApiVersion` = `minApiVersion`
        self.`isUnregistered` = `isUnregistered`
        self.`capabilities` = `capabilities`
        self.`deviceIds` = `deviceIds`
        self.`devices` = `devices`
    }
}

public struct FavoritesList: Codable, Sendable, Equatable {
    public var `version`: String
    public var `items`: [Favorite]
    public init(`version`: String, `items`: [Favorite]) {
        self.`version` = `version`
        self.`items` = `items`
    }
}

public struct PlaybackSessionLoadCloudQueueSessionIdBody: Codable, Sendable, Equatable {
    public var `queueBaseUrl`: String
    public var `httpAuthorization`: String?
    public var `useHttpAuthorizationForMedia`: Bool?
    public var `itemId`: String?
    public var `queueVersion`: String?
    public var `positionMillis`: Int?
    public var `playOnCompletion`: Bool?
    public var `trackMetadata`: Track?
    public init(`queueBaseUrl`: String, `httpAuthorization`: String? = nil, `useHttpAuthorizationForMedia`: Bool? = nil, `itemId`: String? = nil, `queueVersion`: String? = nil, `positionMillis`: Int? = nil, `playOnCompletion`: Bool? = nil, `trackMetadata`: Track? = nil) {
        self.`queueBaseUrl` = `queueBaseUrl`
        self.`httpAuthorization` = `httpAuthorization`
        self.`useHttpAuthorizationForMedia` = `useHttpAuthorizationForMedia`
        self.`itemId` = `itemId`
        self.`queueVersion` = `queueVersion`
        self.`positionMillis` = `positionMillis`
        self.`playOnCompletion` = `playOnCompletion`
        self.`trackMetadata` = `trackMetadata`
    }
}

public struct AccountError: Codable, Sendable, Equatable {
    public var `errorCode`: String?
    public var `reason`: String?
    public var `accountId`: String?
    public init(`errorCode`: String? = nil, `reason`: String? = nil, `accountId`: String? = nil) {
        self.`errorCode` = `errorCode`
        self.`reason` = `reason`
        self.`accountId` = `accountId`
    }
}

public struct Favorite: Codable, Sendable, Equatable {
    public var `id`: String
    public var `name`: String
    public var `description`: String?
    public var `imageUrl`: String?
    public var `service`: Service?
    public init(`id`: String, `name`: String, `description`: String? = nil, `imageUrl`: String? = nil, `service`: Service? = nil) {
        self.`id` = `id`
        self.`name` = `name`
        self.`description` = `description`
        self.`imageUrl` = `imageUrl`
        self.`service` = `service`
    }
}

public struct GroupVolumeSetMuteGroupIdBody: Codable, Sendable, Equatable {
    public var `muted`: Bool
    public init(`muted`: Bool) {
        self.`muted` = `muted`
    }
}

public struct Podcast: Codable, Sendable, Equatable {
    public var `name`: String
    public var `producer`: Artist?
    public var `id`: UniversalMusicObjectId?
    public init(`name`: String, `producer`: Artist? = nil, `id`: UniversalMusicObjectId? = nil) {
        self.`name` = `name`
        self.`producer` = `producer`
        self.`id` = `id`
    }
}

public struct Groups: Codable, Sendable, Equatable {
    public var `groups`: [Group]?
    public var `players`: [Player]?
    public var `partial`: Bool?
    public init(`groups`: [Group]? = nil, `players`: [Player]? = nil, `partial`: Bool? = nil) {
        self.`groups` = `groups`
        self.`players` = `players`
        self.`partial` = `partial`
    }
}

public struct Album: Codable, Sendable, Equatable {
    public var `name`: String
    public var `artist`: Artist?
    public var `id`: UniversalMusicObjectId?
    public var `tags`: [TagsData]?
    public init(`name`: String, `artist`: Artist? = nil, `id`: UniversalMusicObjectId? = nil, `tags`: [TagsData]? = nil) {
        self.`name` = `name`
        self.`artist` = `artist`
        self.`id` = `id`
        self.`tags` = `tags`
    }
}

public struct GroupVolumeSetVolumeGroupIdBody: Codable, Sendable, Equatable {
    public var `volume`: Int
    public init(`volume`: Int) {
        self.`volume` = `volume`
    }
}

public struct MetadataStatus: Codable, Sendable, Equatable {
    public var `container`: Container?
    public var `currentItem`: QueueItem?
    public var `nextItem`: QueueItem?
    public var `currentShow`: RadioShow?
    public var `streamInfo`: String?
    public var `playbackSession`: DirectControl?
    public init(`container`: Container? = nil, `currentItem`: QueueItem? = nil, `nextItem`: QueueItem? = nil, `currentShow`: RadioShow? = nil, `streamInfo`: String? = nil, `playbackSession`: DirectControl? = nil) {
        self.`container` = `container`
        self.`currentItem` = `currentItem`
        self.`nextItem` = `nextItem`
        self.`currentShow` = `currentShow`
        self.`streamInfo` = `streamInfo`
        self.`playbackSession` = `playbackSession`
    }
}

public struct PlayMode: Codable, Sendable, Equatable {
    public var `repeat`: Bool?
    public var `repeatOne`: Bool?
    public var `shuffle`: Bool?
    public var `crossfade`: Bool?
    public init(`repeat`: Bool? = nil, `repeatOne`: Bool? = nil, `shuffle`: Bool? = nil, `crossfade`: Bool? = nil) {
        self.`repeat` = `repeat`
        self.`repeatOne` = `repeatOne`
        self.`shuffle` = `shuffle`
        self.`crossfade` = `crossfade`
    }
}

public struct PlayerVolumeSetRelativeVolumePlayerIdBody: Codable, Sendable, Equatable {
    public var `volumeDelta`: Int?
    public var `muted`: Bool?
    public init(`volumeDelta`: Int? = nil, `muted`: Bool? = nil) {
        self.`volumeDelta` = `volumeDelta`
        self.`muted` = `muted`
    }
}

public struct HomeTheaterOptions: Codable, Sendable, Equatable {
    public var `nightMode`: Bool?
    public var `enhanceDialog`: Bool?
    public init(`nightMode`: Bool? = nil, `enhanceDialog`: Bool? = nil) {
        self.`nightMode` = `nightMode`
        self.`enhanceDialog` = `enhanceDialog`
    }
}

public struct PlaybackSessionSkipToItemSessionIdBody: Codable, Sendable, Equatable {
    public var `itemId`: String
    public var `queueVersion`: String?
    public var `positionMillis`: Int?
    public var `playOnCompletion`: Bool?
    public var `trackMetadata`: Track?
    public init(`itemId`: String, `queueVersion`: String? = nil, `positionMillis`: Int? = nil, `playOnCompletion`: Bool? = nil, `trackMetadata`: Track? = nil) {
        self.`itemId` = `itemId`
        self.`queueVersion` = `queueVersion`
        self.`positionMillis` = `positionMillis`
        self.`playOnCompletion` = `playOnCompletion`
        self.`trackMetadata` = `trackMetadata`
    }
}

public struct Track: Codable, Sendable, Equatable {
    public var `type`: String?
    public var `name`: String?
    public var `mediaUrl`: String?
    public var `imageUrl`: String?
    public var `contentType`: String?
    public var `album`: Album?
    public var `artist`: Artist?
    public var `author`: Artist?
    public var `book`: Book?
    public var `narrator`: Artist?
    public var `podcast`: Podcast?
    public var `releaseDate`: String?
    public var `producer`: Artist?
    public var `episodeNumber`: Int?
    public var `id`: UniversalMusicObjectId?
    public var `service`: Service?
    public var `durationMillis`: Int?
    public var `trackNumber`: Int?
    public var `chapterNumber`: Int?
    public var `tags`: [TagsData]?
    public var `quality`: TrackQuality?
    public var `replayGain`: Double?
    public init(`type`: String? = nil, `name`: String? = nil, `mediaUrl`: String? = nil, `imageUrl`: String? = nil, `contentType`: String? = nil, `album`: Album? = nil, `artist`: Artist? = nil, `author`: Artist? = nil, `book`: Book? = nil, `narrator`: Artist? = nil, `podcast`: Podcast? = nil, `releaseDate`: String? = nil, `producer`: Artist? = nil, `episodeNumber`: Int? = nil, `id`: UniversalMusicObjectId? = nil, `service`: Service? = nil, `durationMillis`: Int? = nil, `trackNumber`: Int? = nil, `chapterNumber`: Int? = nil, `tags`: [TagsData]? = nil, `quality`: TrackQuality? = nil, `replayGain`: Double? = nil) {
        self.`type` = `type`
        self.`name` = `name`
        self.`mediaUrl` = `mediaUrl`
        self.`imageUrl` = `imageUrl`
        self.`contentType` = `contentType`
        self.`album` = `album`
        self.`artist` = `artist`
        self.`author` = `author`
        self.`book` = `book`
        self.`narrator` = `narrator`
        self.`podcast` = `podcast`
        self.`releaseDate` = `releaseDate`
        self.`producer` = `producer`
        self.`episodeNumber` = `episodeNumber`
        self.`id` = `id`
        self.`service` = `service`
        self.`durationMillis` = `durationMillis`
        self.`trackNumber` = `trackNumber`
        self.`chapterNumber` = `chapterNumber`
        self.`tags` = `tags`
        self.`quality` = `quality`
        self.`replayGain` = `replayGain`
    }
}

public struct MusicServiceAccountsMatchHouseholdIdBody: Codable, Sendable, Equatable {
    public var `userIdHashCode`: String
    public var `nickname`: String
    public var `serviceId`: String
    public var `linkCode`: String?
    public var `linkDeviceId`: String?
    public init(`userIdHashCode`: String, `nickname`: String, `serviceId`: String, `linkCode`: String? = nil, `linkDeviceId`: String? = nil) {
        self.`userIdHashCode` = `userIdHashCode`
        self.`nickname` = `nickname`
        self.`serviceId` = `serviceId`
        self.`linkCode` = `linkCode`
        self.`linkDeviceId` = `linkDeviceId`
    }
}

public struct AudioClip: Codable, Sendable, Equatable {
    public var `id`: String
    public var `name`: String
    public var `appId`: String
    public var `priority`: Priority
    public var `clipType`: AudioClipType?
    public var `status`: AudioClipState
    public var `clipLEDBehavior`: LedPatternType
    public var `errorCode`: String?
    public init(`id`: String, `name`: String, `appId`: String, `priority`: Priority, `clipType`: AudioClipType? = nil, `status`: AudioClipState, `clipLEDBehavior`: LedPatternType, `errorCode`: String? = nil) {
        self.`id` = `id`
        self.`name` = `name`
        self.`appId` = `appId`
        self.`priority` = `priority`
        self.`clipType` = `clipType`
        self.`status` = `status`
        self.`clipLEDBehavior` = `clipLEDBehavior`
        self.`errorCode` = `errorCode`
    }
}

public struct PlaybackError: Codable, Sendable, Equatable {
    public var `errorCode`: String?
    public var `reason`: String?
    public var `itemId`: String?
    public var `host`: String?
    public var `hostIp`: String?
    public var `httpStatus`: Int?
    public var `queueVersion`: String?
    public init(`errorCode`: String? = nil, `reason`: String? = nil, `itemId`: String? = nil, `host`: String? = nil, `hostIp`: String? = nil, `httpStatus`: Int? = nil, `queueVersion`: String? = nil) {
        self.`errorCode` = `errorCode`
        self.`reason` = `reason`
        self.`itemId` = `itemId`
        self.`host` = `host`
        self.`hostIp` = `hostIp`
        self.`httpStatus` = `httpStatus`
        self.`queueVersion` = `queueVersion`
    }
}

public struct DeviceInfo: Codable, Sendable, Equatable {
    public var `id`: String
    public var `primaryDeviceId`: String?
    public var `serialNumber`: String?
    public var `deviceId`: String?
    public var `modelDisplayName`: String?
    public var `color`: String?
    public var `capabilities`: [Capability]?
    public var `apiVersion`: String?
    public var `minApiVersion`: String?
    public var `versions`: SdkVersions?
    public var `name`: String?
    public var `websocketUrl`: String?
    public var `softwareVersion`: String?
    public var `hwVersion`: String?
    public var `swGen`: Int?
    public init(`id`: String, `primaryDeviceId`: String? = nil, `serialNumber`: String? = nil, `deviceId`: String? = nil, `modelDisplayName`: String? = nil, `color`: String? = nil, `capabilities`: [Capability]? = nil, `apiVersion`: String? = nil, `minApiVersion`: String? = nil, `versions`: SdkVersions? = nil, `name`: String? = nil, `websocketUrl`: String? = nil, `softwareVersion`: String? = nil, `hwVersion`: String? = nil, `swGen`: Int? = nil) {
        self.`id` = `id`
        self.`primaryDeviceId` = `primaryDeviceId`
        self.`serialNumber` = `serialNumber`
        self.`deviceId` = `deviceId`
        self.`modelDisplayName` = `modelDisplayName`
        self.`color` = `color`
        self.`capabilities` = `capabilities`
        self.`apiVersion` = `apiVersion`
        self.`minApiVersion` = `minApiVersion`
        self.`versions` = `versions`
        self.`name` = `name`
        self.`websocketUrl` = `websocketUrl`
        self.`softwareVersion` = `softwareVersion`
        self.`hwVersion` = `hwVersion`
        self.`swGen` = `swGen`
    }
}

public struct AudioClipLoadAudioClipPlayerIdBody: Codable, Sendable, Equatable {
    public var `name`: String
    public var `appId`: String
    public var `priority`: Priority?
    public var `clipType`: AudioClipType?
    public var `streamUrl`: String?
    public var `httpAuthorization`: String?
    public var `volume`: Int?
    public var `clipLEDBehavior`: LedPatternType?
    public init(`name`: String, `appId`: String, `priority`: Priority? = nil, `clipType`: AudioClipType? = nil, `streamUrl`: String? = nil, `httpAuthorization`: String? = nil, `volume`: Int? = nil, `clipLEDBehavior`: LedPatternType? = nil) {
        self.`name` = `name`
        self.`appId` = `appId`
        self.`priority` = `priority`
        self.`clipType` = `clipType`
        self.`streamUrl` = `streamUrl`
        self.`httpAuthorization` = `httpAuthorization`
        self.`volume` = `volume`
        self.`clipLEDBehavior` = `clipLEDBehavior`
    }
}

public struct GroupInfo: Codable, Sendable, Equatable {
    public var `group`: Group?
    public init(`group`: Group? = nil) {
        self.`group` = `group`
    }
}

public struct PlaybackSessionCreateSessionGroupIdBody: Codable, Sendable, Equatable {
    public var `appId`: String
    public var `appContext`: String
    public var `accountId`: String?
    public var `customData`: String?
    public init(`appId`: String, `appContext`: String, `accountId`: String? = nil, `customData`: String? = nil) {
        self.`appId` = `appId`
        self.`appContext` = `appContext`
        self.`accountId` = `accountId`
        self.`customData` = `customData`
    }
}

public struct Household: Codable, Sendable, Equatable {
    public var `id`: String
    public var `name`: String?
    public var `swVersion`: String?
    public var `ownerLuid`: String?
    public init(`id`: String, `name`: String? = nil, `swVersion`: String? = nil, `ownerLuid`: String? = nil) {
        self.`id` = `id`
        self.`name` = `name`
        self.`swVersion` = `swVersion`
        self.`ownerLuid` = `ownerLuid`
    }
}

public struct PlayerVolumeDuckPlayerIdBody: Codable, Sendable, Equatable {
    public var `durationMillis`: Int?
    public init(`durationMillis`: Int? = nil) {
        self.`durationMillis` = `durationMillis`
    }
}

public struct GroupVolume: Codable, Sendable, Equatable {
    public var `volume`: Int
    public var `muted`: Bool?
    public var `fixed`: Bool?
    public init(`volume`: Int, `muted`: Bool? = nil, `fixed`: Bool? = nil) {
        self.`volume` = `volume`
        self.`muted` = `muted`
        self.`fixed` = `fixed`
    }
}

public struct Book: Codable, Sendable, Equatable {
    public var `name`: String
    public var `chapterCount`: Int?
    public var `author`: Artist?
    public var `narrator`: Artist?
    public var `id`: UniversalMusicObjectId?
    public init(`name`: String, `chapterCount`: Int? = nil, `author`: Artist? = nil, `narrator`: Artist? = nil, `id`: UniversalMusicObjectId? = nil) {
        self.`name` = `name`
        self.`chapterCount` = `chapterCount`
        self.`author` = `author`
        self.`narrator` = `narrator`
        self.`id` = `id`
    }
}

public struct SdkVersions: Codable, Sendable, Equatable {
    public var `controlAPI`: [String]
    public var `trueplaySDK`: [String]?
    public var `audioTxProtocol`: [Int]?
    public var `htAudioTxProtocol`: [Int]?
    public init(`controlAPI`: [String], `trueplaySDK`: [String]? = nil, `audioTxProtocol`: [Int]? = nil, `htAudioTxProtocol`: [Int]? = nil) {
        self.`controlAPI` = `controlAPI`
        self.`trueplaySDK` = `trueplaySDK`
        self.`audioTxProtocol` = `audioTxProtocol`
        self.`htAudioTxProtocol` = `htAudioTxProtocol`
    }
}

public struct GroupVolumeSetRelativeVolumeGroupIdBody: Codable, Sendable, Equatable {
    public var `volumeDelta`: Int
    public init(`volumeDelta`: Int) {
        self.`volumeDelta` = `volumeDelta`
    }
}

public struct PlayerVolumeSetMutePlayerIdBody: Codable, Sendable, Equatable {
    public var `muted`: Bool
    public init(`muted`: Bool) {
        self.`muted` = `muted`
    }
}

public struct TrackQuality: Codable, Sendable, Equatable {
    public var `bitDepth`: Int?
    public var `sampleRate`: Int?
    public var `codec`: String?
    public var `lossless`: Bool?
    public var `immersive`: Bool?
    public init(`bitDepth`: Int? = nil, `sampleRate`: Int? = nil, `codec`: String? = nil, `lossless`: Bool? = nil, `immersive`: Bool? = nil) {
        self.`bitDepth` = `bitDepth`
        self.`sampleRate` = `sampleRate`
        self.`codec` = `codec`
        self.`lossless` = `lossless`
        self.`immersive` = `immersive`
    }
}

public struct Container: Codable, Sendable, Equatable {
    public var `name`: String?
    public var `type`: String?
    public var `id`: UniversalMusicObjectId?
    public var `service`: Service?
    public var `book`: Book?
    public var `podcast`: Podcast?
    public var `imageUrl`: String?
    public var `tags`: [TagsData]?
    public init(`name`: String? = nil, `type`: String? = nil, `id`: UniversalMusicObjectId? = nil, `service`: Service? = nil, `book`: Book? = nil, `podcast`: Podcast? = nil, `imageUrl`: String? = nil, `tags`: [TagsData]? = nil) {
        self.`name` = `name`
        self.`type` = `type`
        self.`id` = `id`
        self.`service` = `service`
        self.`book` = `book`
        self.`podcast` = `podcast`
        self.`imageUrl` = `imageUrl`
        self.`tags` = `tags`
    }
}

public struct GroupsCreateGroupHouseholdIdBody: Codable, Sendable, Equatable {
    public var `playerIds`: [String]
    public var `musicContextGroupId`: String?
    public var `areaIds`: [String]?
    public init(`playerIds`: [String], `musicContextGroupId`: String? = nil, `areaIds`: [String]? = nil) {
        self.`playerIds` = `playerIds`
        self.`musicContextGroupId` = `musicContextGroupId`
        self.`areaIds` = `areaIds`
    }
}

public struct Service: Codable, Sendable, Equatable {
    public var `name`: String?
    public var `id`: String?
    public var `imageUrl`: String?
    public init(`name`: String? = nil, `id`: String? = nil, `imageUrl`: String? = nil) {
        self.`name` = `name`
        self.`id` = `id`
        self.`imageUrl` = `imageUrl`
    }
}

public struct PlaybackPolicy: Codable, Sendable, Equatable {
    public var `canSkip`: Bool?
    public var `canSkipBack`: Bool?
    public var `canSkipToPrevious`: Bool?
    public var `limitedSkips`: Bool?
    public var `canSeek`: Bool?
    public var `canSkipToItem`: Bool?
    public var `canRepeat`: Bool?
    public var `canRepeatOne`: Bool?
    public var `canCrossfade`: Bool?
    public var `canShuffle`: Bool?
    public var `canResume`: Bool?
    public var `pauseAtEndOfQueue`: Bool?
    public var `refreshAuthWhilePaused`: Bool?
    public var `showNNextTracks`: Int?
    public var `showNPreviousTracks`: Int?
    public var `isVisible`: Bool?
    public var `notifyUserIntent`: Bool?
    public var `pauseTtlSec`: Int?
    public var `playTtlSec`: Int?
    public var `pauseOnDuck`: Bool?
    public var `skipsRemaining`: Int?
    public init(`canSkip`: Bool? = nil, `canSkipBack`: Bool? = nil, `canSkipToPrevious`: Bool? = nil, `limitedSkips`: Bool? = nil, `canSeek`: Bool? = nil, `canSkipToItem`: Bool? = nil, `canRepeat`: Bool? = nil, `canRepeatOne`: Bool? = nil, `canCrossfade`: Bool? = nil, `canShuffle`: Bool? = nil, `canResume`: Bool? = nil, `pauseAtEndOfQueue`: Bool? = nil, `refreshAuthWhilePaused`: Bool? = nil, `showNNextTracks`: Int? = nil, `showNPreviousTracks`: Int? = nil, `isVisible`: Bool? = nil, `notifyUserIntent`: Bool? = nil, `pauseTtlSec`: Int? = nil, `playTtlSec`: Int? = nil, `pauseOnDuck`: Bool? = nil, `skipsRemaining`: Int? = nil) {
        self.`canSkip` = `canSkip`
        self.`canSkipBack` = `canSkipBack`
        self.`canSkipToPrevious` = `canSkipToPrevious`
        self.`limitedSkips` = `limitedSkips`
        self.`canSeek` = `canSeek`
        self.`canSkipToItem` = `canSkipToItem`
        self.`canRepeat` = `canRepeat`
        self.`canRepeatOne` = `canRepeatOne`
        self.`canCrossfade` = `canCrossfade`
        self.`canShuffle` = `canShuffle`
        self.`canResume` = `canResume`
        self.`pauseAtEndOfQueue` = `pauseAtEndOfQueue`
        self.`refreshAuthWhilePaused` = `refreshAuthWhilePaused`
        self.`showNNextTracks` = `showNNextTracks`
        self.`showNPreviousTracks` = `showNPreviousTracks`
        self.`isVisible` = `isVisible`
        self.`notifyUserIntent` = `notifyUserIntent`
        self.`pauseTtlSec` = `pauseTtlSec`
        self.`playTtlSec` = `playTtlSec`
        self.`pauseOnDuck` = `pauseOnDuck`
        self.`skipsRemaining` = `skipsRemaining`
    }
}

public struct GroupsSetGroupMembersGroupIdBody: Codable, Sendable, Equatable {
    public var `playerIds`: [String]?
    public var `areaIds`: [String]?
    public init(`playerIds`: [String]? = nil, `areaIds`: [String]? = nil) {
        self.`playerIds` = `playerIds`
        self.`areaIds` = `areaIds`
    }
}

public struct PlayerSetError: Codable, Sendable, Equatable {
    public var `errorCode`: String?
    public var `reason`: String?
    public var `playerIds`: [String]
    public init(`errorCode`: String? = nil, `reason`: String? = nil, `playerIds`: [String]) {
        self.`errorCode` = `errorCode`
        self.`reason` = `reason`
        self.`playerIds` = `playerIds`
    }
}

public struct Artist: Codable, Sendable, Equatable {
    public var `name`: String
    public var `id`: UniversalMusicObjectId?
    public var `tags`: [TagsData]?
    public init(`name`: String, `id`: UniversalMusicObjectId? = nil, `tags`: [TagsData]? = nil) {
        self.`name` = `name`
        self.`id` = `id`
        self.`tags` = `tags`
    }
}

public struct Group: Codable, Sendable, Equatable {
    public var `id`: String
    public var `name`: String
    public var `coordinatorId`: String
    public var `playbackState`: PlaybackState?
    public var `playerIds`: [String]
    public var `areaIds`: [String]?
    public init(`id`: String, `name`: String, `coordinatorId`: String, `playbackState`: PlaybackState? = nil, `playerIds`: [String], `areaIds`: [String]? = nil) {
        self.`id` = `id`
        self.`name` = `name`
        self.`coordinatorId` = `coordinatorId`
        self.`playbackState` = `playbackState`
        self.`playerIds` = `playerIds`
        self.`areaIds` = `areaIds`
    }
}

public struct UniversalMusicObjectId: Codable, Sendable, Equatable {
    public var `serviceId`: String?
    public var `objectId`: String
    public var `accountId`: String?
    public init(`serviceId`: String? = nil, `objectId`: String, `accountId`: String? = nil) {
        self.`serviceId` = `serviceId`
        self.`objectId` = `objectId`
        self.`accountId` = `accountId`
    }
}

public struct FavoritesLoadFavoriteGroupIdBody: Codable, Sendable, Equatable {
    public var `favoriteId`: String
    public var `action`: QueueAction?
    public var `playModes`: PlayMode?
    public var `playOnCompletion`: Bool?
    public init(`favoriteId`: String, `action`: QueueAction? = nil, `playModes`: PlayMode? = nil, `playOnCompletion`: Bool? = nil) {
        self.`favoriteId` = `favoriteId`
        self.`action` = `action`
        self.`playModes` = `playModes`
        self.`playOnCompletion` = `playOnCompletion`
    }
}

public struct PlaybackSessionSuspendSessionIdBody: Codable, Sendable, Equatable {
    public var `queueVersion`: String?
    public init(`queueVersion`: String? = nil) {
        self.`queueVersion` = `queueVersion`
    }
}

public struct Ok: Codable, Sendable, Equatable {

    public init() {

    }
}

public struct RadioShow: Codable, Sendable, Equatable {
    public var `name`: String
    public var `id`: UniversalMusicObjectId?
    public var `imageUrl`: String?
    public var `tags`: [TagsData]?
    public init(`name`: String, `id`: UniversalMusicObjectId? = nil, `imageUrl`: String? = nil, `tags`: [TagsData]? = nil) {
        self.`name` = `name`
        self.`id` = `id`
        self.`imageUrl` = `imageUrl`
        self.`tags` = `tags`
    }
}

public struct PlaybackSeekRelativeGroupIdBody: Codable, Sendable, Equatable {
    public var `itemId`: String?
    public var `deltaMillis`: Int
    public init(`itemId`: String? = nil, `deltaMillis`: Int) {
        self.`itemId` = `itemId`
        self.`deltaMillis` = `deltaMillis`
    }
}

public struct PlaybackSessionLoadStreamUrlSessionIdBody: Codable, Sendable, Equatable {
    public var `streamUrl`: String
    public var `playOnCompletion`: Bool?
    public var `stationMetadata`: Container?
    public var `itemId`: String?
    public init(`streamUrl`: String, `playOnCompletion`: Bool? = nil, `stationMetadata`: Container? = nil, `itemId`: String? = nil) {
        self.`streamUrl` = `streamUrl`
        self.`playOnCompletion` = `playOnCompletion`
        self.`stationMetadata` = `stationMetadata`
        self.`itemId` = `itemId`
    }
}
