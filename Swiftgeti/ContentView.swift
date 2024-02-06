//
//  ContentView.swift
//  Swiftgeti
//
//  Created by A_Mcflurry on 12/26/23.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var requestManager = RequestManager()
	@State private var question: String = ""
	@State private var answer: String = ""

	var body: some View {
		VStack {
			TextField("Enter your question", text: $question)
				.padding()

			Button("Generate Answer") {
				requestManager.generateContent(question: question) { response in
					if let response {
						self.answer = response
					}
				}
			}
			.padding()

			Text(answer)
				.padding(.top, 20)

		}
		.padding()
	}
}

#Preview {
	ContentView()
}
