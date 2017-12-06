//
//  SwiftMessagesExtensions.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 06/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import Foundation
import SwiftMessages

extension SwiftMessages {
    
    public static func infoMessage(title: String, body: String) {
        SwiftMessages.message(title: title, body: body, theme: .info)
    }
    
    public static func errorMessage(title: String, body: String) {
        SwiftMessages.message(title: title, body: body, theme: .error)
    }
    
    public static func message(title: String, body: String, theme: Theme) {
        let view = MessageView.viewFromNib(layout: MessageView.Layout.cardView)
        view.configureContent(title: title, body: body)
        view.button?.isHidden = true
        view.configureTheme(theme)
        view.configureDropShadow()
        SwiftMessages.show(view: view)
    }
    
}
