# ScheduleAPI

All URIs are relative to *https://api.allscreenshots.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createSchedule**](ScheduleAPI.md#createschedule) | **POST** /v1/schedules | 
[**deleteSchedule**](ScheduleAPI.md#deleteschedule) | **DELETE** /v1/schedules/{id} | 
[**getExecutionHistory**](ScheduleAPI.md#getexecutionhistory) | **GET** /v1/schedules/{id}/history | 
[**getSchedule**](ScheduleAPI.md#getschedule) | **GET** /v1/schedules/{id} | 
[**listSchedules**](ScheduleAPI.md#listschedules) | **GET** /v1/schedules | 
[**pauseSchedule**](ScheduleAPI.md#pauseschedule) | **POST** /v1/schedules/{id}/pause | 
[**resumeSchedule**](ScheduleAPI.md#resumeschedule) | **POST** /v1/schedules/{id}/resume | 
[**triggerSchedule**](ScheduleAPI.md#triggerschedule) | **POST** /v1/schedules/{id}/trigger | 
[**updateSchedule**](ScheduleAPI.md#updateschedule) | **PUT** /v1/schedules/{id} | 


# **createSchedule**
```swift
    open class func createSchedule(createScheduleRequest: CreateScheduleRequest, completion: @escaping (_ data: ScheduleResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let createScheduleRequest = CreateScheduleRequest(alertOnFailure: false, autoPauseAfterFailures: 123, destinations: [DeliveryDestination(id: "id_example", onlyOnChange: false, subject: "subject_example", to: ["to_example"], type: "type_example", secret: "secret_example", url: "url_example")], diffThreshold: 123, endsAt: Date(), name: "name_example", onlyOnChange: false, options: ScheduleScreenshotOptions(actions: [PageAction(_optional: false, selector: "selector_example", timeout: 123, type: "type_example", clear: false, text: "text_example", key: "key_example", value: "value_example", toBottom: false, y: 123, ms: 123, networkIdle: false)], blockAds: false, blockCookieBanners: false, blockLevel: "blockLevel_example", blockPopups: false, customCss: "customCss_example", darkMode: false, delay: 123, device: "device_example", format: "format_example", freezeFixed: false, fullPage: false, fullPageMode: "fullPageMode_example", hideSelectors: ["hideSelectors_example"], maxHeight: 123, maxSections: 123, outputs: [OutputSpec(format: "format_example", fullPage: false, id: "id_example", quality: 123, selector: "selector_example", type: "type_example", landscape: false, printBackground: false, clean: false, mainContentOnly: false, schema: "TODO")], quality: 123, scrollInterval: 123, selector: "selector_example", stealthMode: false, timeout: 123, viewport: ViewportConfig(deviceScaleFactor: 123, height: 123, width: 123), waitFor: "waitFor_example", waitUntil: "waitUntil_example"), retentionDays: 123, schedule: "schedule_example", startsAt: Date(), timezone: "timezone_example", url: "url_example", webhookSecret: "webhookSecret_example", webhookUrl: "webhookUrl_example") // CreateScheduleRequest | 

ScheduleAPI.createSchedule(createScheduleRequest: createScheduleRequest) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createScheduleRequest** | [**CreateScheduleRequest**](CreateScheduleRequest.md) |  | 

### Return type

[**ScheduleResponse**](ScheduleResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteSchedule**
```swift
    open class func deleteSchedule(id: String, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 

ScheduleAPI.deleteSchedule(id: id) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String** |  | 

### Return type

Void (empty response body)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getExecutionHistory**
```swift
    open class func getExecutionHistory(id: String, limit: Int? = nil, completion: @escaping (_ data: ScheduleHistoryResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 
let limit = 987 // Int |  (optional) (default to 50)

ScheduleAPI.getExecutionHistory(id: id, limit: limit) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String** |  | 
 **limit** | **Int** |  | [optional] [default to 50]

### Return type

[**ScheduleHistoryResponse**](ScheduleHistoryResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSchedule**
```swift
    open class func getSchedule(id: String, completion: @escaping (_ data: ScheduleResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 

ScheduleAPI.getSchedule(id: id) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String** |  | 

### Return type

[**ScheduleResponse**](ScheduleResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listSchedules**
```swift
    open class func listSchedules(completion: @escaping (_ data: ScheduleListResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK


ScheduleAPI.listSchedules() { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ScheduleListResponse**](ScheduleListResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **pauseSchedule**
```swift
    open class func pauseSchedule(id: String, completion: @escaping (_ data: ScheduleResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 

ScheduleAPI.pauseSchedule(id: id) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String** |  | 

### Return type

[**ScheduleResponse**](ScheduleResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resumeSchedule**
```swift
    open class func resumeSchedule(id: String, completion: @escaping (_ data: ScheduleResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 

ScheduleAPI.resumeSchedule(id: id) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String** |  | 

### Return type

[**ScheduleResponse**](ScheduleResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **triggerSchedule**
```swift
    open class func triggerSchedule(id: String, completion: @escaping (_ data: ScheduleResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 

ScheduleAPI.triggerSchedule(id: id) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String** |  | 

### Return type

[**ScheduleResponse**](ScheduleResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSchedule**
```swift
    open class func updateSchedule(id: String, updateScheduleRequest: UpdateScheduleRequest, completion: @escaping (_ data: ScheduleResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 
let updateScheduleRequest = UpdateScheduleRequest(alertOnFailure: false, autoPauseAfterFailures: 123, destinations: [DeliveryDestination(id: "id_example", onlyOnChange: false, subject: "subject_example", to: ["to_example"], type: "type_example", secret: "secret_example", url: "url_example")], diffThreshold: 123, endsAt: Date(), name: "name_example", onlyOnChange: false, options: ScheduleScreenshotOptions(actions: [PageAction(_optional: false, selector: "selector_example", timeout: 123, type: "type_example", clear: false, text: "text_example", key: "key_example", value: "value_example", toBottom: false, y: 123, ms: 123, networkIdle: false)], blockAds: false, blockCookieBanners: false, blockLevel: "blockLevel_example", blockPopups: false, customCss: "customCss_example", darkMode: false, delay: 123, device: "device_example", format: "format_example", freezeFixed: false, fullPage: false, fullPageMode: "fullPageMode_example", hideSelectors: ["hideSelectors_example"], maxHeight: 123, maxSections: 123, outputs: [OutputSpec(format: "format_example", fullPage: false, id: "id_example", quality: 123, selector: "selector_example", type: "type_example", landscape: false, printBackground: false, clean: false, mainContentOnly: false, schema: "TODO")], quality: 123, scrollInterval: 123, selector: "selector_example", stealthMode: false, timeout: 123, viewport: ViewportConfig(deviceScaleFactor: 123, height: 123, width: 123), waitFor: "waitFor_example", waitUntil: "waitUntil_example"), retentionDays: 123, schedule: "schedule_example", startsAt: Date(), timezone: "timezone_example", url: "url_example", webhookSecret: "webhookSecret_example", webhookUrl: "webhookUrl_example") // UpdateScheduleRequest | 

ScheduleAPI.updateSchedule(id: id, updateScheduleRequest: updateScheduleRequest) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String** |  | 
 **updateScheduleRequest** | [**UpdateScheduleRequest**](UpdateScheduleRequest.md) |  | 

### Return type

[**ScheduleResponse**](ScheduleResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

