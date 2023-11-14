//
//  RandomRecipeService.swift
//  LastMinuteMeals
//
//  Created by John Phung on 11/11/23.
//

import Foundation

struct RandomRecipeService {
  let baseURLString = "https://api.spoonacular.com/recipes/"
  private var apiKey: String {
    guard let filePath = Bundle.main.path(forResource: "Spoonacular-Info", ofType: ".plist") else {
      fatalError("Could not find file 'Spoonacular-Info.plist'.")
    }
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Could not find key 'API_KEY' in 'Spoonacular-Info.plist'.")
    }
    return value
  }

  let configuration: URLSessionConfiguration
  let session: URLSession

  init() {
    self.configuration = URLSessionConfiguration.default
    self.session = URLSession(configuration: configuration)
  }

  func getRandomRecipe() async throws -> Recipes? {
    guard var urlComponents = URLComponents(string: baseURLString + "random") else { return nil }
    urlComponents.queryItems = [
      URLQueryItem(name: "number", value: "20"),
      URLQueryItem(name: "apiKey", value: apiKey)
    ]

    guard let queryURL = urlComponents.url else { return nil }
    let request = URLRequest(url: queryURL)

    let (data, response) = try await session.data(for: request)

    guard (response as? HTTPURLResponse)?.statusCode == 200 else { return nil }

    return try JSONDecoder().decode(Recipes.self, from: data)
  }
}
