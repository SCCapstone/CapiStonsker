# SC Interactive Historical Map by CapiStonsker

This project will be an app, primarily targeting mobile platforms, that will provide an interactive method to easily access information about the historical markers of South Carolina. More information about the app can be found on our [GitHub Wiki](https://github.com/SCCapstone/CapiStonsker/wiki).


## External Requirements

Before building this project, install the following:

* [Android Studio](https://developer.android.com/studio)
* [Flutter](https://flutter.dev/docs/get-started/install/windows)


## Running

In your command line, use the following commands to run the project.
```
flutter create testApp
cd testApp
# flutter emulators
    # - This command brings up a list of available emulators. 
    # - Select one and use it's ID in the following command.
flutter emulators --launch <emulator id>
flutter run
```

## Deployment

1. Open up the project using Android Studio. 
2. Select an emulator from the drop-down menu. 
    - If no emulators are created, go into AVD Manager and create a new emulator. 
3. With the emulator selected, click the 'Run' button to run the app.


## Testing

### Run unit tests
* To run unit test for full_info page, run the following command: `flutter test tests/full_info_test.dart`
* To run unit test for calcDist method, run the following command: `flutter test tests/loc_calcdist_test.dart`

### Unit Tests can be found in the `tests` folder
### Run Behavorial/Integration tests
* To run integration test for drawer, run the following command: `flutter drive --driver=test_driver/test_diver.dart --target=integration_test/app_test.dart`
### Behavioral/Integration Tests can be found in the `integration_test` folder


### Tests can be found in the `tests` folder



## Authors

* Lauren Hodges, lehodges@email.sc.edu
* Matt Duggan, mtduggan@email.sc.edu
* Ian Urton, iurton@email.sc.edu
* James Davis, daviscommajames12@gmail.com
* Joseph Cammarata, cammarj@email.sc.edu
