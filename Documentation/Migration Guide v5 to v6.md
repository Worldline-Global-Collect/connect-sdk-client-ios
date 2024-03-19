# Migrating from version 5.x.x to 6.x.x

## Dependency
The name of the SDK has been modified to `WorldlineConnectSDK`. You need to update your dependencies:

### Cocoapods:
Update your `Podfile` by using the new SDK Pod name:
```
pod 'WorldlineConnectSDK'
```

Afterwards, run the following command:
```
pod install
```

### Carthage:
Update your `Cartfile` with the new Github location of the SDK:
```
github "Worldline-Global-Collect/connect-sdk-client-ios"
```

Afterwards, run the following command:
```
carthage update
```

## Imports
Update your imports to the new naming of the SDK and its files.
- `IngenicoConnectSDK` becomes `WordlineConnectSDK`.
- All header files that contain the "IC" prefix, need to have the "WC" prefix instead.

## Removed
The following enums have been removed:
- `WCRegion`
- `WCEnvironment`

The following interface and implementation class has been removed: 
- `WCAFNetworkingWrapper`

The following methods have been removed:
- `isEnvironmentTypeProduction` in `WCC2SCommunicator`
- Constructors in `WCC2SCommunicatorConfiguration` that used the `WCRegion` and `WCEnvironment` enums.
- `validateValue` in `WCPaymentProductField`
- `isEnvironmentTypeProduction` in `WCSession`
- All previously deprecated `sessionWithClientSessionId` methods in `WCSession`
- `base64EncodedClientMetaInfo` in `WCUtil`
- `base64EncodedClientMetaInfoWithAddedData` in `WCUtil`
- `C2SBaseURLByRegion` in `WCUtil`
- `assetsBaseURLByRegion` in `WCUtil`

The following constants have been removed: 
- `kWCCountryCodes` and `kWCCurrencyCodes` in `WCSDKConstants`
