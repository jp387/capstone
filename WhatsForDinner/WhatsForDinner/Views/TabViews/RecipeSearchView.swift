//
//  RecipeSearchView.swift
//  WhatsForDinner
//
//  Created by John Phung on 11/13/23.
//

import SwiftUI

struct RecipeSearchView: View {
  @StateObject var searchRecipeVM = SearchRecipeViewModel(service: RecipeService())
  @State private var taskSearch: Task<Void, Error>?

  var body: some View {
    NavigationStack {
      List(searchRecipeVM.results) { result in
        NavigationLink(value: result) {
          RecipeCardView(recipe: result)
        }
        .accessibilityIdentifier("search-list")
        .listRowSeparator(.hidden)
      }
      .navigationDestination(for: Recipe.self) { result in
        RecipeDetailView(recipe: result)
      }
      .toolbarBackground(.yellow, for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
      .navigationTitle("Find Your Dinner")
      .alert("Unable to search your dinner list. Try again later!", isPresented: $searchRecipeVM.showAlertPrompt) {
        Button("OK") {
          searchRecipeVM.showNoNetworkScreen = true
        }
      }
      .alert(searchRecipeVM.errorMessage, isPresented: $searchRecipeVM.showErrorPrompt) {
        Button("OK") {
          searchRecipeVM.showNoNetworkScreen = true
        }
      }
      .searchable(text: $searchRecipeVM.searchResults, prompt: "Search your dinner here...")
      .listStyle(.plain)
      .onSubmit(of: .search) {
        taskSearch?.cancel()
        taskSearch = Task {
          searchRecipeVM.showDefaultScreen = false
          searchRecipeVM.showNoNetworkScreen = false
          if searchRecipeVM.noResults {
            searchRecipeVM.noResults = false
          }
          searchRecipeVM.results.removeAll()
          await searchRecipeVM.fetchSearchResults(for: searchRecipeVM.searchResults)
        }
      }
    }
    .overlay {
      if searchRecipeVM.showDefaultScreen {
        DefaultSearchView()
      }
      if searchRecipeVM.showNoNetworkScreen {
        NoRecipesView()
      }
      if searchRecipeVM.isLoading {
        LoadingProgressView()
      }
      if searchRecipeVM.noResults {
        NoResultsView()
      }
    }
  }
}

struct RecipeSearchView_Previews: PreviewProvider {
  struct RecipeSearchContainer: View {
    @State private var searchTerm = ""

    var body: some View {
      RecipeSearchView(
        searchRecipeVM: SearchRecipeViewModel(service: RecipeService())
      )
    }
  }

  static var previews: some View {
    RecipeSearchContainer()
      .environmentObject(ReviewRecipeViewModel())
      .environmentObject(FavoriteRecipeViewModel())
  }
}
