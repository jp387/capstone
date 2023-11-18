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
      .alert("Unable to fetch your dinner list. Try again later!", isPresented: $searchRecipeVM.showAlert) { }
      .alert(errorMessage, isPresented: $searchRecipeVM.showError) { }
      .searchable(text: $searchResults, prompt: "Search your dinner here...")
      .listStyle(.plain)
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
        searchRecipeVM: SearchRecipeViewModel()
      )
    }
  }

  static var previews: some View {
    RecipeSearchContainer()
      .environmentObject(ReviewRecipeViewModel())
  }
}
