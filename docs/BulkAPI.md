# BulkAPI

All URIs are relative to *https://api.allscreenshots.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**cancelBulkJob**](BulkAPI.md#cancelbulkjob) | **POST** /v1/screenshots/bulk/{id}/cancel | 
[**createBulkJob**](BulkAPI.md#createbulkjob) | **POST** /v1/screenshots/bulk | 
[**getBulkJobStatus**](BulkAPI.md#getbulkjobstatus) | **GET** /v1/screenshots/bulk/{id} | 
[**listBulkJobs**](BulkAPI.md#listbulkjobs) | **GET** /v1/screenshots/bulk | 


# **cancelBulkJob**
```swift
    open class func cancelBulkJob(id: String, completion: @escaping (_ data: BulkJobSummary?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 

BulkAPI.cancelBulkJob(id: id) { (response, error) in
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

[**BulkJobSummary**](BulkJobSummary.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createBulkJob**
```swift
    open class func createBulkJob(bulkRequest: BulkRequest, completion: @escaping (_ data: BulkResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let bulkRequest = BulkRequest(defaults: BulkDefaults(actions: [PageAction(_optional: false, selector: "selector_example", timeout: 123, type: "type_example", clear: false, text: "text_example", key: "key_example", value: "value_example", toBottom: false, y: 123, ms: 123, networkIdle: false)], blockAds: false, blockCookieBanners: false, blockLevel: "blockLevel_example", blockPopups: false, customCss: "customCss_example", darkMode: false, delay: 123, device: "device_example", format: "format_example", fullPage: false, outputs: [OutputSpec(format: "format_example", fullPage: false, id: "id_example", quality: 123, selector: "selector_example", type: "type_example", landscape: false, printBackground: false, clean: false, mainContentOnly: false, schema: "TODO")], quality: 123, stealthMode: false, timeout: 123, viewport: ViewportConfig(deviceScaleFactor: 123, height: 123, width: 123), waitFor: "waitFor_example", waitUntil: "waitUntil_example"), urls: [BulkUrlRequest(options: BulkUrlOptions(actions: [nil], blockAds: false, blockCookieBanners: false, blockLevel: "blockLevel_example", blockPopups: false, customCss: "customCss_example", darkMode: false, delay: 123, device: "device_example", format: "format_example", fullPage: false, outputs: [nil], quality: 123, stealthMode: false, viewport: nil, waitFor: "waitFor_example", waitUntil: "waitUntil_example"), url: "url_example")], webhookSecret: "webhookSecret_example", webhookUrl: "webhookUrl_example") // BulkRequest | 

BulkAPI.createBulkJob(bulkRequest: bulkRequest) { (response, error) in
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
 **bulkRequest** | [**BulkRequest**](BulkRequest.md) |  | 

### Return type

[**BulkResponse**](BulkResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getBulkJobStatus**
```swift
    open class func getBulkJobStatus(id: String, completion: @escaping (_ data: BulkStatusResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 

BulkAPI.getBulkJobStatus(id: id) { (response, error) in
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

[**BulkStatusResponse**](BulkStatusResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listBulkJobs**
```swift
    open class func listBulkJobs(completion: @escaping (_ data: [BulkJobSummary]?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK


BulkAPI.listBulkJobs() { (response, error) in
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

[**[BulkJobSummary]**](BulkJobSummary.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

