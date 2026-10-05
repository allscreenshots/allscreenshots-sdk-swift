# JobAPI

All URIs are relative to *https://api.allscreenshots.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**cancelJob**](JobAPI.md#canceljob) | **POST** /v1/screenshots/jobs/{id}/cancel | 
[**createAsyncJob**](JobAPI.md#createasyncjob) | **POST** /v1/screenshots/async | 
[**getJobOutputResult**](JobAPI.md#getjoboutputresult) | **GET** /v1/screenshots/jobs/{id}/result/{outputId} | 
[**getJobResult**](JobAPI.md#getjobresult) | **GET** /v1/screenshots/jobs/{id}/result | 
[**getJobStatus**](JobAPI.md#getjobstatus) | **GET** /v1/screenshots/jobs/{id} | 
[**listJobs**](JobAPI.md#listjobs) | **GET** /v1/screenshots/jobs | 


# **cancelJob**
```swift
    open class func cancelJob(id: String, completion: @escaping (_ data: JobResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 

JobAPI.cancelJob(id: id) { (response, error) in
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

[**JobResponse**](JobResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createAsyncJob**
```swift
    open class func createAsyncJob(screenshotRequest: ScreenshotRequest, idempotencyKey: String? = nil, completion: @escaping (_ data: AsyncJobCreatedResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let screenshotRequest = ScreenshotRequest(actions: [PageAction(_optional: false, selector: "selector_example", timeout: 123, type: "type_example", clear: false, text: "text_example", key: "key_example", value: "value_example", toBottom: false, y: 123, ms: 123, networkIdle: false)], blockAds: false, blockCookieBanners: false, blockLevel: "blockLevel_example", blockPopups: false, customCss: "customCss_example", darkMode: false, delay: 123, device: "device_example", format: "format_example", freezeFixed: false, fullPage: false, fullPageMode: "fullPageMode_example", hideSelectors: ["hideSelectors_example"], maxHeight: 123, maxSections: 123, outputs: [OutputSpec(format: "format_example", fullPage: false, id: "id_example", quality: 123, selector: "selector_example", type: "type_example", landscape: false, printBackground: false, clean: false, mainContentOnly: false, schema: "TODO")], quality: 123, responseType: "responseType_example", scrollInterval: 123, selector: "selector_example", session: BrowserSessionRequest(cookies: [BrowserCookieRequest(domain: "domain_example", expires: 123, httpOnly: false, name: "name_example", path: "path_example", sameSite: "sameSite_example", secure: false, value: "value_example")], headers: [BrowserHeaderRequest(name: "name_example", origin: "origin_example", value: "value_example")], storage: [BrowserStorageOriginRequest(localStorage: "TODO", origin: "origin_example", sessionStorage: "TODO")]), stealthMode: false, timeout: 123, url: "url_example", viewport: ViewportConfig(deviceScaleFactor: 123, height: 123, width: 123), waitFor: "waitFor_example", waitUntil: "waitUntil_example", webhookSecret: "webhookSecret_example", webhookUrl: "webhookUrl_example") // ScreenshotRequest | 
let idempotencyKey = "idempotencyKey_example" // String | Unique submission key. Supported for responseType=url; reuse with the same body to recover the original result. (optional)

JobAPI.createAsyncJob(screenshotRequest: screenshotRequest, idempotencyKey: idempotencyKey) { (response, error) in
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
 **screenshotRequest** | [**ScreenshotRequest**](ScreenshotRequest.md) |  | 
 **idempotencyKey** | **String** | Unique submission key. Supported for responseType&#x3D;url; reuse with the same body to recover the original result. | [optional] 

### Return type

[**AsyncJobCreatedResponse**](AsyncJobCreatedResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getJobOutputResult**
```swift
    open class func getJobOutputResult(id: String, outputId: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 
let outputId = "outputId_example" // String | 

JobAPI.getJobOutputResult(id: id, outputId: outputId) { (response, error) in
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
 **outputId** | **String** |  | 

### Return type

**Data**

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/octet-stream, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getJobResult**
```swift
    open class func getJobResult(id: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 

JobAPI.getJobResult(id: id) { (response, error) in
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

**Data**

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/octet-stream, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getJobStatus**
```swift
    open class func getJobStatus(id: String, completion: @escaping (_ data: JobResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 

JobAPI.getJobStatus(id: id) { (response, error) in
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

[**JobResponse**](JobResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listJobs**
```swift
    open class func listJobs(completion: @escaping (_ data: [JobResponse]?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK


JobAPI.listJobs() { (response, error) in
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

[**[JobResponse]**](JobResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

