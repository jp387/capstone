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
      .alert("Unable to fetch your dinner list. Try again later!", isPresented: $searchRecipeVM.showAlert) { }
      .alert(errorMessage, isPresented: $searchRecipeVM.showError) { }
      .searchable(text: $searchResults, prompt: "Search your dinner here...")
      .listStyle(.plain)
      .scrollIndicators(.hidden)
      .onSubmit(of: .search) {
        taskSearch?.cancel()
        taskSearch = Task {
          showDefault = false
          if searchRecipeVM.showNoResults { searchRecipeVM.showNoResults = false }
          searchRecipeVM.results.removeAll()
          await searchRecipeVM.fetchSearchResults(for: searchResults)
        }
      }
    }
    .overlay {
      if showDefault { DefaultSearchView() }
      if searchRecipeVM.isLoading { ProgressView() }
      if searchRecipeVM.showNoResults { NoResultsView() }
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
