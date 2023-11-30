//
//  RandomRecipeService.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/11/23.
//

import Foundation

struct RecipeService: RecipeServiceProtocol {
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

  let decoder = JSONDecoder()

  func getRandomRecipe() async throws -> [Recipe] {
    guard var urlComponents = URLComponents(string: baseURLString + "random") else {
      print("Unable to create a URL component for getting random recipes.")
      return []
    }

    urlComponents.queryItems = [
      URLQueryItem(name: "number", value: "25"),
      URLQueryItem(name: "apiKey", value: apiKey)
    ]

    guard let queryURL = urlComponents.url else {
      print("Unable to create a URL query for getting random recipes.")
      return []
    }
    let request = URLRequest(url: queryURL)

    let (data, response) = try await URLSession.shared.data(for: request)

    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      print("Invalid response for getting random recipes: \(response.description)")
      return []
    }

    return try decoder.decode(Recipes.self, from: data).recipes
  }

  func getSearchResults(for query: String) async throws -> [Recipe]? {
    guard var urlComponents = URLComponents(string: baseURLString + "complexSearch") else {
      print("Unable to create a URL component for search.")
      return nil
    }

    urlComponents.queryItems = [
      URLQueryItem(name: "query", value: query),
      URLQueryItem(name: "fillIngredients", value: "true"),
      URLQueryItem(name: "type", value: "main course"),
      URLQueryItem(name: "instructionsRequired", value: "true"),
      URLQueryItem(name: "addRecipeNutrition", value: "true"),
      URLQueryItem(name: "number", value: "100"),
      URLQueryItem(name: "apiKey", value: apiKey)
    ]

    guard let queryURL = urlComponents.url else {
      print("Unable to create a URL query for search.")
      return nil
    }
    let request = URLRequest(url: queryURL)

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let response = response as? HTTPURLResponse,
      response.statusCode == 200 else {
      print("Invalid response for search: \(response)")
      return nil
    }

    return try decoder.decode(Search.self, from: data).results
  }
}
