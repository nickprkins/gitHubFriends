//
//  Friend.m
//  gitHubFriends
//
//  Created by Nick Perkins on 4/25/16.
//  Copyright © 2016 Nick Perkins. All rights reserved.
//

#import "Friend.h"

@implementation Friend


+ (Friend *)friendWithDictionary:(NSDictionary *)gitFriendDict
{
    Friend *aFriend = nil;
    if (gitFriendDict)
    {
        aFriend = [[Friend alloc] init];
        aFriend.gitRepoName = [gitFriendDict objectForKey:@"name"];
//        aFriend.gitUserName = [gitFriendDict objectForKey:@"login"];
//        aFriend.gitUserEmail = [gitFriendDict objectForKey:@"email"];
//        aFriend.gitUserAvatar = [gitFriendDict objectForKey:@"avatar_url"];
    }
    return aFriend;
}


@end
