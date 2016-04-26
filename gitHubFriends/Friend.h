//
//  Friend.h
//  gitHubFriends
//
//  Created by Nick Perkins on 4/25/16.
//  Copyright © 2016 Nick Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property (nonatomic) NSString *gitRepoName;
//THESE ARE A FUTURE FEATURE IF I DO NOT COMPLETE THE HOMEWORK IN TIME
//@property (nonatomic) NSString *gitUserAvatar;
//@property (nonatomic) NSString *gitUserName;
//@property (nonatomic) NSString *gitUserEmail;
//@property (nonatomic) NSString *gitUserLogin;
//@property (nonatomic) NSString *gitUserLocation;
//@property (nonatomic) NSString *gitUserHtmlUrl;
//@property (nonatomic) NSString *gitUserPublicGits;
//@property (nonatomic) NSString *gitUserPublicRepos;
//@property (nonatomic) NSString *gitUserHireable;

+ (Friend *)friendWithDictionary:(NSDictionary *)gitFriendDict;

@end
