# CrawlAPI

All URIs are relative to *https://api.allscreenshots.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**callGet**](CrawlAPI.md#callget) | **GET** /v1/crawls/{id} | 
[**cancel**](CrawlAPI.md#cancel) | **POST** /v1/crawls/{id}/cancel | 
[**create**](CrawlAPI.md#create) | **POST** /v1/crawls | 
[**delete**](CrawlAPI.md#delete) | **DELETE** /v1/crawls/{id} | 
[**list**](CrawlAPI.md#list) | **GET** /v1/crawls | 
[**output**](CrawlAPI.md#output) | **GET** /v1/crawls/{id}/pages/{pageId}/outputs/{output} | 
[**pages**](CrawlAPI.md#pages) | **GET** /v1/crawls/{id}/pages | 


# **callGet**
```swift
    open class func callGet(id: String, completion: @escaping (_ data: CrawlResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 

CrawlAPI.callGet(id: id) { (response, error) in
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

[**CrawlResponse**](CrawlResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cancel**
```swift
    open class func cancel(id: String, completion: @escaping (_ data: CrawlResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 

CrawlAPI.cancel(id: id) { (response, error) in
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

[**CrawlResponse**](CrawlResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **create**
```swift
    open class func create(crawlRequest: CrawlRequest, completion: @escaping (_ data: CrawlCreatedResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let crawlRequest = CrawlRequest(blockAds: false, blockCookieBanners: false, blockPopups: false, crawlDelayMs: 123, darkMode: false, depth: 123, excludePatterns: ["excludePatterns_example"], format: "format_example", fullPage: false, includePatterns: ["includePatterns_example"], includeSubdomains: false, limit: 123, outputs: [OutputSpec(format: "format_example", fullPage: false, id: "id_example", quality: 123, selector: "selector_example", type: "type_example", landscape: false, printBackground: false, clean: false, mainContentOnly: false, schema: "TODO")], quality: 123, renderDelay: 123, timeout: 123, url: "url_example", viewport: ViewportConfig(deviceScaleFactor: 123, height: 123, width: 123), waitUntil: "waitUntil_example") // CrawlRequest | 

CrawlAPI.create(crawlRequest: crawlRequest) { (response, error) in
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
 **crawlRequest** | [**CrawlRequest**](CrawlRequest.md) |  | 

### Return type

[**CrawlCreatedResponse**](CrawlCreatedResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **delete**
```swift
    open class func delete(id: String, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 

CrawlAPI.delete(id: id) { (response, error) in
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

# **list**
```swift
    open class func list(page: Int? = nil, pageSize: Int? = nil, completion: @escaping (_ data: CrawlListResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let page = 987 // Int |  (optional) (default to 0)
let pageSize = 987 // Int |  (optional) (default to 20)

CrawlAPI.list(page: page, pageSize: pageSize) { (response, error) in
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
 **page** | **Int** |  | [optional] [default to 0]
 **pageSize** | **Int** |  | [optional] [default to 20]

### Return type

[**CrawlListResponse**](CrawlListResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **output**
```swift
    open class func output(id: String, pageId: String, output: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 
let pageId = "pageId_example" // String | 
let output = "output_example" // String | 

CrawlAPI.output(id: id, pageId: pageId, output: output) { (response, error) in
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
 **pageId** | **String** |  | 
 **output** | **String** |  | 

### Return type

**Data**

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/octet-stream, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **pages**
```swift
    open class func pages(id: String, page: Int? = nil, pageSize: Int? = nil, completion: @escaping (_ data: CrawlPagesResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let id = "id_example" // String | 
let page = 987 // Int |  (optional) (default to 0)
let pageSize = 987 // Int |  (optional) (default to 100)

CrawlAPI.pages(id: id, page: page, pageSize: pageSize) { (response, error) in
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
 **page** | **Int** |  | [optional] [default to 0]
 **pageSize** | **Int** |  | [optional] [default to 100]

### Return type

[**CrawlPagesResponse**](CrawlPagesResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

