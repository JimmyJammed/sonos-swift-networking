import Foundation

public enum Endpoints {
    public static func favoritesLoadFavoriteGroupId(groupId: String, body: FavoritesLoadFavoriteGroupIdBody) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "favorites"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func groupVolumeGetVolumeGroupId(groupId: String) throws -> Endpoint<GroupVolume> {
        Endpoint(segments: ["groups", groupId, "groupVolume"], method: "GET", body: nil)
    }
    public static func groupVolumeSetVolumeGroupId(groupId: String, body: GroupVolumeSetVolumeGroupIdBody) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "groupVolume"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func groupVolumeSetMuteGroupId(groupId: String, body: GroupVolumeSetMuteGroupIdBody) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "groupVolume", "mute"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func groupVolumeSetRelativeVolumeGroupId(groupId: String, body: GroupVolumeSetRelativeVolumeGroupIdBody) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "groupVolume", "relative"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func groupVolumeUnsubscribeGroupId(groupId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "groupVolume", "subscription"], method: "DELETE", body: nil)
    }
    public static func groupVolumeSubscribeGroupId(groupId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "groupVolume", "subscription"], method: "POST", body: nil)
    }
    public static func groupsModifyGroupMembersGroupId(groupId: String, body: GroupsModifyGroupMembersGroupIdBody) throws -> Endpoint<GroupInfo> {
        Endpoint(segments: ["groups", groupId, "groups", "modifyGroupMembers"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func groupsSetGroupMembersGroupId(groupId: String, body: GroupsSetGroupMembersGroupIdBody) throws -> Endpoint<GroupInfo> {
        Endpoint(segments: ["groups", groupId, "groups", "setGroupMembers"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func playbackGetPlaybackStatusGroupId(groupId: String) throws -> Endpoint<PlaybackStatus> {
        Endpoint(segments: ["groups", groupId, "playback"], method: "GET", body: nil)
    }
    public static func playbackLoadLineInGroupId(groupId: String, body: PlaybackLoadLineInGroupIdBody) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "playback", "lineIn"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func playbackPauseGroupId(groupId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "playback", "pause"], method: "POST", body: nil)
    }
    public static func playbackPlayGroupId(groupId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "playback", "play"], method: "POST", body: nil)
    }
    public static func playbackSetPlayModesGroupId(groupId: String, body: PlaybackSetPlayModesGroupIdBody) throws -> Endpoint<EmptyResponse> {
        Endpoint(segments: ["groups", groupId, "playback", "playMode"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func playbackSeekGroupId(groupId: String, body: PlaybackSeekGroupIdBody) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "playback", "seek"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func playbackSeekRelativeGroupId(groupId: String, body: PlaybackSeekRelativeGroupIdBody) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "playback", "seekRelative"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func playbackSkipToNextTrackGroupId(groupId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "playback", "skipToNextTrack"], method: "POST", body: nil)
    }
    public static func playbackSkipToPreviousTrackGroupId(groupId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "playback", "skipToPreviousTrack"], method: "POST", body: nil)
    }
    public static func playbackUnsubscribeGroupId(groupId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "playback", "subscription"], method: "DELETE", body: nil)
    }
    public static func playbackSubscribeGroupId(groupId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "playback", "subscription"], method: "POST", body: nil)
    }
    public static func playbackTogglePlayPauseGroupId(groupId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "playback", "togglePlayPause"], method: "POST", body: nil)
    }
    public static func playbackMetadataGetMetadataStatusGroupId(groupId: String) throws -> Endpoint<MetadataStatus> {
        Endpoint(segments: ["groups", groupId, "playbackMetadata"], method: "GET", body: nil)
    }
    public static func playbackMetadataUnsubscribeGroupId(groupId: String) throws -> Endpoint<EmptyResponse> {
        Endpoint(segments: ["groups", groupId, "playbackMetadata", "subscription"], method: "DELETE", body: nil)
    }
    public static func playbackMetadataSubscribeGroupId(groupId: String) throws -> Endpoint<EmptyResponse> {
        Endpoint(segments: ["groups", groupId, "playbackMetadata", "subscription"], method: "POST", body: nil)
    }
    public static func playbackSessionCreateSessionGroupId(groupId: String, body: PlaybackSessionCreateSessionGroupIdBody) throws -> Endpoint<SessionStatus> {
        Endpoint(segments: ["groups", groupId, "playbackSession"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func playlistsLoadPlaylistGroupId(groupId: String, body: PlaylistsLoadPlaylistGroupIdBody) throws -> Endpoint<Ok> {
        Endpoint(segments: ["groups", groupId, "playlists"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func householdsGetHouseholds() throws -> Endpoint<Households> {
        Endpoint(segments: ["households"], method: "GET", body: nil)
    }
    public static func householdsGetHousehold(householdId: String) throws -> Endpoint<Household> {
        Endpoint(segments: ["households", householdId], method: "GET", body: nil)
    }
    public static func favoritesGetFavoritesHouseholdId(householdId: String) throws -> Endpoint<FavoritesList> {
        Endpoint(segments: ["households", householdId, "favorites"], method: "GET", body: nil)
    }
    public static func favoritesUnsubscribeHouseholdId(householdId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["households", householdId, "favorites", "subscription"], method: "DELETE", body: nil)
    }
    public static func favoritesSubscribeHouseholdId(householdId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["households", householdId, "favorites", "subscription"], method: "POST", body: nil)
    }
    public static func groupsGetGroupsHouseholdId(householdId: String) throws -> Endpoint<Groups> {
        Endpoint(segments: ["households", householdId, "groups"], method: "GET", body: nil)
    }
    public static func groupsCreateGroupHouseholdId(householdId: String, body: GroupsCreateGroupHouseholdIdBody) throws -> Endpoint<GroupInfo> {
        Endpoint(segments: ["households", householdId, "groups", "createGroup"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func groupsUnsubscribeHouseholdId(householdId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["households", householdId, "groups", "subscription"], method: "DELETE", body: nil)
    }
    public static func groupsSubscribeHouseholdId(householdId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["households", householdId, "groups", "subscription"], method: "POST", body: nil)
    }
    public static func musicServiceAccountsMatchHouseholdId(householdId: String, body: MusicServiceAccountsMatchHouseholdIdBody) throws -> Endpoint<MusicServiceAccount> {
        Endpoint(segments: ["households", householdId, "musicServiceAccounts", "match"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func playlistsGetPlaylistsHouseholdId(householdId: String) throws -> Endpoint<PlaylistsList> {
        Endpoint(segments: ["households", householdId, "playlists"], method: "GET", body: nil)
    }
    public static func playlistsUnsubscribeHouseholdId(householdId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["households", householdId, "playlists", "subscription"], method: "DELETE", body: nil)
    }
    public static func playlistsSubscribeHouseholdId(householdId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["households", householdId, "playlists", "subscription"], method: "POST", body: nil)
    }
    public static func playbackSessionLoadCloudQueueSessionId(sessionId: String, body: PlaybackSessionLoadCloudQueueSessionIdBody) throws -> Endpoint<Ok> {
        Endpoint(segments: ["playbackSessions", sessionId, "playbackSession", "loadCloudQueue"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func playbackSessionLoadStreamUrlSessionId(sessionId: String, body: PlaybackSessionLoadStreamUrlSessionIdBody) throws -> Endpoint<Ok> {
        Endpoint(segments: ["playbackSessions", sessionId, "playbackSession", "loadStreamUrl"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func playbackSessionRefreshCloudQueueSessionId(sessionId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["playbackSessions", sessionId, "playbackSession", "refreshCloudQueue"], method: "POST", body: nil)
    }
    public static func playbackSessionSeekSessionId(sessionId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["playbackSessions", sessionId, "playbackSession", "seek"], method: "POST", body: nil)
    }
    public static func playbackSessionSeekRelativeSessionId(sessionId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["playbackSessions", sessionId, "playbackSession", "seekRelative"], method: "POST", body: nil)
    }
    public static func playbackSessionSkipToItemSessionId(sessionId: String, body: PlaybackSessionSkipToItemSessionIdBody) throws -> Endpoint<Ok> {
        Endpoint(segments: ["playbackSessions", sessionId, "playbackSession", "skipToItem"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func playbackSessionUnsubscribeSessionId(sessionId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["playbackSessions", sessionId, "playbackSession", "subscription"], method: "DELETE", body: nil)
    }
    public static func playbackSessionSubscribeSessionId(sessionId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["playbackSessions", sessionId, "playbackSession", "subscription"], method: "POST", body: nil)
    }
    public static func playbackSessionSuspendSessionId(sessionId: String, body: PlaybackSessionSuspendSessionIdBody) throws -> Endpoint<Ok> {
        Endpoint(segments: ["playbackSessions", sessionId, "playbackSession", "suspend"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func audioClipLoadAudioClipPlayerId(playerId: String, body: AudioClipLoadAudioClipPlayerIdBody) throws -> Endpoint<AudioClip> {
        Endpoint(segments: ["players", playerId, "audioClip"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func audioClipUnsubscribePlayerId(playerId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["players", playerId, "audioClip", "subscription"], method: "DELETE", body: nil)
    }
    public static func audioClipSubscribePlayerId(playerId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["players", playerId, "audioClip", "subscription"], method: "POST", body: nil)
    }
    public static func homeTheaterGetOptionsPlayerId(playerId: String) throws -> Endpoint<HomeTheaterOptions> {
        Endpoint(segments: ["players", playerId, "homeTheater", "options"], method: "GET", body: nil)
    }
    public static func homeTheaterSetOptionsPlayerId(playerId: String, body: HomeTheaterSetOptionsPlayerIdBody) throws -> Endpoint<HomeTheaterOptions> {
        Endpoint(segments: ["players", playerId, "homeTheater", "options"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func playerVolumeGetVolumePlayerId(playerId: String) throws -> Endpoint<PlayerVolume> {
        Endpoint(segments: ["players", playerId, "playerVolume"], method: "GET", body: nil)
    }
    public static func playerVolumeSetVolumePlayerId(playerId: String, body: PlayerVolumeSetVolumePlayerIdBody) throws -> Endpoint<Ok> {
        Endpoint(segments: ["players", playerId, "playerVolume"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func playerVolumeDuckPlayerId(playerId: String, body: PlayerVolumeDuckPlayerIdBody) throws -> Endpoint<Ok> {
        Endpoint(segments: ["players", playerId, "playerVolume", "duck"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func playerVolumeSetMutePlayerId(playerId: String, body: PlayerVolumeSetMutePlayerIdBody) throws -> Endpoint<Ok> {
        Endpoint(segments: ["players", playerId, "playerVolume", "mute"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func playerVolumeSetRelativeVolumePlayerId(playerId: String, body: PlayerVolumeSetRelativeVolumePlayerIdBody) throws -> Endpoint<Ok> {
        Endpoint(segments: ["players", playerId, "playerVolume", "relative"], method: "POST", body: try JSONEncoder().encode(body))
    }
    public static func playerVolumeUnsubscribePlayerId(playerId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["players", playerId, "playerVolume", "subscription"], method: "DELETE", body: nil)
    }
    public static func playerVolumeSubscribePlayerId(playerId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["players", playerId, "playerVolume", "subscription"], method: "POST", body: nil)
    }
    public static func playerVolumeUnduckPlayerId(playerId: String) throws -> Endpoint<Ok> {
        Endpoint(segments: ["players", playerId, "playerVolume", "unduck"], method: "POST", body: nil)
    }
}
