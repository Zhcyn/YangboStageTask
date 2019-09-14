//
//  ErrorMessages.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/10/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

enum ErrorMessages: String {
    case messageIsNil = "Message is nullable"
    case denied = "Application Not Allowed to Display Notifications"
    case cannotSendEmail = "Your device does not support sending mail feature"
    case sendEmailSuccess = "Send mail successful!"
    case sendEmailFail = "Send mail failed! Please try again."
}
