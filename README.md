# FoodOrderingApp

A food ordering app built with Flutter and Firebase. The application allows users to register as a shop or a customer. Depending on the user type, the app directs them to the appropriate dashboard. The project focuses on Firebase authentication, storage, and Firestore functions, with a primary emphasis on functionality rather than UI design.

## Features

- User registration as a shop or customer
- Shared login screen for both customer and shop
- Country-based shop filtering for customers
- Customer dashboard displaying shops in the selected country
- Shop dashboard for adding and managing food items
- Firebase authentication, storage, and Firestore integration

## Screenshots

<table>
  <tr>
    <td><img src="ScreenShots/UI Design/1.WelcomeScreen.jpg" alt="Screenshot1" width="200"/></td>
    <td><img src="ScreenShots/UI Design/2.LoginScreen.jpg" alt="Screenshot2" width="200"/></td>
    <td><img src="ScreenShots/UI Design/3.CustomerRegistrationScreen.jpg" alt="Screenshot3" width="200"/></td>
    <td><img src="ScreenShots/UI Design/4.ShopRegistrationScreen.jpg" alt="Screenshot4" width="200"/></td>
  </tr>
  <tr>
    <td><img src="ScreenShots/UI Design/6.CustomerDashboard(When logged as User1).jpg" alt="Screenshot5" width="200"/></td>
    <td><img src="ScreenShots/UI Design/7.Restuarant(shop)FoodItems.jpg" alt="Screenshot6" width="200"/></td>
    <td><img src="ScreenShots/UI Design/8.WhenLoggedAsBackeryShopDashboard.jpg" alt="Screenshot7" width="200"/></td>
    <td><img src="ScreenShots/UI Design/9.AddItemsScreen.jpg" alt="Screenshot8" width="200"/></td>
  </tr>
</table>

## Packages Used

- [cupertino_icons](https://pub.dev/packages/cupertino_icons): ^1.0.2
- [get](https://pub.dev/packages/get): ^4.6.5
- [http](https://pub.dev/packages/http): ^1.1.0
- [firebase_core](https://pub.dev/packages/firebase_core): ^2.14.0
- [firebase_auth](https://pub.dev/packages/firebase_auth): ^4.6.3
- [firebase_storage](https://pub.dev/packages/firebase_storage): ^11.2.4
- [cloud_firestore](https://pub.dev/packages/cloud_firestore)
- [cached_network_image](https://pub.dev/packages/cached_network_image)
- [image_picker](https://pub.dev/packages/image_picker)

## Getting Started

To get started with the project, follow these steps:

1. Clone the repository:
    ```sh
    git clone https://github.com/AminduBhashana/SampleFoodOrderingApp.git
    ```
2. Navigate to the project directory:
    ```sh
    cd FoodOrderingApp
    ```
3. Install the dependencies:
    ```sh
    flutter pub get
    ```
4. Set up Firebase for the project by following the [Firebase setup guide](https://firebase.flutter.dev/docs/overview)
5. Run the app:
    ```sh
    flutter run
    ```

## User Flow

1. **Registration**:
   - Users can register as a shop or a customer.
   - Both user types need to select their country during registration.

2. **Login**:
   - Both shops and customers use the same login screen.
   - Upon successful login, users are directed to their respective dashboards.

3. **Customer Dashboard**:
   - Displays shops based on the customer's selected country.
   - Customers can view food items offered by each shop.

4. **Shop Dashboard**:
   - Shops can add and manage their food items.
   - Items added by shops are displayed to customers in the respective country.


