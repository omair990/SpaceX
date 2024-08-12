# SpaceX

## Overview

SpaceX is an iOS application built using Swift, RxSwift, and the MVVM-C architecture. The app fetches and displays data from the SpaceX API, showcasing company information and a list of launches.

## Features

- Fetch and display SpaceX company information.
- Display a list of SpaceX launches with filtering and sorting capabilities.
- Detail view for each launch with additional information and actions.
- Modular architecture with a focus on clean code and testability.

## Project Structure

- **Model:** Contains all the data models representing the application's core entities.
- **View:** Handles the UI elements and layouts.
- **ViewModel:** Contains the business logic and data manipulation code, interfacing between the Model and View.
- **Coordinator:** Manages the navigation flow between different screens.
- **Services:** Handles API calls and data fetching.

## Requirements

- Xcode 13.0 or later
- Swift 5.0 or later
- CocoaPods

## Installation

1. Clone the repository from GitHub:
    ```bash
    git clone https://github.com/omair990/SpaceX.git
    ```
2. Navigate to the project directory:
    ```bash
    cd SpaceX
    ```
3. Install dependencies using CocoaPods:
    ```bash
    pod install
    ```
4. Open the project workspace:
    ```bash
    open SpaceX.xcworkspace
    ```

## Usage

1. Build and run the project on an iOS simulator or device using Xcode.
2. Explore the SpaceX company information and browse through the list of launches.
3. Use the filter and sort options to customize the launch list view.
4. Tap on any launch to view detailed information and perform actions like opening Wikipedia, YouTube, or the official website.

## Testing

Unit tests are provided to ensure the reliability of the core functionalities. To run the tests:

1. Select the `SpaceXTests` scheme in Xcode.
2. Press `Cmd + U` to run the tests.

## Dependencies

- [RxSwift](https://github.com/ReactiveX/RxSwift)
- [RxCocoa](https://github.com/ReactiveX/RxSwift/tree/main/RxCocoa)

## Contributing

If you want to contribute to the project, feel free to reach out and submit your suggestions or code improvements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- SpaceX API for providing the data.
- The RxSwift community for their invaluable resources and support.

## Repository

You can find the source code [here](https://github.com/omair990/SpaceX).
