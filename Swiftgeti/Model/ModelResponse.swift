//
//  ModelResponse.swift
//  Swiftgeti
//
//  Created by A_Mcflurry on 2/5/24.
//

import Foundation

struct ModelResponse: Decodable {
	let candidates: [Candidate]
}


struct Candidate: Decodable {
	let content: Content
	enum CodingKeys: String, CodingKey {
		case content = "content"
	}
}

struct Content: Decodable {
	let parts: [Part]
	enum CodingKeys: String, CodingKey {
		case parts = "parts"
	}
}

struct Part: Codable {
	let text: String

	enum CodingKeys: String, CodingKey {
		case text = "text"
	}
}
