<h1 align="center">Weather App</h1>

*Author:* Carlos Rodriguez Asensio


## Requirements
- Xcode 14.2
- Swift 5.0

## Objective
- This is a simple project capable to show the weather in Paris for 5 days using MVVM architecture. The app uses the OpenWeather API: https://openweathermap.org/api
 
## Installation
- Clean and build the project in Xcode

## Design pattern
 - **MVVM** - means Model, View, ViewModel. Also, util classes are used like NetworkManager.
 
    - *Model* - defines the API response data.
    - *View* - created programmatically and UIViewController, configures UI.
    - *ViewModel* - business logic, gets the data from service and injects it to the view.
    
    - *NetworkManager* - responsible for making API calls.
    - *RequestHandler* - responsible for creating service URL and request.
    
    - *Constants* - app useful data. In this case, especially in order to generate the URL.
 
 ## Potential improvements
- Dependency Injection improvement.
- More information in the detail view.
- Improve the app UI/UX. Add some animations.
- Add Unit, UI and Integration Tests.
- Add more languages to the app.
- Handle error in the NetworkManager.
