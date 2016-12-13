//
//  SourceEditorCommand.swift
//  EnlightExtension
//
//  Created by Alexandru Culeva on 11/23/16.
//  Copyright © 2016 Alexandru Culeva. All rights reserved.
//

import Foundation
import XcodeKit
import Enlight

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        let parser = Parser(source: invocation.buffer.completeBuffer)
        let extensionString = parser.string
        let lines = extensionString.characters.split(separator: "\n").map(String.init)
        invocation.buffer.lines.addObjects(from: ["", ""] + lines)
        
        completionHandler(nil)
    }
}
