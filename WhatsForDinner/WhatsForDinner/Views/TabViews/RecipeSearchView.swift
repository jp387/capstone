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
  @EnvironmentObject var reviewRecipeVM: ReviewRecipeViewModel
  @State private var taskSearch: Task<Void, Error>?
  @State private var showDefaultScreen = true
  @State private var networkFailure = false

  var errorMessage: String {
    if let error = searchRecipeVM.error {
      return error.localizedDescription
    }
    return ""
  }

  var body: some View {
    NavigationStack {
      List(searchRecipeVM.results) { result in
        NavigationLink(value: result) {
          RecipeCardView(recipe: result)
        }
        .listRowSeparator(.hidden)
      }
      .toolbarBackground(.yellow, for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
      .navigationDestination(for: Recipe.self) { result in
        RecipeDetailView(recipe: result)
      }
      .navigationTitle("Find Your Dinner")
      .alert("Unable to search your dinner list. Try again later!", isPresented: $searchRecipeVM.showAlert) {
        Button("OK") {
          networkFailure = true
        }
      }
      .alert(errorMessage, isPresented: $searchRecipeVM.showError) {
        Button("OK") {
          networkFailure = true
        }
      }
      .searchable(text: $searchResults, prompt: "Search your dinner here...")
      .listStyle(.plain)
      .scrollIndicators(.hidden)
      .onSubmit(of: .search) {
        taskSearch?.cancel()
        taskSearch = Task {
          showDefaultScreen = false
          networkFailure = false
          if searchRecipeVM.noResults { searchRecipeVM.noResults = false }
          searchRecipeVM.results.removeAll()
          await searchRecipeVM.fetchSearchResults(for: searchResults)
        }
      }
    }
    .overlay {
      if showDefaultScreen { DefaultSearchView() }
      if networkFailure { NoRecipesView() }
      if searchRecipeVM.isLoading { LoadingProgressView() }
      if searchRecipeVM.noResults { NoResultsView() }
    }
  }
}

struct RecipeSearchView_Previews: PreviewProvider {
  struct RecipeSearchContainer: View {
    @State private var searchTerm = ""

    var body: some View {
      RecipeSearchView(
        searchResults: $searchTerm,
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
