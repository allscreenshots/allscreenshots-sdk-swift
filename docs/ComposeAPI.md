# ComposeAPI

All URIs are relative to *https://api.allscreenshots.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**compose**](ComposeAPI.md#compose) | **POST** /v1/screenshots/compose | 
[**getComposeJobStatus**](ComposeAPI.md#getcomposejobstatus) | **GET** /v1/screenshots/compose/jobs/{jobId} | 
[**getLayoutPreview**](ComposeAPI.md#getlayoutpreview) | **GET** /v1/screenshots/compose/preview | 
[**listComposeJobs**](ComposeAPI.md#listcomposejobs) | **GET** /v1/screenshots/compose/jobs | 


# **compose**
```swift
    open class func compose(composeRequest: ComposeRequest, completion: @escaping (_ data: Data?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let composeRequest = ComposeRequest(async: false, captures: [CaptureItem(darkMode: false, delay: 123, device: "device_example", fullPage: false, id: "id_example", label: "label_example", url: "url_example", viewport: ViewportConfig(deviceScaleFactor: 123, height: 123, width: 123))], capturesMode: false, defaults: CaptureDefaults(actions: [PageAction(_optional: false, selector: "selector_example", timeout: 123, type: "type_example", clear: false, text: "text_example", key: "key_example", value: "value_example", toBottom: false, y: 123, ms: 123, networkIdle: false)], blockAds: false, blockCookieBanners: false, blockLevel: "blockLevel_example", blockPopups: false, customCss: "customCss_example", darkMode: false, delay: 123, device: "device_example", format: "format_example", fullPage: false, hideSelectors: ["hideSelectors_example"], quality: 123, stealthMode: false, timeout: 123, viewport: nil, waitFor: "waitFor_example", waitUntil: "waitUntil_example"), output: ComposeOutputConfig(alignment: "alignment_example", background: "background_example", border: BorderConfig(color: "color_example", radius: 123, width: 123), columns: 123, format: "format_example", labels: LabelConfig(background: "background_example", fontColor: "fontColor_example", fontSize: 123, padding: 123, position: "position_example", show: false), layout: "layout_example", maxHeight: 123, maxWidth: 123, padding: 123, quality: 123, shadow: ShadowConfig(blur: 123, color: "color_example", enabled: false, offsetX: 123, offsetY: 123), spacing: 123, thumbnailWidth: 123), url: "url_example", variants: [VariantConfig(customCss: "customCss_example", darkMode: false, delay: 123, device: "device_example", fullPage: false, id: "id_example", label: "label_example", viewport: nil)], variantsMode: false, webhookSecret: "webhookSecret_example", webhookUrl: "webhookUrl_example") // ComposeRequest | 

ComposeAPI.compose(composeRequest: composeRequest) { (response, error) in
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
 **composeRequest** | [**ComposeRequest**](ComposeRequest.md) |  | 

### Return type

**Data**

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/octet-stream, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getComposeJobStatus**
```swift
    open class func getComposeJobStatus(jobId: String, completion: @escaping (_ data: ComposeJobStatusResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let jobId = "jobId_example" // String | 

ComposeAPI.getComposeJobStatus(jobId: jobId) { (response, error) in
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
 **jobId** | **String** |  | 

### Return type

[**ComposeJobStatusResponse**](ComposeJobStatusResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLayoutPreview**
```swift
    open class func getLayoutPreview(layout: String, imageCount: Int, canvasWidth: Int? = nil, canvasHeight: Int? = nil, aspectRatios: [Double]? = nil, completion: @escaping (_ data: LayoutPreviewResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let layout = "layout_example" // String | 
let imageCount = 987 // Int | 
let canvasWidth = 987 // Int |  (optional) (default to 1200)
let canvasHeight = 987 // Int |  (optional) (default to 800)
let aspectRatios = [123] // [Double] |  (optional)

ComposeAPI.getLayoutPreview(layout: layout, imageCount: imageCount, canvasWidth: canvasWidth, canvasHeight: canvasHeight, aspectRatios: aspectRatios) { (response, error) in
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
 **layout** | **String** |  | 
 **imageCount** | **Int** |  | 
 **canvasWidth** | **Int** |  | [optional] [default to 1200]
 **canvasHeight** | **Int** |  | [optional] [default to 800]
 **aspectRatios** | [**[Double]**](Double.md) |  | [optional] 

### Return type

[**LayoutPreviewResponse**](LayoutPreviewResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listComposeJobs**
```swift
    open class func listComposeJobs(completion: @escaping (_ data: [ComposeJobSummaryResponse]?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK


ComposeAPI.listComposeJobs() { (response, error) in
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

[**[ComposeJobSummaryResponse]**](ComposeJobSummaryResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

