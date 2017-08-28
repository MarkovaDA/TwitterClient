//
//  UserTimlinePresenter.swift
//  TwitterClient
//
//  Created by Radwa on 8/26/17.
//  Copyright © 2017 Eventus. All rights reserved.
//

import Foundation
import TwitterKit

class UserTimlinePresenter  {
    
    private let accessLayer:AccessLayer
    weak private var userTimelineView : UserTimelineView?
    
    init(service:AccessLayer){
        self.accessLayer = service
    }
    
    func attachView(view:UserTimelineView){
        userTimelineView = view
    }
    
    
    func getTimlineData(userId:String) {
        
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            
            let client = TWTRAPIClient(userID: userID)
            
            AccessLayer.apiGetUserTimline(parameters: ["id": userId, "count": "10"], twitterClient: client, sucess: { (suc, tweetsSuc) in
                
                print("✅ \(suc.count)")
                
                self.userTimelineView?.sentSuccess(userTimlineData: suc, tweetsData: tweetsSuc)
                
            }, failure: { (err) in
                
                self.userTimelineView?.sentFailed(error: err!)
                
            }, noInternet: { (noInternet) in
                print("❌❌❌ no Internet in getTimlineData")
                
                self.userTimelineView?.sentFailed(error: "The Internet connection appears to be offline")
                
            })
            
        }
        
    }
    
    
}
