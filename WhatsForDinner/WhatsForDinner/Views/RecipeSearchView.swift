//
//  RecipeSearchView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/13/23.
//

import SwiftUI

struct RecipeSearchView: View {
  @Binding var searchResults: String
  @ObservedObject var searchRecipeVM: SearchRecipeViewModel
  @ObservedObject var reviewRecipeVM: ReviewRecipeViewModel
  @State private var taskSearch: Task<Void, Error>?

  var body: some View {
    NavigationStack {
      List(searchRecipeVM.results) { result in
        NavigationLink(value: result) {
          ListCellView(recipe: result)
        }
        .listRowSeparator(.hidden)
      }
      .navigationDestination(for: Recipe.self) { result in
        RecipeDetailView(
          recipe: result,
          reviewRecipeVM: reviewRecipeVM
        )
      }
      .listStyle(.plain)
      .searchable(text: $searchResults, prompt: "Search your dinner here...")
      .onSubmit(of: .search) {
        taskSearch?.cancel()
        taskSearch = Task {
          searchRecipeVM.results.removeAll()
          await searchRecipeVM.fetchSearchResults(for: searchResults)
        }
      }
    }
  }
}

struct RecipeSearchView_Previews: PreviewProvider {
  struct RecipeSearchContainer: View {
    @State private var searchTerm = ""

    var body: some View {
      RecipeSearchView(
        searchResults: $searchTerm,
        searchRecipeVM: SearchRecipeViewModel(),
        reviewRecipeVM: ReviewRecipeViewModel()
      )
    }
  }

  static var previews: some View {
    RecipeSearchContainer()
  }
}
