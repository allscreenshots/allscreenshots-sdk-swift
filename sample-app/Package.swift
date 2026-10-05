// swift-tools-version:6.0
import PackageDescription
let package=Package(name:"SDKDemo",platforms:[.macOS(.v13)],dependencies:[.package(name:"AllScreenshotsSDK",path:"..")],targets:[.executableTarget(name:"SDKDemo",dependencies:[.product(name:"AllScreenshotsSDK",package:"AllScreenshotsSDK")])])
