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
  @State private var showDefault = true
  @State private var showFailure = false

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
          ListCellView(recipe: result)
        }
        .listRowSeparator(.hidden)
      }
      .navigationDestination(for: Recipe.self) { result in
        RecipeDetailView(recipe: result)
      }
      .navigationTitle("Find Your Dinner")
      .alert("Unable to fetch your dinner list. Try again later!", isPresented: $searchRecipeVM.showAlert) {
        Button("OK") {
          showFailure = true
        }
      }
      .alert(errorMessage, isPresented: $searchRecipeVM.showError) {
        Button("OK") {
          showFailure = true
        }
      }
      .searchable(text: $searchResults, prompt: "Search your dinner here...")
      .listStyle(.plain)
      .scrollIndicators(.hidden)
      .onSubmit(of: .search) {
        taskSearch?.cancel()
        taskSearch = Task {
          showDefault = false
          showFailure = false
          if searchRecipeVM.noResults { searchRecipeVM.noResults = false }
          searchRecipeVM.results.removeAll()
          await searchRecipeVM.fetchSearchResults(for: searchResults)
        }
      }
    }
    .overlay {
      if showDefault { DefaultSearchView() }
      if showFailure { NoRecipesView() }
      if searchRecipeVM.isLoading { ProgressView() }
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
        searchRecipeVM: SearchRecipeViewModel()
      )
    }
  }

  static var previews: some View {
    RecipeSearchContainer()
      .environmentObject(ReviewRecipeViewModel())
  }
}
