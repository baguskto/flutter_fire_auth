# Flutter Fire Auth

Flutter Fire Auth is a Flutter-based mobile application with features such as User Registration, Login, Forgot Password, and Home page.

![Screenshot](https://github.com/baguskto/flutter_fire_auth/blob/ee9589de23b38801e7d6e3f7b82538675208ed29/assets/doc/screenshot_1.jpeg)


## Features

- User Registration
- User Login
- Forgot Password
- User Home Page

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

## Getting Started

To get started with Flutter Fire Auth, clone the repository and follow the instructions in the documentation to set up your development environment. Once your environment is set up, you can start exploring and modifying the code.

## Contributing

If you'd like to contribute to Flutter Fire Auth, please fork the repository and create a pull request. We welcome contributions from developers of all skill levels.

## License

Flutter Fire Auth is open-source software licensed under the [MIT license](https://opensource.org/licenses/MIT).