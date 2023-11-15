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
  @State private var taskSearch: Task<Void, Error>?

  var body: some View {
    NavigationStack {
      List(searchRecipeVM.results) { result in
        NavigationLink(value: result) {
          SearchListCellView(result: result)
        }
        .listRowSeparator(.hidden)
      }
      .navigationDestination(for: Result.self) { result in
        SearchDetailView(result: result)
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

struct SearchListCellView: View {
  var result: Result

  var body: some View {
    HStack {
      ImageSearchView(result: result)
      TitleSearchTextView(result: result)
    }
  }
}

struct ImageSearchView: View {
  var result: Result

  var body: some View {
    AsyncImage(url: URL(string: "https://spoonacular.com/recipeImages/\(result.id)-90x90.jpg")) { image in
      image
    } placeholder: {
      ProgressView()
    }
    .frame(width: 90, height: 90)
    .background(.gray)
  }
}

struct TitleSearchTextView: View {
  var result: Result

  var body: some View {
    VStack(alignment: .leading) {
      Text(result.title)
      if result.readyInMinutes >= 60 {
        let hours = Int(result.readyInMinutes / 60)
        let minutes = Int(result.readyInMinutes - (hours * 60))
        let hoursText = hours > 1 ? "hours" : "hour"

        if minutes == 0 || minutes == 60 {
          Text("Cooking Time: \(hours) \(hoursText)")
            .font(.caption)
        } else if minutes == 1 {
          Text("Cooking Time: \(hours) \(hoursText) \(minutes) minute")
            .font(.caption)
        } else {
          Text("Cooking Time: \(hours) \(hoursText) \(minutes) minutes")
            .font(.caption)
        }
      } else {
        Text("Cooking Time: \(result.readyInMinutes) minutes")
          .font(.caption)
      }
      Text("Serving: \(result.servings)")
        .font(.caption)
    }
  }
}

struct RecipeSearchView_Previews: PreviewProvider {
  struct RecipeSearchContainer: View {
    @State private var searchTerm = ""

    var body: some View {
      RecipeSearchView(searchResults: $searchTerm, searchRecipeVM: SearchRecipeViewModel())
    }
  }

  static var previews: some View {
    RecipeSearchContainer()
  }
}
