# What's For Dinner Application
The What's For Dinner application is an application that performs the following features using the Spoonacular API:
- Fetch random recipes with the ability to refresh a new set of recipes to be displayed in a list view.
- Perform searches for recipes based on search terms.
- Save recipes as favorites that can be searched and removed.
- Create reviews for recipes.

The application does not use any third party libraries to perform the features listed above and relies solely on the frameworks provided by Apple through Xcode and the API provided by Spoonacular.

# Project Organization

The What's For Dinner project folders are organized in the following order:

**App**
- The folder contains files that are used to setup the fonts used for the Splash Screen view and the logic to setup the views for the Onboarding, Splash Screen and Home screen. Also, the folder contains the Asset Catalog.
  The following app files/folder are contained in this folder:
    - **_ViewCoordinator.swift_** (contains the code used to manage the views for the splash, onboarding and main screen and uses AppStorage to save the onboarding completion state)
    - **_WhatsForDinnerApp.swift_** (contains the code used to setup the enviroment objects and view coordinator)
    - **_Assets.xcassets_** (contains icons and colors used throughout the application)
    - **_Fonts_** (folder that contains the font used to style the splash screen text)
    - **_Constants.swift_** (contains constant values used on various files of the application to remove magic numbers)

**Extensions**
- The folder contains extension files that are used to strip the HTML from the summary in the detail screen and the FileManager used to store files in the Document Directory.
  - The following extension files are contained in this folder:
    - **_FileManager.swift_** (contains the FileManager code used to access the Document Directory)
    - **_Utility.swift_** (contains code to strip out HTML tags from the recipe summary)

**Networking**
- The folder contains files that are used to send a request and response to the Spoonacular API, along with files used to perform unit testing.
  - The following networking files/folder are contained in this folder:
      - **_RecipeService.swift_** (contains the networking code used for getting random recipes and performing searches from the Spoonacular API)
      - **_RecipeServiceProtocol.swift_** (contains the protocol code used to manange the methods used for the RecipeService.swift and unit testing the view models)
      - **_MockData_** (contains files used for testing the view models)

**Models**
- The folder contains files that are used for creating the model for the JSON data to be used for decoding on the view models. Also, the folder contains files that are used to setup the Onboarding views and saving favorites and reviews.
  - The following model files are contained in this folder:
    - **_RecipeModel.swift_** (contains the model used for the recipes from the Spoonacular API)
    - **_ReviewRecipeModel.swift_** (contains the model used for storing the reviews)
    - **_FavoriteRecipeModel.swift_** (contains the model used for storing the favorited recipes)
    - **_OnboardingModel.swift_** (contains the model used for creating the onboarding views)

**Views**
- The folder contains files for all the views used throughout the What's For Dinner application.
  - The following view files are contained in this folder (Bold denotes folder name):
    - Splash Screen View (contains animations for displaying the plate of food)
      - **SplashScreenViews**
        - **_SplashScreenView.swift_**
    - Onboarding View
      - **OnboaringViews**
        - **_OnboardingView.swift_** (to display the onboarding view)
        - **_OnboardingDetailView.swift_** (to setup the details for the onboarding view)
    - Main View (contains the tab views)
      - **MainViews**
        - **_MainView.swift_**
    -  Tab View
      - Home View
        - **TabViews**
          - **_RecipeHomeView.swift_** (contains animations when tapping on the refresh button)
      - Favorites View
        - **TabViews**
          - **_RecipeFavoritesView.swift_**
      - Search View
        - **TabViews**
          - **_RecipeSearchView.swift_**
    - Detail View
      - Recipe Detail View
        - **DetailViews**
          - **_RecipeDetailView.swift_**
      - Favorites Detail View
        - **DetailViews**
          - **_FavoriteDetailView.swift_**
    - Review View
      - Review Button View
        - **ReviewViews**
          - **_ReviewButtonView.swift_**
      - Review Form View
        - **ReviewViews**
          - **_NewReviewFormView.swift_**
    - Default View
      - Favorites Default View (when no favorites have been added)
        - **DefaultViews**
          - **_DefaultFavoritesView.swift_**
      - Search Default View (when no search has been performed)
        - **DefaultViews**
          - **_DefaultSearchView.swift_**
    - Reuseable View
      - Recipe Card View (to display the cards from the list in the Home, Favorites and Search views)
        - **ReuseableViews**
          - **_RecipeCardView.swift_**
      - Loading Progress View (to display an indeterminate progress view)
        - **ReuseableViews**
          - **_LoadingProgessView.swift_**
    - Negative View
      - No Results View (to display when a search fails for the Favorites and Search views)
        - **NegativeViews**
          - **_NoResultsView.swift_**
      - No Recipes View (to display when bundle file fails to load, API request fails or when there is no network connection)
        - **NegativeViews**
          - **_NoRecipesView.swift_**

