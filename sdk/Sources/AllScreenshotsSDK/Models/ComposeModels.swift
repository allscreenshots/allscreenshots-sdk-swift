import Foundation

// MARK: - Capture Item

/// A single capture item for compose operations
public struct CaptureItem: Codable, Sendable {
    public let url: String
    public let id: String?
    public let label: String?
    public let viewport: ViewportConfig?
    public let device: String?
    public let fullPage: Bool?
    public let darkMode: Bool?
    public let delay: Int?

    public init(
        url: String,
        id: String? = nil,
        label: String? = nil,
        viewport: ViewportConfig? = nil,
        device: String? = nil,
        fullPage: Bool? = nil,
        darkMode: Bool? = nil,
        delay: Int? = nil
    ) {
        self.url = url
        self.id = id
        self.label = label
        self.viewport = viewport
        self.device = device
        self.fullPage = fullPage
        self.darkMode = darkMode
        self.delay = delay
    }
}

/// Variant configuration for single URL with multiple configs
public struct VariantConfig: Codable, Sendable {
    public let id: String?
    public let label: String?
    public let viewport: ViewportConfig?
    public let device: String?
    public let fullPage: Bool?
    public let darkMode: Bool?
    public let delay: Int?
    public let customCss: String?

    public init(
        id: String? = nil,
        label: String? = nil,
        viewport: ViewportConfig? = nil,
        device: String? = nil,
        fullPage: Bool? = nil,
        darkMode: Bool? = nil,
        delay: Int? = nil,
        customCss: String? = nil
    ) {
        self.id = id
        self.label = label
        self.viewport = viewport
        self.device = device
        self.fullPage = fullPage
        self.darkMode = darkMode
        self.delay = delay
        self.customCss = customCss
    }
}

/// Default capture options
public struct CaptureDefaults: Codable, Sendable {
    public let viewport: ViewportConfig?
    public let device: String?
    public let format: String?
    public let fullPage: Bool?
    public let quality: Int?
    public let delay: Int?
    public let waitFor: String?
    public let waitUntil: String?
    public let timeout: Int?
    public let darkMode: Bool?
    public let customCss: String?
    public let hideSelectors: [String]?
    public let blockAds: Bool?
    public let blockCookieBanners: Bool?
    public let blockLevel: String?

    public init(
        viewport: ViewportConfig? = nil,
        device: String? = nil,
        format: String? = nil,
        fullPage: Bool? = nil,
        quality: Int? = nil,
        delay: Int? = nil,
        waitFor: String? = nil,
        waitUntil: String? = nil,
        timeout: Int? = nil,
        darkMode: Bool? = nil,
        customCss: String? = nil,
        hideSelectors: [String]? = nil,
        blockAds: Bool? = nil,
        blockCookieBanners: Bool? = nil,
        blockLevel: String? = nil
    ) {
        self.viewport = viewport
        self.device = device
        self.format = format
        self.fullPage = fullPage
        self.quality = quality
        self.delay = delay
        self.waitFor = waitFor
        self.waitUntil = waitUntil
        self.timeout = timeout
        self.darkMode = darkMode
        self.customCss = customCss
        self.hideSelectors = hideSelectors
        self.blockAds = blockAds
        self.blockCookieBanners = blockCookieBanners
        self.blockLevel = blockLevel
    }
}

// MARK: - Label Configuration

/// Label configuration for compose output
public struct LabelConfig: Codable, Sendable {
    public let enabled: Bool?
    public let position: String?
    public let fontSize: Int?
    public let fontColor: String?
    public let backgroundColor: String?
    public let padding: Int?

    public init(
        enabled: Bool? = nil,
        position: String? = nil,
        fontSize: Int? = nil,
        fontColor: String? = nil,
        backgroundColor: String? = nil,
        padding: Int? = nil
    ) {
        self.enabled = enabled
        self.position = position
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.backgroundColor = backgroundColor
        self.padding = padding
    }
}

/// Border configuration
public struct BorderConfig: Codable, Sendable {
    public let enabled: Bool?
    public let width: Int?
    public let color: String?
    public let radius: Int?

    public init(
        enabled: Bool? = nil,
        width: Int? = nil,
        color: String? = nil,
        radius: Int? = nil
    ) {
        self.enabled = enabled
        self.width = width
        self.color = color
        self.radius = radius
    }
}

/// Shadow configuration
public struct ShadowConfig: Codable, Sendable {
    public let enabled: Bool?
    public let blur: Int?
    public let spread: Int?
    public let color: String?
    public let offsetX: Int?
    public let offsetY: Int?

    public init(
        enabled: Bool? = nil,
        blur: Int? = nil,
        spread: Int? = nil,
        color: String? = nil,
        offsetX: Int? = nil,
        offsetY: Int? = nil
    ) {
        self.enabled = enabled
        self.blur = blur
        self.spread = spread
        self.color = color
        self.offsetX = offsetX
        self.offsetY = offsetY
    }
}

