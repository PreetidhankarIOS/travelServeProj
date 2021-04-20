//
//  ChatViewModel.swift
//  ChatBubble
//
//  Created by Rahul kr on 06/06/18.
//

import Foundation

protocol ChatViewDelegate
{
    func onItemAdded() -> ()
}

protocol ChatViewPresentable
{
    var newchat: String? {get}
}

class ChatViewModel: ChatViewPresentable {
    
    var chats: [Chat] = []
    var newchat: String?
    var timechat: String?
    weak var viewc: ChatViewControllerDelegate?
    
    
    init(view: ChatViewControllerDelegate) {
//        sender receiver
        viewc = view
        let chat1 = Chat(arg_user: "1", arg_pic: "", arg_message: "Hi", chatTime: "")
        let chat2 = Chat(arg_user: "2", arg_pic: "", arg_message: "Hi", chatTime: "")

        chats.append(contentsOf: [chat1,chat2])
    }
    
    deinit {
        print("ChatViewModel de-initialized")
    }
}

extension ChatViewModel: ChatViewDelegate
{
    func onItemAdded() {
        
//        chats.append(Chat(arg_user: "", arg_pic: "", arg_message: newchatBYPreeto!))
        chats.append(Chat(arg_user: "", arg_pic: "", arg_message: newchat!, chatTime: timechat!))
        
        viewc?.didNewChatMessagesRecieved()
    }
}


class Chat {
    
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