**ViewModels**
- The folder contains files used for fetching data from the Spoonacular API and Bundle JSON file for the project.
  - The following view model files are contained in this folder:
    - **_RandomRecipeViewModel.swift_** (contains the view model code used to fetch and refresh random recipes from the Spoonacular API and bundle files for freeze dried JSON data)
    - **_SearchRecipeViewModel.swift_** (contains the view model code used to fetch search results from the Spoonacular API)
    - **_ReviewRecipeViewModel.swift_** (contains the view model code used to load, add and save reviews into the Document Directory)
    - **_FavoriteRecipeViewModel.swift_** (contains the view model code used to load, add, remove and save favorites into the Document Directory)
    - **_OnboardingViewModel.swift_** (contains the view model code used to setup the data for the onboading view)

**WhatsForDinnerTests**
- The folder contains files used to perform unit testing.
  - The following unit test files are contained in this folder:
    - **_RandomRecipesViewModelTests.swift_** (contains test cases to test the RandomRecipeViewModel.swift file)
    - **_SearchRecipeViewModelTests.swift_** (contains test cases to test the SearchRecipeViewModel.swift file)
    - **_ReviewRecipeViewModelTests.swift_** (contains test cases to test the ReviewRecipeViewModel.swift file)
    - **_FavoriteRecipeViewModelTests.swift_** (contains test cases to test the FavoriteRecipeViewModel.swift file)

**WhatsForDinnerUITests**
- The folder contains files used to peform UI testing.
  - The following UI test files are contained in this folder:
    - **_WhatsForDinnerUITests.swift_** (contains test cases to test various screens in the application)
   
# Testing Notes

> [!IMPORTANT]
> The Spoonacular API key is required in order for the What's For Dinner application to function correctly. Create an account at https://spoonacular.com/food-api/console#Dashboard and once an API key is provided, create a file called **Spoonacular-Info.plist** and add a key called **API_KEY** with the value of the API key. Afterwards, add the **Spoonacular-Info.plist** file into the project.

> [!NOTE]
> Due to the low API request provided by Spoonacular for free accounts, a freeze dried JSON data for the random recipe on the Home screen is provided here: [recipestub.json](https://github.com/jp387/capstone/files/13484038/recipestub.json). To use the freeze dried JSON data on the Home screen, add it to the project and uncomment the following lines of code on the RecipeHomeView.swift file (located in the Views -> Tabviews folder): <img width="1552" alt="Screenshot 2023-11-30 at 7 47 40 AM" src="https://github.com/jp387/capstone/assets/141362328/176bd0f8-00ea-4e00-9dd6-970c8a73ab55">

The API chosen for the What's For Dinner project is the Spoonacular API and since the project itself is using the free account, there is an API request limit of 150 points per day. Once the API request has reached 150 points, a 402 error code response is called and prevents any new request from being execute until it gets reset at midnight UTC time. The Spoonacular API is used in the following way on the project:

* Fetching random recipes from application launch and through the refresh button: The application will fetch 25 random recipes from launch and tapping on the refresh button will launch another set of 25 random recipes. Based on the Spoonacular API setup, the request cost **1 point** and each result will cost **0.01 points**, which means the total comes out to be **1 point + (25 * 0.01 points) = 1.25 points**
* Searching recipes from the search screen: The application will fetch 50 results when a search is performed. Based on the Spoonacular API setup, the search request cost **1 point** and each result will cost **0.01 points**. Also, there are additional cost when using the search filters and in the project, two search filters are used to fill in missing ingredients and adding nutritional information, which cost **0.025 points** each. The total number of points used is dependent on the number of search results that come back from the API request, with the maximum value of **1 point + (50 * (0.01 points per result returned)) + (50 * (0.025 points per result return with missing ingredient filter)) + (50 * (0.025 points per result with nutritional information filter)) = 4 points**.

# Additional Information

- The What's For Dinner project saves data in the following ways:
  - The Document Directory is used to persist the favorite and reviews data on the device.
  - The AppStorage is used to persist the status of the Onboarding view when tapping the Let's Go button on the last screen. Persisting the Onboarding screen status with AppStorage will allow the application to bypass the Onboarding screen during launch.
- The unit and UI test files have disabled SwiftLint rules for setting up the view models for implicitly unwrapping optionals, which will be initialized in the setUp() method. Comments have been posted above the disable SwiftLint rules.

# Future Implementations and Considerations

- Add the ability to create shopping list for ingredients.
- Add the ability to create personal recipes to be shareable with anyone.
- Add the ability to create profiles to store review, favorites and any other relevant information.
- Refine the search and random recipe data to make it display different types of recipes based on filtering criteria.
- Refine the unit and UI test cases to cover more areas of the application.
- Refactor the code for better readability, performance and any other changes to enhance the application.
- Store profile information, reviews and favorites on a Vapor server.
- Update the UI on the Home screen to make the application stand out.
- Update the search to include pagination for large search results.
