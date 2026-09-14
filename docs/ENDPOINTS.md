# Control API coverage

Reconciled with the official Sonos reference on 2026-09-14. Implemented request factories and schema-based response models; hardware integration remains unverified. OAuth secret exchange belongs to a server, not this client package. Cloud Queue hosting and SMAPI are out of scope.

| Factory | Request | Source |
| --- | --- | --- |
| `favoritesLoadFavoriteGroupId` | POST `/groups/{groupId}/favorites` | [favorites-loadfavorite-groupid](https://docs.sonos.com/reference/favorites-loadfavorite-groupid.md) |
| `groupVolumeGetVolumeGroupId` | GET `/groups/{groupId}/groupVolume` | [groupvolume-getvolume-groupid](https://docs.sonos.com/reference/groupvolume-getvolume-groupid.md) |
| `groupVolumeSetVolumeGroupId` | POST `/groups/{groupId}/groupVolume` | [groupvolume-setvolume-groupid](https://docs.sonos.com/reference/groupvolume-setvolume-groupid.md) |
| `groupVolumeSetMuteGroupId` | POST `/groups/{groupId}/groupVolume/mute` | [groupvolume-setmute-groupid](https://docs.sonos.com/reference/groupvolume-setmute-groupid.md) |
| `groupVolumeSetRelativeVolumeGroupId` | POST `/groups/{groupId}/groupVolume/relative` | [groupvolume-setrelativevolume-groupid](https://docs.sonos.com/reference/groupvolume-setrelativevolume-groupid.md) |
| `groupVolumeUnsubscribeGroupId` | DELETE `/groups/{groupId}/groupVolume/subscription` | [groupvolume-unsubscribe-groupid](https://docs.sonos.com/reference/groupvolume-unsubscribe-groupid.md) |
| `groupVolumeSubscribeGroupId` | POST `/groups/{groupId}/groupVolume/subscription` | [groupvolume-subscribe-groupid](https://docs.sonos.com/reference/groupvolume-subscribe-groupid.md) |
| `groupsModifyGroupMembersGroupId` | POST `/groups/{groupId}/groups/modifyGroupMembers` | [groups-modifygroupmembers-groupid](https://docs.sonos.com/reference/groups-modifygroupmembers-groupid.md) |
| `groupsSetGroupMembersGroupId` | POST `/groups/{groupId}/groups/setGroupMembers` | [groups-setgroupmembers-groupid](https://docs.sonos.com/reference/groups-setgroupmembers-groupid.md) |
| `playbackGetPlaybackStatusGroupId` | GET `/groups/{groupId}/playback` | [playback-getplaybackstatus-groupid](https://docs.sonos.com/reference/playback-getplaybackstatus-groupid.md) |
| `playbackLoadLineInGroupId` | POST `/groups/{groupId}/playback/lineIn` | [playback-loadlinein-groupid](https://docs.sonos.com/reference/playback-loadlinein-groupid.md) |
| `playbackPauseGroupId` | POST `/groups/{groupId}/playback/pause` | [playback-pause-groupid](https://docs.sonos.com/reference/playback-pause-groupid.md) |
| `playbackPlayGroupId` | POST `/groups/{groupId}/playback/play` | [playback-play-groupid](https://docs.sonos.com/reference/playback-play-groupid.md) |
| `playbackSetPlayModesGroupId` | POST `/groups/{groupId}/playback/playMode` | [playback-setplaymodes-groupid](https://docs.sonos.com/reference/playback-setplaymodes-groupid.md) |
| `playbackSeekGroupId` | POST `/groups/{groupId}/playback/seek` | [playback-seek-groupid](https://docs.sonos.com/reference/playback-seek-groupid.md) |
| `playbackSeekRelativeGroupId` | POST `/groups/{groupId}/playback/seekRelative` | [playback-seekrelative-groupid](https://docs.sonos.com/reference/playback-seekrelative-groupid.md) |
| `playbackSkipToNextTrackGroupId` | POST `/groups/{groupId}/playback/skipToNextTrack` | [playback-skiptonexttrack-groupid](https://docs.sonos.com/reference/playback-skiptonexttrack-groupid.md) |
| `playbackSkipToPreviousTrackGroupId` | POST `/groups/{groupId}/playback/skipToPreviousTrack` | [playback-skiptoprevioustrack-groupid](https://docs.sonos.com/reference/playback-skiptoprevioustrack-groupid.md) |
| `playbackUnsubscribeGroupId` | DELETE `/groups/{groupId}/playback/subscription` | [playback-unsubscribe-groupid](https://docs.sonos.com/reference/playback-unsubscribe-groupid.md) |
| `playbackSubscribeGroupId` | POST `/groups/{groupId}/playback/subscription` | [playback-subscribe-groupid](https://docs.sonos.com/reference/playback-subscribe-groupid.md) |
| `playbackTogglePlayPauseGroupId` | POST `/groups/{groupId}/playback/togglePlayPause` | [playback-toggleplaypause-groupid](https://docs.sonos.com/reference/playback-toggleplaypause-groupid.md) |
| `playbackMetadataGetMetadataStatusGroupId` | GET `/groups/{groupId}/playbackMetadata` | [playbackmetadata-getmetadatastatus-groupid](https://docs.sonos.com/reference/playbackmetadata-getmetadatastatus-groupid.md) |
| `playbackMetadataUnsubscribeGroupId` | DELETE `/groups/{groupId}/playbackMetadata/subscription` | [playbackmetadata-unsubscribe-groupid](https://docs.sonos.com/reference/playbackmetadata-unsubscribe-groupid.md) |
| `playbackMetadataSubscribeGroupId` | POST `/groups/{groupId}/playbackMetadata/subscription` | [playbackmetadata-subscribe-groupid](https://docs.sonos.com/reference/playbackmetadata-subscribe-groupid.md) |
| `playbackSessionCreateSessionGroupId` | POST `/groups/{groupId}/playbackSession` | [playbacksession-createsession-groupid](https://docs.sonos.com/reference/playbacksession-createsession-groupid.md) |
| `playlistsLoadPlaylistGroupId` | POST `/groups/{groupId}/playlists` | [playlists-loadplaylist-groupid](https://docs.sonos.com/reference/playlists-loadplaylist-groupid.md) |
| `householdsGetHouseholds` | GET `/households` | [households-gethouseholds](https://docs.sonos.com/reference/households-gethouseholds.md) |
| `householdsGetHousehold` | GET `/households/{householdId}` | [households-gethousehold](https://docs.sonos.com/reference/households-gethousehold.md) |
| `favoritesGetFavoritesHouseholdId` | GET `/households/{householdId}/favorites` | [favorites-getfavorites-householdid](https://docs.sonos.com/reference/favorites-getfavorites-householdid.md) |
| `favoritesUnsubscribeHouseholdId` | DELETE `/households/{householdId}/favorites/subscription` | [favorites-unsubscribe-householdid](https://docs.sonos.com/reference/favorites-unsubscribe-householdid.md) |
| `favoritesSubscribeHouseholdId` | POST `/households/{householdId}/favorites/subscription` | [favorites-subscribe-householdid](https://docs.sonos.com/reference/favorites-subscribe-householdid.md) |
| `groupsGetGroupsHouseholdId` | GET `/households/{householdId}/groups` | [groups-getgroups-householdid](https://docs.sonos.com/reference/groups-getgroups-householdid.md) |
| `groupsCreateGroupHouseholdId` | POST `/households/{householdId}/groups/createGroup` | [groups-creategroup-householdid](https://docs.sonos.com/reference/groups-creategroup-householdid.md) |
| `groupsUnsubscribeHouseholdId` | DELETE `/households/{householdId}/groups/subscription` | [groups-unsubscribe-householdid](https://docs.sonos.com/reference/groups-unsubscribe-householdid.md) |
| `groupsSubscribeHouseholdId` | POST `/households/{householdId}/groups/subscription` | [groups-subscribe-householdid](https://docs.sonos.com/reference/groups-subscribe-householdid.md) |
| `musicServiceAccountsMatchHouseholdId` | POST `/households/{householdId}/musicServiceAccounts/match` | [musicserviceaccounts-match-householdid](https://docs.sonos.com/reference/musicserviceaccounts-match-householdid.md) |
| `playlistsGetPlaylistsHouseholdId` | GET `/households/{householdId}/playlists` | [playlists-getplaylists-householdid](https://docs.sonos.com/reference/playlists-getplaylists-householdid.md) |
| `playlistsUnsubscribeHouseholdId` | DELETE `/households/{householdId}/playlists/subscription` | [playlists-unsubscribe-householdid](https://docs.sonos.com/reference/playlists-unsubscribe-householdid.md) |
| `playlistsSubscribeHouseholdId` | POST `/households/{householdId}/playlists/subscription` | [playlists-subscribe-householdid](https://docs.sonos.com/reference/playlists-subscribe-householdid.md) |
| `playbackSessionLoadCloudQueueSessionId` | POST `/playbackSessions/{sessionId}/playbackSession/loadCloudQueue` | [playbacksession-loadcloudqueue-sessionid](https://docs.sonos.com/reference/playbacksession-loadcloudqueue-sessionid.md) |
| `playbackSessionLoadStreamUrlSessionId` | POST `/playbackSessions/{sessionId}/playbackSession/loadStreamUrl` | [playbacksession-loadstreamurl-sessionid](https://docs.sonos.com/reference/playbacksession-loadstreamurl-sessionid.md) |
| `playbackSessionRefreshCloudQueueSessionId` | POST `/playbackSessions/{sessionId}/playbackSession/refreshCloudQueue` | [playbacksession-refreshcloudqueue-sessionid](https://docs.sonos.com/reference/playbacksession-refreshcloudqueue-sessionid.md) |
| `playbackSessionSeekSessionId` | POST `/playbackSessions/{sessionId}/playbackSession/seek` | [playbacksession-seek-sessionid](https://docs.sonos.com/reference/playbacksession-seek-sessionid.md) |
| `playbackSessionSeekRelativeSessionId` | POST `/playbackSessions/{sessionId}/playbackSession/seekRelative` | [playbacksession-seekrelative-sessionid](https://docs.sonos.com/reference/playbacksession-seekrelative-sessionid.md) |
| `playbackSessionSkipToItemSessionId` | POST `/playbackSessions/{sessionId}/playbackSession/skipToItem` | [playbacksession-skiptoitem-sessionid](https://docs.sonos.com/reference/playbacksession-skiptoitem-sessionid.md) |
| `playbackSessionUnsubscribeSessionId` | DELETE `/playbackSessions/{sessionId}/playbackSession/subscription` | [playbacksession-unsubscribe-sessionid](https://docs.sonos.com/reference/playbacksession-unsubscribe-sessionid.md) |
| `playbackSessionSubscribeSessionId` | POST `/playbackSessions/{sessionId}/playbackSession/subscription` | [playbacksession-subscribe-sessionid](https://docs.sonos.com/reference/playbacksession-subscribe-sessionid.md) |
| `playbackSessionSuspendSessionId` | POST `/playbackSessions/{sessionId}/playbackSession/suspend` | [playbacksession-suspend-sessionid](https://docs.sonos.com/reference/playbacksession-suspend-sessionid.md) |
| `audioClipLoadAudioClipPlayerId` | POST `/players/{playerId}/audioClip` | [audioclip-loadaudioclip-playerid](https://docs.sonos.com/reference/audioclip-loadaudioclip-playerid.md) |
| `audioClipUnsubscribePlayerId` | DELETE `/players/{playerId}/audioClip/subscription` | [audioclip-unsubscribe-playerid](https://docs.sonos.com/reference/audioclip-unsubscribe-playerid.md) |
| `audioClipSubscribePlayerId` | POST `/players/{playerId}/audioClip/subscription` | [audioclip-subscribe-playerid](https://docs.sonos.com/reference/audioclip-subscribe-playerid.md) |
| `homeTheaterGetOptionsPlayerId` | GET `/players/{playerId}/homeTheater/options` | [hometheater-getoptions-playerid](https://docs.sonos.com/reference/hometheater-getoptions-playerid.md) |
| `homeTheaterSetOptionsPlayerId` | POST `/players/{playerId}/homeTheater/options` | [hometheater-setoptions-playerid](https://docs.sonos.com/reference/hometheater-setoptions-playerid.md) |
| `playerVolumeGetVolumePlayerId` | GET `/players/{playerId}/playerVolume` | [playervolume-getvolume-playerid](https://docs.sonos.com/reference/playervolume-getvolume-playerid.md) |
| `playerVolumeSetVolumePlayerId` | POST `/players/{playerId}/playerVolume` | [playervolume-setvolume-playerid](https://docs.sonos.com/reference/playervolume-setvolume-playerid.md) |
| `playerVolumeDuckPlayerId` | POST `/players/{playerId}/playerVolume/duck` | [playervolume-duck-playerid](https://docs.sonos.com/reference/playervolume-duck-playerid.md) |
| `playerVolumeSetMutePlayerId` | POST `/players/{playerId}/playerVolume/mute` | [playervolume-setmute-playerid](https://docs.sonos.com/reference/playervolume-setmute-playerid.md) |
| `playerVolumeSetRelativeVolumePlayerId` | POST `/players/{playerId}/playerVolume/relative` | [playervolume-setrelativevolume-playerid](https://docs.sonos.com/reference/playervolume-setrelativevolume-playerid.md) |
| `playerVolumeUnsubscribePlayerId` | DELETE `/players/{playerId}/playerVolume/subscription` | [playervolume-unsubscribe-playerid](https://docs.sonos.com/reference/playervolume-unsubscribe-playerid.md) |
| `playerVolumeSubscribePlayerId` | POST `/players/{playerId}/playerVolume/subscription` | [playervolume-subscribe-playerid](https://docs.sonos.com/reference/playervolume-subscribe-playerid.md) |
| `playerVolumeUnduckPlayerId` | POST `/players/{playerId}/playerVolume/unduck` | [playervolume-unduck-playerid](https://docs.sonos.com/reference/playervolume-unduck-playerid.md) |

Legacy player settings, TV-power/load-home-theater, getPlaylist, audioClip cancel, and playbackSession join/joinOrCreate wrappers have no matching endpoint in the current retrieved reference and are not advertised as supported. setGroupMembers now targets groupId, player mute uses /mute, and createSession uses /playbackSession. See LEGACY_ENDPOINTS for every old class.
