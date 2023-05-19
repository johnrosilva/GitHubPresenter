//
//  User.swift
//  GitHubAPIPresenter
//
//  Created by Johnatas Rodrigues on 17/05/23.
//

import Foundation

struct User: Codable, Identifiable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    let url, htmlURL, followersURL: String?
    let followingURL, gistsURL, starredURL: String?
    let subscriptionsURL, organizationsURL, reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let type: String?
    let siteAdmin: Bool?
    let name, company, blog, location: String?
    let email, bio, twitterUsername: String?
    let publicRepos, publicGists, followers, following: Int?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case name, company, blog, location, email, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
    }
    
    init(login: String? = nil,
         id: Int? = nil,
         nodeID: String? = nil,
         avatarURL: String? = nil,
         gravatarID: String? = nil,
         url: String? = nil,
         htmlURL: String? = nil,
         followersURL: String? = nil,
         followingURL: String? = nil,
         gistsURL: String? = nil,
         starredURL: String? = nil,
         subscriptionsURL: String? = nil,
         organizationsURL: String? = nil,
         reposURL: String? = nil,
         eventsURL: String? = nil,
         receivedEventsURL: String? = nil,
         type: String? = nil,
         siteAdmin: Bool? = nil,
         name: String? = nil,
         company: String? = nil,
         blog: String? = nil,
         location: String? = nil,
         email: String? = nil,
         bio: String? = nil,
         twitterUsername: String? = nil,
         publicRepos: Int? = nil,
         publicGists: Int? = nil,
         followers: Int? = nil,
         following: Int? = nil) {
        
        self.login = login
        self.id = id
        self.nodeID = nodeID
        self.avatarURL = avatarURL
        self.gravatarID = gravatarID
        self.url = url
        self.htmlURL = htmlURL
        self.followersURL = followersURL
        self.followingURL = followingURL
        self.gistsURL = gistsURL
        self.starredURL = starredURL
        self.subscriptionsURL = subscriptionsURL
        self.organizationsURL = organizationsURL
        self.reposURL = reposURL
        self.eventsURL = eventsURL
        self.receivedEventsURL = receivedEventsURL
        self.type = type
        self.siteAdmin = siteAdmin
        self.name = name
        self.company = company
        self.blog = blog
        self.location = location
        self.email = email
        self.bio = bio
        self.twitterUsername = twitterUsername
        self.publicRepos = publicRepos
        self.publicGists = publicGists
        self.followers = followers
        self.following = following
    }
}
