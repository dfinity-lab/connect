import Array "mo:stdlib/array";
import Nat "mo:stdlib/nat";
import Option "mo:stdlib/option";

import Database "./database";
import Types "./types";

module {
  type NewProfile = Types.NewProfile;
  type Profile = Types.Profile;
  type UserId = Types.UserId;

  // Profiles
  public func getProfile(directory: Database.Directory, userId: UserId): Profile {
    let existing = directory.findOne(userId);
    switch (existing) {
      case (?existing) { existing };
      case (null) {
        {
          id = userId;
          firstName = "";
          lastName = "";
          title = "";
          company = "";
          experience = "";
          education = "";
          imgUrl = "";
        }
      };
    };
  };

  // Connections

  public func includes(x: UserId, xs: [UserId]): Bool {
    func isX(y: UserId): Bool { x == y };
    switch (Array.find<UserId>(isX, xs)) {
      case (null) { false };
      case (_) { true };
    };
  };

  // Authorization

  let adminIds: [UserId] = [];

  public func isAdmin(userId: UserId): Bool {
    func identity(x: UserId): Bool { x == userId };
    Option.isSome(Array.find<UserId>(identity, adminIds))
  };

  public func hasAccess(userId: UserId, profile: Profile): Bool {
    userId == profile.id or isAdmin(userId)
  };
};
