Table of Contents
[Description](https://github.com/SCCapstone/CapiStonsker#sc-interactive-historical-map-by-capistonsker)
[]()
[]()

![Readme header- our team logo](https://github.com/SCCapstone/CapiStonsker/blob/main/assets/image/logo.png?raw=true)
# SC Interactive Historical Map by CapiStonsker

For this project, we created a mobile Android application that showcases an intuitive user interface to to facilitate interaction with historical landmarks throughout the state of South Carolina. More information about the app can be found on our [demo website](https://sccapstone.github.io/CapiStonsker/) and our [GitHub Wiki](https://github.com/SCCapstone/CapiStonsker/wiki).

## Deployment- Using our app in an emulator
This is the simplest way to use our app and should be sufficient for testing purposes. If you need to have access to source code and run the app as a developer, see the "Instructions for running our app as a developer in a cloned repo" section below.

### Downloads
* Download and install [Android Studio](https://developer.android.com/studio).
* Download the desired version of `app-release.apk` from the [Releases](https://github.com/SCCapstone/CapiStonsker/releases) section of our GitHub.

### Deploying the .apk on a virtual device in Android Studio
* Open Android Studio
* Click `configure` at the bottom right of the screen
* Click `Open AVD manager`
* Click `create new virtual device`
* Choose `Pixel 2` from Choose a device definition > Phone > Pixel 2, then click `next`
* NOTE: If the app crashes upon opening, the default device may not have enough RAM. Instead of choosing Pixel 2 from the menu, create a new hardware profile with the Pixel 2 skin and more than the default 2 GB RAM
* Choose `Pie` from Select a system image > Pie, then click `next`
* Click `finish`
Now you should have a working AVD emulator
* Click the green play button next to your new emulator
* Wait for the AVD to load
Now, find `app-release.apk`, which you downloaded from the [Releases](https://github.com/SCCapstone/CapiStonsker/releases) section of our GitHub earlier. Open the folder where it is located and drag the file onto the AVD emulator.
* If the app doesn't open automatically (give it a few seconds), find the app list (drag up from the bottom of the screen) and select the app from there. Our app is called capi_stonsker.


## Deployment- Instructions for building our app

### External Requirements
Before building this project, install the following:
* [Android Studio](https://developer.android.com/studio)
* [Flutter](https://flutter.dev/docs/get-started/install/windows)

### Running
1. Download the project source code from GitHub
2. Open Android Studio and choose "open existing project"
3. Choose the downloaded source code
4. Be sure the project is opened as a flutter project
5. Be sure Android Studio knows where the downloaded flutter sdk is stored
6. Go to the AVD manager to choose or create an emulator. We recommend using the Pixel 2 with the Pie build.
7. Open the emulator, then build the project using the green play button on Android Studio


## Testing

### Run unit tests
* To run the unit test for full_info page, run the following command: `flutter test tests/full_info_test.dart`
* To run the unit test for calcDist method, run the following command: `flutter test tests/loc_calcdist_test.dart`
* To run all unit tests, run the following command: `flutter test tests`

### Unit Tests can be found in the `tests` folder

### Run Behavorial/Integration tests
* To run the integration test for drawer, open an emulator then run the following command: `flutter drive --driver=test_driver/test_driver.dart --target=integration_test/app_test.dart`

### Behavioral/Integration Tests can be found in the `integration_test` folder


## Authors
* Matt Duggan, mtduggan@email.sc.edu
* Ian Urton, iurton@email.sc.edu
* James Davis, daviscommajames12@gmail.com
* Joseph Cammarata, cammarj@email.sc.edu
* Lauren Hodges, lehodges@email.sc.edu
