import Foundation
import AllScreenshotsSDK
@main struct Demo {
 static func main() async throws {
  let env=ProcessInfo.processInfo.environment
  let config=AllScreenshotsSDKAPIConfiguration()
  config.basePath=env["ALLSCREENSHOTS_BASE_URL"] ?? "https://api.allscreenshots.com"
  config.customHeaders=["X-API-Key":env["ALLSCREENSHOTS_API_KEY"] ?? ""]
  let mode=CommandLine.arguments.dropFirst().first ?? "quota"
  if mode=="quota" {let quota=try await UsageAPI.getQuota(apiConfiguration:config);print(String(data:try JSONEncoder().encode(quota),encoding:.utf8)!);return}
  let request=ScreenshotRequest(format:"png",responseType:.url,url:env["ALLSCREENSHOTS_URL"] ?? "https://example.com")
  let key=env["ALLSCREENSHOTS_IDEMPOTENCY_KEY"] ?? UUID().uuidString
  let bytes:Data
  if mode=="sync" {
   let raw=try await ScreenshotAPI.captureSync(screenshotRequest:request,idempotencyKey:key,apiConfiguration:config)
   let decoder=JSONDecoder();decoder.dateDecodingStrategy = .iso8601
   let metadata=try decoder.decode(ScreenshotJsonResponse.self,from:raw)
   guard let result=metadata.resultUrl,let url=URL(string:result,relativeTo:URL(string:config.basePath)) else {throw NSError(domain:"Missing result URL",code:1)}
   let parts=url.path.split(separator:"/");let id=String(parts[parts.count-2])
   bytes=try await ScreenshotAPI.getSyncCaptureResult(id:id,apiConfiguration:config)
  } else if mode=="async" {
   let job=try await JobAPI.createAsyncJob(screenshotRequest:request,idempotencyKey:key,apiConfiguration:config);let deadline=Date().addingTimeInterval(180)
   while true {
    let status=try await JobAPI.getJobStatus(id:job.id,apiConfiguration:config)
    if status.status == .completed {break}
    if status.status == .failed || status.status == .cancelled {throw NSError(domain:"Capture failed",code:1)}
    if Date()>deadline {throw NSError(domain:"Polling timed out",code:1)}
    try await Task.sleep(for:.seconds(2))
   }
   bytes=try await JobAPI.getJobResult(id:job.id,apiConfiguration:config)
  } else {throw NSError(domain:"Expected quota, sync, or async",code:1)}
  let output=env["ALLSCREENSHOTS_OUTPUT"] ?? "capture.png";try bytes.write(to:URL(fileURLWithPath:output))
  print(String(data:try JSONEncoder().encode(["output":output]),encoding:.utf8)!)
 }
}
