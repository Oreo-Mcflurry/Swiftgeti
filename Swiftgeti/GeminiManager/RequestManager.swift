//
//  RequestManager.swift
//  Swiftgeti
//
//  Created by A_Mcflurry on 2/5/24.
//

import SwiftUI

class RequestManager: ObservableObject {

	func generateContent(question: String, completion: @escaping (String?) -> Void) {
		let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=\(APIKeys.geminiAuthKey)")!

		let prompt: String = "The code written in Swift should be made as unintelligible as possible for developers. Please follow the following rules:\n1. Only return code without providing any comments.\n2. Make the code as unreadable as possible while maintaining its original functionality.\n3.Use alphabet characters like a, b for names of variables, functions, classes, or utilize complex physics and mathematical terms like QuantumSuperposition, Cohomology.\n4. Divide as many elements within functions into multiple functions.\n5.When dealing with bool types, make it difficult by utilizing logical operators and NOT operators.\n6.Break down the code into the smallest possible units and create functions for each of them."
		let content = [
			"parts": [
				"text": prompt + question
			]
		]

		let generationConfig = [
			"temperature": 0.9,
			"topK": 1,
			"topP": 1,
			"maxOutputTokens": 2048,
			"stopSequences": []
		] as [String : Any]

		let safetySettings = [
			["category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_MEDIUM_AND_ABOVE"],
			["category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_MEDIUM_AND_ABOVE"],
			["category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_MEDIUM_AND_ABOVE"],
			["category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_MEDIUM_AND_ABOVE"]
		]

		let parameters: [String: Any] = [
			"contents": [content],
			"generationConfig": generationConfig,
			"safetySettings": safetySettings
		]

		do {
			let jsonData = try JSONSerialization.data(withJSONObject: parameters)

			var request = URLRequest(url: url)
			request.httpMethod = "POST"
			request.addValue("application/json", forHTTPHeaderField: "Content-Type")
			request.httpBody = jsonData

			URLSession.shared.dataTask(with: request) { data, response, error in
				if let data = data {
					print(data)
					do {
						let decoder = JSONDecoder()
						let modelResponse = try decoder.decode(ModelResponse.self, from: data)
						if let contentText = modelResponse.candidates.first?.content.parts.first?.text {
							completion(contentText)
						}
					} catch {
						completion(nil)
					}
				} else if let error {
					completion(nil)
				}
			}.resume()
		} catch {
			completion(nil)
		}
	}
}

