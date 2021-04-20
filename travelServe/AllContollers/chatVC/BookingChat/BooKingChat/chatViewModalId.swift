//
//  chatViewModalId.swift
//  travelServe
//
//  Created by Developer on 21/10/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation

protocol ChatViewDelegateId
{
    func onItemAdded() -> ()
}

protocol ChatViewPresentableID
{
    var newchat: String? {get}
}

class chatViewModalId: ChatViewPresentableID {
    
    var chatss: [Chate] = []
    var newchat: String?
    var timechat: String?
    weak var viewc: ChatViewControllerDelegateID?
    
    
    init(view: ChatViewControllerDelegateID) {
//        sender receiver
        viewc = view
        let chat1 = Chate(arg_user: "1", arg_pic: "", arg_message: "Hi", chatTime: "")
        let chat2 = Chate(arg_user: "2", arg_pic: "", arg_message: "Hi", chatTime: "")

        chatss.append(contentsOf: [chat1,chat2])
    }
    
    deinit {
        print("ChatViewModel de-initialized")
    }
}

extension chatViewModalId: ChatViewDelegateId
{
    func onItemAdded() {
        
//        chats.append(Chat(arg_user: "", arg_pic: "", arg_message: newchatBYPreeto!))
        chatss.append(Chate(arg_user: "", arg_pic: "", arg_message: newchat!, chatTime: timechat!))
        
        viewc?.didNewChatMessagesRecieved()
    }
}


class Chate {
    
    var chatUser: String?
    var chatUser_Pic: String? // Profile pic url
    var chatMessage: String?
    var ChatTime: String?
    
    init(arg_user:String,arg_pic: String,arg_message:String,chatTime:String) {
        
        chatUser = arg_user
        chatUser_Pic = arg_pic
        chatMessage = arg_message
        ChatTime = chatTime
    }
    
    deinit {
        print("Chat Model de-initialized")
    }
    
}
