//
//  SourceEditorCommand.swift
//  Swiftgeti_Extension
//
//  Created by A_Mcflurry on 12/26/23.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
	 func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
		 let lines: NSMutableArray = invocation.buffer.lines
		 let arr = lines as NSArray
		 let resultString = arr.componentsJoined(by: ",")
		 print(resultString)

		 RequestManager().generateContent(question: resultString) { result in
			 lines.removeAllObjects()
			 if let result {
				 let stringArray = result.components(separatedBy: ",")
				 print(result)
				 lines.addObjects(from: stringArray)
			 } else {
				 lines.addObjects(from: Array(lines.reversed()))
			 }
			 completionHandler(nil)
		 }
	 }
}
