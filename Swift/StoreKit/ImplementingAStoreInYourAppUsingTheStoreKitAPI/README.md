# Implementing a store in your app using the StoreKit API

Offer In-App Purchases and manage entitlements using signed transactions and status information.

## Overview

- Note:
  This sample code project is associated with WWDC22 session [110404: Implement proactive in-app purchase restore](https://developer.apple.com/wwdc22/110404/).
  
  It's also associated with WWDC21 session [10114: Meet StoreKit 2](https://developer.apple.com/wwdc21/10114/).

## Configure the sample code project

This sample code project uses StoreKit Testing in Xcode so you can build and run the sample app without needing to configure In-App Purchase products in App Store Connect. The project defines the products for the StoreKit testing environment in the `Products.storekit` configuration. The project includes the `Products.plist` as a resource file, which contains product identifiers that map to emoji characters.

By default, StoreKit Testing in Xcode is in a disabled state. Follow these steps to select the `Products.storekit` configuration file and enable StoreKit Testing in Xcode:
1. Choose Product > Scheme > Edit Scheme.
2. In the scheme editor, select the Run action.
3. Click Options in the action settings.
4. For the StoreKit Configuration option, select the `Products.storekit` configuration file from the dropdown menu.

When the app initializes a store, it reads the `Products.plist` resource to get the product identifiers, and requests the products. Because you enable StoreKit Testing in Xcode for this project, the system returns the products from the testing environment instead of from App Store Connect.
