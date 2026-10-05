# UsageAPI

All URIs are relative to *https://api.allscreenshots.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getActivity**](UsageAPI.md#getactivity) | **GET** /v1/usage/activity | 
[**getQuota**](UsageAPI.md#getquota) | **GET** /v1/usage/quota | 
[**getUsage**](UsageAPI.md#getusage) | **GET** /v1/usage | 
[**getUsageByKey**](UsageAPI.md#getusagebykey) | **GET** /v1/usage/keys | 


# **getActivity**
```swift
    open class func getActivity(days: Int? = nil, apiKeyIds: [String]? = nil, completion: @escaping (_ data: [DailyCaptureCountResponse]?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK

let days = 987 // Int |  (optional) (default to 120)
let apiKeyIds = ["inner_example"] // [String] |  (optional)

UsageAPI.getActivity(days: days, apiKeyIds: apiKeyIds) { (response, error) in
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
 **days** | **Int** |  | [optional] [default to 120]
 **apiKeyIds** | [**[String]**](String.md) |  | [optional] 

### Return type

[**[DailyCaptureCountResponse]**](DailyCaptureCountResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getQuota**
```swift
    open class func getQuota(completion: @escaping (_ data: QuotaStatusResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK


UsageAPI.getQuota() { (response, error) in
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

[**QuotaStatusResponse**](QuotaStatusResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUsage**
```swift
    open class func getUsage(completion: @escaping (_ data: UsageResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK


UsageAPI.getUsage() { (response, error) in
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

[**UsageResponse**](UsageResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUsageByKey**
```swift
    open class func getUsageByKey(completion: @escaping (_ data: ApiKeyUsageResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import AllScreenshotsSDK


UsageAPI.getUsageByKey() { (response, error) in
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

[**ApiKeyUsageResponse**](ApiKeyUsageResponse.md)

### Authorization

[ApiKey](../README.md#ApiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

