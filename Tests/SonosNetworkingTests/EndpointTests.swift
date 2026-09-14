import Foundation
import Testing
@testable import SonosNetworking

@Test func currentGroupAndMutePaths() throws {
    let mute = try Endpoints.playerVolumeSetMutePlayerId(playerId: "p", body: .init(muted: true))
    #expect(mute.segments == ["players", "p", "playerVolume", "mute"])
    #expect(try JSONSerialization.jsonObject(with: mute.body!) as? [String: Bool] == ["muted": true])
    let members = try Endpoints.groupsSetGroupMembersGroupId(groupId: "g", body: .init(playerIds: ["p"]))
    #expect(members.segments == ["groups", "g", "groups", "setGroupMembers"])
}
