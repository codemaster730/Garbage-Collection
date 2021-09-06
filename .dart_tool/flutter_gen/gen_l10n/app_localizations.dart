
import 'dart:async';

// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations returned
/// by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  // ignore: unused_field
  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
    Locale('zh', 'CN')
  ];

  /// No description provided for @search_for_markets_or_products.
  ///
  /// In en, this message translates to:
  /// **'Search for markets or products'**
  String get search_for_markets_or_products;

  /// No description provided for @top_markets.
  ///
  /// In en, this message translates to:
  /// **'Top Markets'**
  String get top_markets;

  /// No description provided for @ordered_by_nearby_first.
  ///
  /// In en, this message translates to:
  /// **'Ordered by Nearby first'**
  String get ordered_by_nearby_first;

  /// No description provided for @trending_this_week.
  ///
  /// In en, this message translates to:
  /// **'Trending This Week'**
  String get trending_this_week;

  /// No description provided for @product_categories.
  ///
  /// In en, this message translates to:
  /// **'Product Categories'**
  String get product_categories;

  /// No description provided for @most_popular.
  ///
  /// In en, this message translates to:
  /// **'Most Popular'**
  String get most_popular;

  /// No description provided for @recent_reviews.
  ///
  /// In en, this message translates to:
  /// **'Recent Reviews'**
  String get recent_reviews;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @select_your_preferred_languages.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred languages'**
  String get select_your_preferred_languages;

  /// No description provided for @order_id.
  ///
  /// In en, this message translates to:
  /// **'Order Id'**
  String get order_id;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @payment_mode.
  ///
  /// In en, this message translates to:
  /// **'Payment Mode'**
  String get payment_mode;

  /// No description provided for @select_your_preferred_payment_mode.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred payment mode'**
  String get select_your_preferred_payment_mode;

  /// No description provided for @or_checkout_with.
  ///
  /// In en, this message translates to:
  /// **'Or Checkout With'**
  String get or_checkout_with;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @confirm_payment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get confirm_payment;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @featured_products.
  ///
  /// In en, this message translates to:
  /// **'Featured Products'**
  String get featured_products;

  /// No description provided for @what_they_say.
  ///
  /// In en, this message translates to:
  /// **'What They Say ?'**
  String get what_they_say;

  /// No description provided for @favorite_products.
  ///
  /// In en, this message translates to:
  /// **'Favorite Products'**
  String get favorite_products;

  /// No description provided for @options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options;

  /// No description provided for @select_options_to_add_them_on_the_product.
  ///
  /// In en, this message translates to:
  /// **'Select options to add them on the product'**
  String get select_options_to_add_them_on_the_product;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @add_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get add_to_cart;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'Faq'**
  String get faq;

  /// No description provided for @help_supports.
  ///
  /// In en, this message translates to:
  /// **'Help & Supports'**
  String get help_supports;

  /// No description provided for @app_language.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get app_language;

  /// No description provided for @i_forgot_password.
  ///
  /// In en, this message translates to:
  /// **'I forgot password ?'**
  String get i_forgot_password;

  /// No description provided for @i_dont_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'I don\'t have an account?'**
  String get i_dont_have_an_account;

  /// No description provided for @maps_explorer.
  ///
  /// In en, this message translates to:
  /// **'Maps Explorer'**
  String get maps_explorer;

  /// No description provided for @all_product.
  ///
  /// In en, this message translates to:
  /// **'All Products'**
  String get all_product;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @confirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirmation;

  /// No description provided for @your_order_has_been_successfully_submitted.
  ///
  /// In en, this message translates to:
  /// **'Your order has been successfully submitted!'**
  String get your_order_has_been_successfully_submitted;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'TAX'**
  String get tax;

  /// No description provided for @my_orders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get my_orders;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @payment_options.
  ///
  /// In en, this message translates to:
  /// **'Payment Options'**
  String get payment_options;

  /// No description provided for @cash_on_delivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery'**
  String get cash_on_delivery;

  /// No description provided for @paypal_payment.
  ///
  /// In en, this message translates to:
  /// **'PayPal Payment'**
  String get paypal_payment;

  /// No description provided for @recent_orders.
  ///
  /// In en, this message translates to:
  /// **'Recent Orders'**
  String get recent_orders;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @profile_settings.
  ///
  /// In en, this message translates to:
  /// **'Profile Settings'**
  String get profile_settings;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get full_name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @payments_settings.
  ///
  /// In en, this message translates to:
  /// **'Payments Settings'**
  String get payments_settings;

  /// No description provided for @default_credit_card.
  ///
  /// In en, this message translates to:
  /// **'Default Credit Card'**
  String get default_credit_card;

  /// No description provided for @app_settings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get app_settings;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @help_support.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get help_support;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @lets_start_with_register.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start with register!'**
  String get lets_start_with_register;

  /// No description provided for @should_be_more_than_3_letters.
  ///
  /// In en, this message translates to:
  /// **'Should be more than 3 letters'**
  String get should_be_more_than_3_letters;

  /// No description provided for @john_doe.
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get john_doe;

  /// No description provided for @should_be_a_valid_email.
  ///
  /// In en, this message translates to:
  /// **'Should be a valid email'**
  String get should_be_a_valid_email;

  /// No description provided for @should_be_more_than_6_letters.
  ///
  /// In en, this message translates to:
  /// **'Should be more than 6 letters'**
  String get should_be_more_than_6_letters;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @i_have_account_back_to_login.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get i_have_account_back_to_login;

  /// No description provided for @tracking_order.
  ///
  /// In en, this message translates to:
  /// **'Tracking Order'**
  String get tracking_order;

  /// No description provided for @discover__explorer.
  ///
  /// In en, this message translates to:
  /// **'Discover & Explorer'**
  String get discover__explorer;

  /// No description provided for @you_can_discover_markets.
  ///
  /// In en, this message translates to:
  /// **'You can discover markets & stores around you and choose you best meal after few minutes we prepare and deliver it for you'**
  String get you_can_discover_markets;

  /// No description provided for @reset_cart.
  ///
  /// In en, this message translates to:
  /// **'Reset Cart?'**
  String get reset_cart;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @shopping_cart.
  ///
  /// In en, this message translates to:
  /// **'Shopping Cart'**
  String get shopping_cart;

  /// No description provided for @verify_your_quantity_and_click_checkout.
  ///
  /// In en, this message translates to:
  /// **'Verify your quantity and click checkout'**
  String get verify_your_quantity_and_click_checkout;

  /// No description provided for @lets_start_with_login.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start with Login!'**
  String get lets_start_with_login;

  /// No description provided for @should_be_more_than_3_characters.
  ///
  /// In en, this message translates to:
  /// **'Should be more than 3 characters'**
  String get should_be_more_than_3_characters;

  /// No description provided for @you_must_add_products_of_the_same_markets_choose_one.
  ///
  /// In en, this message translates to:
  /// **'You must add products of the same markets choose one markets only!'**
  String get you_must_add_products_of_the_same_markets_choose_one;

  /// No description provided for @reset_your_cart_and_order_meals_form_this_market.
  ///
  /// In en, this message translates to:
  /// **'Reset your cart and order meals form this market'**
  String get reset_your_cart_and_order_meals_form_this_market;

  /// No description provided for @keep_your_old_meals_of_this_market.
  ///
  /// In en, this message translates to:
  /// **'Keep your old meals of this market'**
  String get keep_your_old_meals_of_this_market;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @application_preferences.
  ///
  /// In en, this message translates to:
  /// **'Application Preferences'**
  String get application_preferences;

  /// No description provided for @help__support.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get help__support;

  /// No description provided for @light_mode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get light_mode;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark_mode;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get log_out;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @dont_have_any_item_in_your_cart.
  ///
  /// In en, this message translates to:
  /// **'D\'ont have any item in your cart'**
  String get dont_have_any_item_in_your_cart;

  /// No description provided for @start_exploring.
  ///
  /// In en, this message translates to:
  /// **'Start Exploring'**
  String get start_exploring;

  /// No description provided for @dont_have_any_item_in_the_notification_list.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have any item in the notification list'**
  String get dont_have_any_item_in_the_notification_list;

  /// No description provided for @payment_settings.
  ///
  /// In en, this message translates to:
  /// **'Payment Settings'**
  String get payment_settings;

  /// No description provided for @not_a_valid_number.
  ///
  /// In en, this message translates to:
  /// **'Not a valid number'**
  String get not_a_valid_number;

  /// No description provided for @not_a_valid_date.
  ///
  /// In en, this message translates to:
  /// **'Not a valid date'**
  String get not_a_valid_date;

  /// No description provided for @not_a_valid_cvc.
  ///
  /// In en, this message translates to:
  /// **'Not a valid CVC'**
  String get not_a_valid_cvc;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @not_a_valid_full_name.
  ///
  /// In en, this message translates to:
  /// **'Not a valid full name'**
  String get not_a_valid_full_name;

  /// No description provided for @email_address.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email_address;

  /// No description provided for @not_a_valid_email.
  ///
  /// In en, this message translates to:
  /// **'Not a valid email'**
  String get not_a_valid_email;

  /// No description provided for @not_a_valid_phone.
  ///
  /// In en, this message translates to:
  /// **'Not a valid phone'**
  String get not_a_valid_phone;

  /// No description provided for @not_a_valid_address.
  ///
  /// In en, this message translates to:
  /// **'Not a valid address'**
  String get not_a_valid_address;

  /// No description provided for @not_a_valid_biography.
  ///
  /// In en, this message translates to:
  /// **'Not a valid biography'**
  String get not_a_valid_biography;

  /// No description provided for @your_biography.
  ///
  /// In en, this message translates to:
  /// **'Your biography'**
  String get your_biography;

  /// No description provided for @your_address.
  ///
  /// In en, this message translates to:
  /// **'Your Address'**
  String get your_address;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @recents_search.
  ///
  /// In en, this message translates to:
  /// **'Recent Search'**
  String get recents_search;

  /// No description provided for @verify_your_internet_connection.
  ///
  /// In en, this message translates to:
  /// **'Verify your internet connection'**
  String get verify_your_internet_connection;

  /// No description provided for @carts_refreshed_successfuly.
  ///
  /// In en, this message translates to:
  /// **'Carts refreshed successfully'**
  String get carts_refreshed_successfuly;

  /// No description provided for @the_product_was_removed_from_your_cart.
  ///
  /// In en, this message translates to:
  /// **'The {productName} was removed from your cart'**
  String get the_product_was_removed_from_your_cart;

  /// No description provided for @category_refreshed_successfuly.
  ///
  /// In en, this message translates to:
  /// **'Category refreshed successfully'**
  String get category_refreshed_successfuly;

  /// No description provided for @notifications_refreshed_successfuly.
  ///
  /// In en, this message translates to:
  /// **'Notifications refreshed successfully'**
  String get notifications_refreshed_successfuly;

  /// No description provided for @order_refreshed_successfuly.
  ///
  /// In en, this message translates to:
  /// **'Order refreshed successfully'**
  String get order_refreshed_successfuly;

  /// No description provided for @orders_refreshed_successfuly.
  ///
  /// In en, this message translates to:
  /// **'Orders refreshed successfully'**
  String get orders_refreshed_successfuly;

  /// No description provided for @market_refreshed_successfuly.
  ///
  /// In en, this message translates to:
  /// **'Market refreshed successfully'**
  String get market_refreshed_successfuly;

  /// No description provided for @profile_settings_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Profile settings updated successfully'**
  String get profile_settings_updated_successfully;

  /// No description provided for @payment_settings_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Payment settings updated successfully'**
  String get payment_settings_updated_successfully;

  /// No description provided for @tracking_refreshed_successfuly.
  ///
  /// In en, this message translates to:
  /// **'Tracking refreshed successfully'**
  String get tracking_refreshed_successfuly;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @wrong_email_or_password.
  ///
  /// In en, this message translates to:
  /// **'Wrong phone or password'**
  String get wrong_email_or_password;

  /// No description provided for @addresses_refreshed_successfuly.
  ///
  /// In en, this message translates to:
  /// **'Addresses refreshed successfully'**
  String get addresses_refreshed_successfuly;

  /// No description provided for @delivery_addresses.
  ///
  /// In en, this message translates to:
  /// **'Delivery Addresses'**
  String get delivery_addresses;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @new_address_added_successfully.
  ///
  /// In en, this message translates to:
  /// **'New Address added successfully'**
  String get new_address_added_successfully;

  /// No description provided for @the_address_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'The address updated successfully'**
  String get the_address_updated_successfully;

  /// No description provided for @long_press_to_edit_item_swipe_item_to_delete_it.
  ///
  /// In en, this message translates to:
  /// **'Long press to edit item, swipe item to delete it'**
  String get long_press_to_edit_item_swipe_item_to_delete_it;

  /// No description provided for @add_delivery_address.
  ///
  /// In en, this message translates to:
  /// **'Add Delivery Address'**
  String get add_delivery_address;

  /// No description provided for @home_address.
  ///
  /// In en, this message translates to:
  /// **'Home Address'**
  String get home_address;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @hint_full_address.
  ///
  /// In en, this message translates to:
  /// **'12 Street, City 21663, Country'**
  String get hint_full_address;

  /// No description provided for @full_address.
  ///
  /// In en, this message translates to:
  /// **'Full Address'**
  String get full_address;

  /// No description provided for @email_to_reset_password.
  ///
  /// In en, this message translates to:
  /// **'Email to reset password'**
  String get email_to_reset_password;

  /// No description provided for @send_password_reset_link.
  ///
  /// In en, this message translates to:
  /// **'Send link'**
  String get send_password_reset_link;

  /// No description provided for @i_remember_my_password_return_to_login.
  ///
  /// In en, this message translates to:
  /// **'I remember my password return to login'**
  String get i_remember_my_password_return_to_login;

  /// No description provided for @your_reset_link_has_been_sent_to_your_email.
  ///
  /// In en, this message translates to:
  /// **'Your reset link has been sent to your email'**
  String get your_reset_link_has_been_sent_to_your_email;

  /// No description provided for @error_verify_email_settings.
  ///
  /// In en, this message translates to:
  /// **'Error! Verify email settings'**
  String get error_verify_email_settings;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @you_must_signin_to_access_to_this_section.
  ///
  /// In en, this message translates to:
  /// **'You must sign-in to access to this section'**
  String get you_must_signin_to_access_to_this_section;

  /// No description provided for @tell_us_about_this_market.
  ///
  /// In en, this message translates to:
  /// **'Tell us about this market'**
  String get tell_us_about_this_market;

  /// No description provided for @how_would_you_rate_this_market_.
  ///
  /// In en, this message translates to:
  /// **'How would you rate this market ?'**
  String get how_would_you_rate_this_market_;

  /// No description provided for @tell_us_about_this_product.
  ///
  /// In en, this message translates to:
  /// **'Tell us about this product'**
  String get tell_us_about_this_product;

  /// No description provided for @the_market_has_been_rated_successfully.
  ///
  /// In en, this message translates to:
  /// **'The market has been rated successfully'**
  String get the_market_has_been_rated_successfully;

  /// No description provided for @the_product_has_been_rated_successfully.
  ///
  /// In en, this message translates to:
  /// **'The product has been rated successfully'**
  String get the_product_has_been_rated_successfully;

  /// No description provided for @reviews_refreshed_successfully.
  ///
  /// In en, this message translates to:
  /// **'Reviews refreshed successfully!'**
  String get reviews_refreshed_successfully;

  /// No description provided for @delivery_fee.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get delivery_fee;

  /// No description provided for @order_status_changed.
  ///
  /// In en, this message translates to:
  /// **'Order status changed'**
  String get order_status_changed;

  /// No description provided for @new_order_from_client.
  ///
  /// In en, this message translates to:
  /// **'New order from client'**
  String get new_order_from_client;

  /// No description provided for @shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// No description provided for @delivery_or_pickup.
  ///
  /// In en, this message translates to:
  /// **'Delivery or Pickup'**
  String get delivery_or_pickup;

  /// No description provided for @payment_card_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Payment card updated successfully'**
  String get payment_card_updated_successfully;

  /// No description provided for @deliverable.
  ///
  /// In en, this message translates to:
  /// **'Deliverable'**
  String get deliverable;

  /// No description provided for @not_deliverable.
  ///
  /// In en, this message translates to:
  /// **'Not Deliverable'**
  String get not_deliverable;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @pickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get pickup;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'Km'**
  String get km;

  /// No description provided for @mi.
  ///
  /// In en, this message translates to:
  /// **'mi'**
  String get mi;

  /// No description provided for @delivery_address.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get delivery_address;

  /// No description provided for @current_location.
  ///
  /// In en, this message translates to:
  /// **'Current location'**
  String get current_location;

  /// No description provided for @delivery_address_removed_successfully.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address removed successfully'**
  String get delivery_address_removed_successfully;

  /// No description provided for @add_new_delivery_address.
  ///
  /// In en, this message translates to:
  /// **'Add new delivery address'**
  String get add_new_delivery_address;

  /// No description provided for @markets_near_to_your_current_location.
  ///
  /// In en, this message translates to:
  /// **'Markets near to your current location'**
  String get markets_near_to_your_current_location;

  /// No description provided for @markets_near_to.
  ///
  /// In en, this message translates to:
  /// **'Markets near to'**
  String get markets_near_to;

  /// No description provided for @near_to.
  ///
  /// In en, this message translates to:
  /// **'Near to'**
  String get near_to;

  /// No description provided for @near_to_your_current_location.
  ///
  /// In en, this message translates to:
  /// **'Near to your current location'**
  String get near_to_your_current_location;

  /// No description provided for @pickup_your_product_from_the_market.
  ///
  /// In en, this message translates to:
  /// **'Pickup your product from the market'**
  String get pickup_your_product_from_the_market;

  /// No description provided for @confirm_your_delivery_address.
  ///
  /// In en, this message translates to:
  /// **'Confirm your delivery address'**
  String get confirm_your_delivery_address;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @apply_filters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get apply_filters;

  /// No description provided for @opened_markets.
  ///
  /// In en, this message translates to:
  /// **'Opened Markets'**
  String get opened_markets;

  /// No description provided for @fields.
  ///
  /// In en, this message translates to:
  /// **'Fields'**
  String get fields;

  /// No description provided for @this_product_was_added_to_cart.
  ///
  /// In en, this message translates to:
  /// **'This product was added to cart'**
  String get this_product_was_added_to_cart;

  /// No description provided for @products_result.
  ///
  /// In en, this message translates to:
  /// **'Products result'**
  String get products_result;

  /// No description provided for @products_results.
  ///
  /// In en, this message translates to:
  /// **'Products Results'**
  String get products_results;

  /// No description provided for @markets_results.
  ///
  /// In en, this message translates to:
  /// **'Markets Results'**
  String get markets_results;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @this_market_is_closed_.
  ///
  /// In en, this message translates to:
  /// **'This market is closed !'**
  String get this_market_is_closed_;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @how_would_you_rate_this_market.
  ///
  /// In en, this message translates to:
  /// **'How would you rate this market ?'**
  String get how_would_you_rate_this_market;

  /// No description provided for @click_on_the_stars_below_to_leave_comments.
  ///
  /// In en, this message translates to:
  /// **'Click on the stars below to leave comments'**
  String get click_on_the_stars_below_to_leave_comments;

  /// No description provided for @click_to_confirm_your_address_and_pay_or_long_press.
  ///
  /// In en, this message translates to:
  /// **'Click to confirm your address and pay or Long press to edit your address'**
  String get click_to_confirm_your_address_and_pay_or_long_press;

  /// No description provided for @visa_card.
  ///
  /// In en, this message translates to:
  /// **'Visa Card'**
  String get visa_card;

  /// No description provided for @mastercard.
  ///
  /// In en, this message translates to:
  /// **'MasterCard'**
  String get mastercard;

  /// No description provided for @paypal.
  ///
  /// In en, this message translates to:
  /// **'PayPal'**
  String get paypal;

  /// No description provided for @pay_on_pickup.
  ///
  /// In en, this message translates to:
  /// **'Pay on Pickup'**
  String get pay_on_pickup;

  /// No description provided for @click_to_pay_with_your_visa_card.
  ///
  /// In en, this message translates to:
  /// **'Click to pay with your Visa Card'**
  String get click_to_pay_with_your_visa_card;

  /// No description provided for @click_to_pay_with_your_mastercard.
  ///
  /// In en, this message translates to:
  /// **'Click to pay with your MasterCard'**
  String get click_to_pay_with_your_mastercard;

  /// No description provided for @click_to_pay_with_your_paypal_account.
  ///
  /// In en, this message translates to:
  /// **'Click to pay with your PayPal account'**
  String get click_to_pay_with_your_paypal_account;

  /// No description provided for @click_to_pay_cash_on_delivery.
  ///
  /// In en, this message translates to:
  /// **'Click to pay cash on delivery'**
  String get click_to_pay_cash_on_delivery;

  /// No description provided for @click_to_pay_on_pickup.
  ///
  /// In en, this message translates to:
  /// **'Click to pay on pickup'**
  String get click_to_pay_on_pickup;

  /// No description provided for @this_email_account_exists.
  ///
  /// In en, this message translates to:
  /// **'This email account exists'**
  String get this_email_account_exists;

  /// No description provided for @this_account_not_exist.
  ///
  /// In en, this message translates to:
  /// **'This account not exist'**
  String get this_account_not_exist;

  /// No description provided for @card_number.
  ///
  /// In en, this message translates to:
  /// **'CARD NUMBER'**
  String get card_number;

  /// No description provided for @expiry_date.
  ///
  /// In en, this message translates to:
  /// **'EXPIRY DATE'**
  String get expiry_date;

  /// No description provided for @cvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// No description provided for @your_credit_card_not_valid.
  ///
  /// In en, this message translates to:
  /// **'Your credit card not valid'**
  String get your_credit_card_not_valid;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get number;

  /// No description provided for @exp_date.
  ///
  /// In en, this message translates to:
  /// **'Exp Date'**
  String get exp_date;

  /// No description provided for @cvc.
  ///
  /// In en, this message translates to:
  /// **'CVC'**
  String get cvc;

  /// No description provided for @completeYourProfileDetailsToContinue.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile details to continue'**
  String get completeYourProfileDetailsToContinue;

  /// No description provided for @deliveryAddressOutsideTheDeliveryRangeOfThisMarkets.
  ///
  /// In en, this message translates to:
  /// **'Delivery address outside the delivery range of this markets.'**
  String get deliveryAddressOutsideTheDeliveryRangeOfThisMarkets;

  /// No description provided for @thisMarketNotSupportDeliveryMethod.
  ///
  /// In en, this message translates to:
  /// **'This market not support delivery method.'**
  String get thisMarketNotSupportDeliveryMethod;

  /// No description provided for @oneOrMoreProductsInYourCartNotDeliverable.
  ///
  /// In en, this message translates to:
  /// **'One or more products in your cart not deliverable.'**
  String get oneOrMoreProductsInYourCartNotDeliverable;

  /// No description provided for @deliveryMethodNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Delivery method not allowed!'**
  String get deliveryMethodNotAllowed;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @youDontHaveAnyOrder.
  ///
  /// In en, this message translates to:
  /// **'You don\'t  have any order'**
  String get youDontHaveAnyOrder;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get canceled;

  /// No description provided for @cancelOrder.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get cancelOrder;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @areYouSureYouWantToCancelThisOrder.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this order?'**
  String get areYouSureYouWantToCancelThisOrder;

  /// No description provided for @orderThisorderidHasBeenCanceled.
  ///
  /// In en, this message translates to:
  /// **'Order: #{id} has been canceled'**
  String get orderThisorderidHasBeenCanceled;

  /// No description provided for @clickOnTheProductToGetMoreDetailsAboutIt.
  ///
  /// In en, this message translates to:
  /// **'Click on the product to get more details about it'**
  String get clickOnTheProductToGetMoreDetailsAboutIt;

  /// No description provided for @tapAgainToLeave.
  ///
  /// In en, this message translates to:
  /// **'Tap again to leave'**
  String get tapAgainToLeave;

  /// No description provided for @favorites_refreshed_successfuly.
  ///
  /// In en, this message translates to:
  /// **'Favorites refreshed successfully'**
  String get favorites_refreshed_successfuly;

  /// No description provided for @faqsRefreshedSuccessfuly.
  ///
  /// In en, this message translates to:
  /// **'Faqs refreshed successfully'**
  String get faqsRefreshedSuccessfuly;

  /// No description provided for @thisProductWasAddedToFavorite.
  ///
  /// In en, this message translates to:
  /// **'This product was added to favorite'**
  String get thisProductWasAddedToFavorite;

  /// No description provided for @thisProductWasRemovedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'This product was removed from favorites'**
  String get thisProductWasRemovedFromFavorites;

  /// No description provided for @productRefreshedSuccessfuly.
  ///
  /// In en, this message translates to:
  /// **'Product refreshed successfully'**
  String get productRefreshedSuccessfuly;

  /// No description provided for @razorpayPayment.
  ///
  /// In en, this message translates to:
  /// **'RazorPay Payment'**
  String get razorpayPayment;

  /// No description provided for @razorpay.
  ///
  /// In en, this message translates to:
  /// **'RazorPay'**
  String get razorpay;

  /// No description provided for @clickToPayWithRazorpayMethod.
  ///
  /// In en, this message translates to:
  /// **'Click to pay with RazorPay method'**
  String get clickToPayWithRazorpayMethod;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @validCouponCode.
  ///
  /// In en, this message translates to:
  /// **'Valid Coupon'**
  String get validCouponCode;

  /// No description provided for @invalidCouponCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid Coupon'**
  String get invalidCouponCode;

  /// No description provided for @haveCouponCode.
  ///
  /// In en, this message translates to:
  /// **'Have Coupon Code?'**
  String get haveCouponCode;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @youDontHaveAnyConversations.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any conversations'**
  String get youDontHaveAnyConversations;

  /// No description provided for @newMessageFrom.
  ///
  /// In en, this message translates to:
  /// **'New message from'**
  String get newMessageFrom;

  /// No description provided for @forMoreDetailsPleaseChatWithOurManagers.
  ///
  /// In en, this message translates to:
  /// **'For more details, please chat with our managers'**
  String get forMoreDetailsPleaseChatWithOurManagers;

  /// No description provided for @signinToChatWithOurManagers.
  ///
  /// In en, this message translates to:
  /// **'Sign-In to chat with our managers'**
  String get signinToChatWithOurManagers;

  /// No description provided for @typeToStartChat.
  ///
  /// In en, this message translates to:
  /// **'Type to start chat'**
  String get typeToStartChat;

  /// No description provided for @makeItDefault.
  ///
  /// In en, this message translates to:
  /// **'Make it default'**
  String get makeItDefault;

  /// No description provided for @notValidAddress.
  ///
  /// In en, this message translates to:
  /// **'Not valid address'**
  String get notValidAddress;

  /// No description provided for @swipeLeftTheNotificationToDeleteOrReadUnreadIt.
  ///
  /// In en, this message translates to:
  /// **'Swipe left the notification to delete or read / unread it'**
  String get swipeLeftTheNotificationToDeleteOrReadUnreadIt;

  /// No description provided for @thisNotificationHasMarkedAsUnread.
  ///
  /// In en, this message translates to:
  /// **'This notification has marked as unread'**
  String get thisNotificationHasMarkedAsUnread;

  /// No description provided for @notificationWasRemoved.
  ///
  /// In en, this message translates to:
  /// **'Notification was removed'**
  String get notificationWasRemoved;

  /// No description provided for @thisNotificationHasMarkedAsRead.
  ///
  /// In en, this message translates to:
  /// **'This notification has marked as read'**
  String get thisNotificationHasMarkedAsRead;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy and Policy'**
  String get privacy_policy;

  /// No description provided for @contact_us.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @name_should_be_2.
  ///
  /// In en, this message translates to:
  /// **'The name should be more than 2 characters.'**
  String get name_should_be_2;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @current_orders.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get current_orders;

  /// No description provided for @completed_orders.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed_orders;

  /// No description provided for @pending_orders.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending_orders;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @do_you_accept_order.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to accept this order?'**
  String get do_you_accept_order;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @veri_code.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get veri_code;

  /// No description provided for @please_input_phone.
  ///
  /// In en, this message translates to:
  /// **'Please input your phone number and get sms verification code.'**
  String get please_input_phone;

  /// No description provided for @sent_a_veri_code.
  ///
  /// In en, this message translates to:
  /// **'Sent a verification code to verify your account'**
  String get sent_a_veri_code;

  /// No description provided for @send_code.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get send_code;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @incorrect_veri_code.
  ///
  /// In en, this message translates to:
  /// **'Incorrect your verification code, please retype your code.'**
  String get incorrect_veri_code;

  /// No description provided for @enter_your_code.
  ///
  /// In en, this message translates to:
  /// **'Enter your Verification Code'**
  String get enter_your_code;

  /// No description provided for @phone_10_digits.
  ///
  /// In en, this message translates to:
  /// **'Phone number should be more than 10 digits.'**
  String get phone_10_digits;

  /// No description provided for @incorrect_phone.
  ///
  /// In en, this message translates to:
  /// **'Incorrect phone number'**
  String get incorrect_phone;

  /// No description provided for @est_price.
  ///
  /// In en, this message translates to:
  /// **'Estimated price'**
  String get est_price;

  /// No description provided for @confirmed_price.
  ///
  /// In en, this message translates to:
  /// **'Confirmed price'**
  String get confirmed_price;

  /// No description provided for @final_price.
  ///
  /// In en, this message translates to:
  /// **'Final price'**
  String get final_price;

  /// No description provided for @order_search.
  ///
  /// In en, this message translates to:
  /// **'Order Search'**
  String get order_search;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @near_to_location.
  ///
  /// In en, this message translates to:
  /// **'Near to your location'**
  String get near_to_location;

  /// No description provided for @sort_by_price.
  ///
  /// In en, this message translates to:
  /// **'Sort by order price'**
  String get sort_by_price;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit_profile;

  /// No description provided for @veri_code_6_digits.
  ///
  /// In en, this message translates to:
  /// **'Verification Code should be 6 digits.'**
  String get veri_code_6_digits;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(_lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations _lookupAppLocalizations(Locale locale) {
  

// Lookup logic when language+country codes are specified.
switch (locale.languageCode) {
  case 'zh': {
  switch (locale.countryCode) {
    case 'CN': return AppLocalizationsZhCn();
  }
  break;
}
}

// Lookup logic when only language code is specified.
switch (locale.languageCode) {
  case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
}


  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
