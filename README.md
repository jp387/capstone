# What's For Dinner Application
The What's For Dinner application is an application that performs the following features using the Spoonacular API:
- Fetch random recipes with the ability to refresh a new set of recipes to be displayed in a list view.
- Perform searches for recipes based on search terms.
- Save recipes as favorites that can be searched and removed.
- Create reviews for recipes.

The application does not use any third party libraries to perform the features listed above and relies solely on the frameworks provided by Apple through Xcode and the Spoonacular API.

# Project Organization

The What's For Dinner project folders are organized in the following order:

**App**
- The folder contains files that are used to setup the fonts used for the Splash Screen view and the logic to setup the views for the Onboarding, Splash Screen and Home screen. Also, the folder contains the Asset Catalog.

**Extensions**
- The folder contains extension files that are used to strip the HTML from the summary in the detail screen and the FileManager used to store files in the Document Directory.

**Networking**
- The folder contains files that are used to send a request and response to the Spoonacular API, along with files used to perform unit testing.

**Models**
- The folder contains files that are used for creating the model for the JSON data to be used for decoding on the view models. Also, the folder contains files that are used to setup the Onboarding views and saving favorites and reviews.

**Views**
- The folder contains files for all the views used throughout the What's For Dinner application.

**ViewModels**
- The folder contains files used for fetching data from the Spoonacular API and Bundle JSON file for the project.

**WhatsForDinnerTests**
- The folder contains files used to perform unit testing.

**WhatsForDinnerUITests**
- The folder contains files used to peform UI testing.

# Testing Notes

> [!IMPORTANT]
> The Spoonacular API key is required in order for the What's For Dinner application to function correctly. Create an account at https://spoonacular.com/food-api/console#Dashboard and once an API key is provided, create a file called **Spoonacular-Info.plist** and add a key called **API_KEY** with the value of the API key. Afterwards, add the **Spoonacular-Info.plist** file into the project.

> [!NOTE]
> Since search results are unpredictable and due to the low API request provided by Spoonacular for free accounts, a freeze dried JSON data for the random recipe on the Home screen is provided here: [recipestub.json](https://github.com/jp387/capstone/files/13484038/recipestub.json). To use the freeze dried JSON data on the Home screen, add it to the project and uncomment the following lines of code on the RecipeHomeView.swift file (located in the Views -> Tabviews folder): <img width="1552" alt="Screenshot 2023-11-30 at 7 47 40 AM" src="https://github.com/jp387/capstone/assets/141362328/176bd0f8-00ea-4e00-9dd6-970c8a73ab55">

The API chosen for the What's For Dinner project is the Spoonacular API and since the project itself is using the free account, there is an API request limit of 150 points per day. Once the API request has reached 150 points, a 402 error code response is called and prevents any new request from being execute until it gets reset at midnight UTC time. The Spoonacular API is used in the following way on the project:

* Fetching random recipes from application launch and through the refresh button: The application will fetch 25 random recipes from launch and tapping on the refresh button will launch another set of 25 random recipes. Based on the Spoonacular API setup, the request cost **1 point** and each result will cost **0.01 points**, which means the total comes out to be **1 point + (25 * 0.01 points) = 1.25 points**
* Searching recipes from the search screen: The application will fetch 100 results when a search is performed. Based on the Spoonacular API setup, the search request cost **1 point** and each result will cost **0.01 points**. Also, there are additional cost when using the search filters and in the project, two search filters are used to fill in missing ingredients and adding nutritional information, which cost **0.025 points** each. The total number of points used is dependent on the number of search results that come back from the API request, with the maximum value of **1 point + (100 * (0.01 points per result returned)) + (100 * (0.025 points per result return with missing ingredient filter)) + (100 * (0.025 points per result with nutritional information filter)) = 7 points**.

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
