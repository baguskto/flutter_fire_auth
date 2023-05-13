# Flutter Fire Auth

Flutter Fire Auth is a Flutter-based mobile application with features such as User Registration, Login, Forgot Password, and Home page.

<p float="left">
  <img src="https://github.com/baguskto/flutter_fire_auth/blob/ee9589de23b38801e7d6e3f7b82538675208ed29/assets/doc/screenshot_1.jpeg" width="400" />
  <img src="https://github.com/baguskto/flutter_fire_auth/blob/911eec8d59c72224edd1e8b18342d2d848fdaa61/assets/doc/screenshot_2.jpeg" width="400" /> 
</p>

## Features

- User Registration
- User Login
- Forgot Password
- User Home Page
- **Unit Testing**

## Specifications

### User Data

- Name:
  - Minimum of 3 characters
  - Maximum of 50 characters
  - Cannot be empty

- Email:
  - Must be a valid email address
  - Cannot be empty

- Password:
  - Minimum of 8 characters
  - Must contain numbers, upper and lowercase letters
  - Cannot be empty

- Password Confirmation:
  - Must match the password field
  - Cannot be empty

### Pages

- Register, Login and Forgot Password pages should validate all input fields.
- During Registration and Forgot Password process, the user will receive a confirmation link via email.
- User data is stored in Firebase.
- On the Home page, the registered user's data is displayed. The data retrieval should use the token from the login session.
- Data on the Home page can be filtered based on the confirmation status via email.
- The application should have an appealing UI and animations will be a plus point.

### Tools and Architecture

- The application uses GetX, GetController, GetView, and Binding for state management and navigation.
- The application follows the principles of Clean Architecture for a scalable and maintainable codebase.

### Clean Architecture

The application follows the principles of Clean Architecture which includes division of the project into Layers with 'Respective Dependencies' - this ensures that the outer layers can depend on the inner layers but not vice versa, thus making the codebase maintainable and scalable.

<p align="center">
  <img src="https://github.com/baguskto/flutter_fire_auth/blob/main/assets/doc/architecture.png" width="600" />
</p>

### Test Coverage

Test coverage is an important aspect of the project. It helps to identify which parts of the code are covered by unit tests and which are not. The test coverage of the application can be seen in the following image.

<p align="center">
  <img src="https://github.com/baguskto/flutter_fire_auth/blob/9d4df7f403b78fa1b539f720f8909800d5cd71c0/assets/doc/lcov.png" width="600" />
</p>

## Getting Started

To get started with Flutter Fire Auth, clone the repository and follow the instructions in the documentation to set up your development environment. Once your environment
is set up, you can start exploring and modifying the code.

## Contributing

If you'd like to contribute to Flutter Fire Auth, please fork the repository and create a pull request. We welcome contributions from developers of all skill levels. Whether you're fixing bugs, adding new features, or updating documentation, we appreciate your help!

When you contribute to the codebase, please ensure that your code is well-tested. We strive to maintain high test coverage to ensure the stability and reliability of the application.

## License

Flutter Fire Auth is open-source software licensed under the [MIT license](https://opensource.org/licenses/MIT).

We hope that you enjoy using and contributing to Flutter Fire Auth. By following the principles of Clean Architecture and maintaining high test coverage, we can ensure that this application remains robust, flexible, and easy to work with.