# Floward Case Study
Floward Case Study App. Displays list of movies fetched from https://imdb-api.com/

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and debugging purposes.

### Prerequisites

Application is using Swift Package manager for dependency management.

## Features
- A List, which will display top 250 movies list on imdb
- Each item of list contains, Movie Image, Title, Release year, Crew, IMDB rating.
- App will support only Potrait mode

## User Guidelines
- Upon launching, app automatically fetches top 250 movies list.
- In case of error, retry button with text will appear.

## Technical Notes

### Architecture
- For Architecture purpose MVVM is used along with Builder and Coordinator.
- Since it is single page application so we just have App Coordinator.
- Builder surves the modules construction prupose.
- Completion handler are used for binding mechanism.
- Create interfaces to communicate between view-viewmodel


### Third Party
- Kingfisher (For downloading and caching images)


## Sample Screens
![Home](Screenshots/MovieList.png)

* **See Application Video here:**  [AppPreview.mp4](Screenshots/AppPreview.mp4)


## Authors

* **Sharjeel Ali**