// MARK: - Compose Output Configuration

/// Output configuration for compose operations
public struct ComposeOutputConfig: Codable, Sendable {
    public let layout: LayoutType?
    public let format: ImageFormat?
    public let quality: Int?
    public let columns: Int?
    public let spacing: Int?
    public let padding: Int?
    public let background: String?
    public let alignment: Alignment?
    public let maxWidth: Int?
    public let maxHeight: Int?
    public let thumbnailWidth: Int?
    public let labels: LabelConfig?
    public let border: BorderConfig?
    public let shadow: ShadowConfig?

    public init(
        layout: LayoutType? = nil,
        format: ImageFormat? = nil,
        quality: Int? = nil,
        columns: Int? = nil,
        spacing: Int? = nil,
        padding: Int? = nil,
        background: String? = nil,
        alignment: Alignment? = nil,
        maxWidth: Int? = nil,
        maxHeight: Int? = nil,
        thumbnailWidth: Int? = nil,
        labels: LabelConfig? = nil,
        border: BorderConfig? = nil,
        shadow: ShadowConfig? = nil
    ) {
        self.layout = layout
        self.format = format
        self.quality = quality
        self.columns = columns
        self.spacing = spacing
        self.padding = padding
        self.background = background
        self.alignment = alignment
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
        self.thumbnailWidth = thumbnailWidth
        self.labels = labels
        self.border = border
        self.shadow = shadow
    }
}

// MARK: - Compose Request

/// Request for composing multiple screenshots
public struct ComposeRequest: Codable, Sendable {
    public let captures: [CaptureItem]?
    public let url: String?
    public let variants: [VariantConfig]?
    public let defaults: CaptureDefaults?
    public let output: ComposeOutputConfig?
    public let async: Bool?
    public let webhookUrl: String?
    public let webhookSecret: String?
    public let capturesMode: Bool?
    public let variantsMode: Bool?

    public init(
        captures: [CaptureItem]? = nil,
        url: String? = nil,
        variants: [VariantConfig]? = nil,
        defaults: CaptureDefaults? = nil,
        output: ComposeOutputConfig? = nil,
        async: Bool? = nil,
        webhookUrl: String? = nil,
        webhookSecret: String? = nil,
        capturesMode: Bool? = nil,
        variantsMode: Bool? = nil
    ) {
        self.captures = captures
        self.url = url
        self.variants = variants
        self.defaults = defaults
        self.output = output
        self.async = async
        self.webhookUrl = webhookUrl
        self.webhookSecret = webhookSecret
        self.capturesMode = capturesMode
        self.variantsMode = variantsMode
    }
}

// MARK: - Compose Responses

/// Metadata for compose operation
public struct ComposeMetadata: Codable, Sendable {
    public let captures: [CaptureMetadata]?
}

/// Metadata for individual capture
public struct CaptureMetadata: Codable, Sendable {
    public let id: String?
    public let url: String?
    public let label: String?
    public let width: Int?
    public let height: Int?
}

/// Synchronous compose response
public struct ComposeResponse: Codable, Sendable {
    public let url: String?
    public let storageUrl: String?
    public let expiresAt: String?
    public let width: Int?
    public let height: Int?
    public let format: String?
    public let fileSize: Int64?
    public let renderTimeMs: Int64?
    public let layout: String?
    public let metadata: ComposeMetadata?
}

/// Compose job status response
public struct ComposeJobStatusResponse: Codable, Sendable {
    public let jobId: String
    public let status: String
    public let progress: Int?
    public let totalCaptures: Int?
    public let completedCaptures: Int?
    public let result: ComposeResponse?
    public let errorCode: String?
    public let errorMessage: String?
    public let createdAt: String?
    public let completedAt: String?
}

/// Compose job summary
public struct ComposeJobSummaryResponse: Codable, Sendable {
    public let jobId: String
    public let status: String
    public let totalCaptures: Int?
    public let completedCaptures: Int?
    public let failedCaptures: Int?
    public let progress: Int?
    public let layoutType: String?
    public let createdAt: String?
    public let completedAt: String?
}

// MARK: - Layout Preview

/// Placement preview for layout
public struct PlacementPreview: Codable, Sendable {
    public let index: Int
    public let x: Int
    public let y: Int
    public let width: Int
    public let height: Int
    public let label: String?
}

/// Layout preview response
public struct LayoutPreviewResponse: Codable, Sendable {
    public let layout: String
    public let resolvedLayout: String?
    public let canvasWidth: Int
    public let canvasHeight: Int
    public let placements: [PlacementPreview]
    public let metadata: [String: AnyCodable]?
}
