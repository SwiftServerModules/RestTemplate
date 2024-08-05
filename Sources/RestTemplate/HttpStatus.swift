//
//  HttpStatus.swift
//
//
//  Created by Vivek Topiya on 25/05/24.
//

import Foundation

/// Enumeration of HTTP status series.
public enum Series: Int {
    case INFORMATIONAL = 1
    case SUCCESSFUL = 2
    case REDIRECTION = 3
    case CLIENT_ERROR = 4
    case SERVER_ERROR = 5
}

/// Enumeration of HTTP status codes.
public struct HTTPStatus {
    let value: Int
    let series: Series
    let reasonPhrase: String
    
    private init(_ value: Int, _ series: Series, reasonPhrase: String) {
        self.value = value
        self.series = series
        self.reasonPhrase = reasonPhrase
    }
    
    // MARK: - 1XX Informational

    static let CONTINUE = HTTPStatus(100, Series.INFORMATIONAL, reasonPhrase: "Continue")
    static let SWITCHING_PROTOCOLS = HTTPStatus(101, Series.INFORMATIONAL, reasonPhrase: "Switching Protocols")
    static let PROCESSING = HTTPStatus(102, Series.INFORMATIONAL, reasonPhrase: "Processing")
    static let CHECKPOINT = HTTPStatus(103, Series.INFORMATIONAL, reasonPhrase: "Checkpoint")
    
    // MARK: - 2XX Success

    static let OK = HTTPStatus(200, Series.SUCCESSFUL, reasonPhrase: "OK")
    static let CREATED = HTTPStatus(201, Series.SUCCESSFUL, reasonPhrase: "Created")
    static let ACCEPTED = HTTPStatus(202, Series.SUCCESSFUL, reasonPhrase: "Accepted")
    static let NON_AUTHORITATIVE_INFORMATION = HTTPStatus(203, Series.SUCCESSFUL, reasonPhrase: "Non-Authoritative Information")
    static let NO_CONTENT = HTTPStatus(204, Series.SUCCESSFUL, reasonPhrase: "No Content")
    static let RESET_CONTENT = HTTPStatus(205, Series.SUCCESSFUL, reasonPhrase: "Reset Content")
    static let PARTIAL_CONTENT = HTTPStatus(206, Series.SUCCESSFUL, reasonPhrase: "Partial Content")
    static let MULTI_STATUS = HTTPStatus(207, Series.SUCCESSFUL, reasonPhrase: "Multi-Status")
    static let ALREADY_REPORTED = HTTPStatus(208, Series.SUCCESSFUL, reasonPhrase: "Already Reported")
    static let IM_USED = HTTPStatus(226, Series.SUCCESSFUL, reasonPhrase: "IM Used")
    
    // MARK: - 3xx Redirection

    static let MULTIPLE_CHOICES = HTTPStatus(300, Series.REDIRECTION, reasonPhrase: "Multiple Choices")
    static let MOVED_PERMANENTLY = HTTPStatus(301, Series.REDIRECTION, reasonPhrase: "Moved Permanently")
    static let FOUND = HTTPStatus(302, Series.REDIRECTION, reasonPhrase: "Found")
    @available(*, deprecated, message: "U")
    static let MOVED_TEMPORARILY = HTTPStatus(302, Series.REDIRECTION, reasonPhrase: "Moved Temporarily")
    static let SEE_OTHER = HTTPStatus(303, Series.REDIRECTION, reasonPhrase: "See Other")
    static let NOT_MODIFIED = HTTPStatus(304, Series.REDIRECTION, reasonPhrase: "Not Modified")
    @available(*, deprecated, message: "U")
    static let USE_PROXY = HTTPStatus(305, Series.REDIRECTION, reasonPhrase: "Use Proxy")
    static let TEMPORARY_REDIRECT = HTTPStatus(307, Series.REDIRECTION, reasonPhrase: "Temporary Redirect")
    static let PERMANENT_REDIRECT = HTTPStatus(308, Series.REDIRECTION, reasonPhrase: "Permanent Redirect")
    
    // MARK: - 4xx Client Error

    static let BAD_REQUEST = HTTPStatus(400, Series.CLIENT_ERROR, reasonPhrase: "Bad Request")
    static let UNAUTHORIZED = HTTPStatus(401, Series.CLIENT_ERROR, reasonPhrase: "Unauthorized")
    static let PAYMENT_REQUIRED = HTTPStatus(402, Series.CLIENT_ERROR, reasonPhrase: "Payment Required")
    static let FORBIDDEN = HTTPStatus(403, Series.CLIENT_ERROR, reasonPhrase: "Forbidden")
    static let NOT_FOUND = HTTPStatus(404, Series.CLIENT_ERROR, reasonPhrase: "Not Found")
    static let METHOD_NOT_ALLOWED = HTTPStatus(405, Series.CLIENT_ERROR, reasonPhrase: "Method Not Allowed")
    static let NOT_ACCEPTABLE = HTTPStatus(406, Series.CLIENT_ERROR, reasonPhrase: "Not Acceptable")
    static let PROXY_AUTHENTICATION_REQUIRED = HTTPStatus(407, Series.CLIENT_ERROR, reasonPhrase: "Proxy Authentication Required")
    static let REQUEST_TIMEOUT = HTTPStatus(408, Series.CLIENT_ERROR, reasonPhrase: "Request Timeout")
    static let CONFLICT = HTTPStatus(409, Series.CLIENT_ERROR, reasonPhrase: "Conflict")
    static let GONE = HTTPStatus(410, Series.CLIENT_ERROR, reasonPhrase: "Gone")
    static let LENGTH_REQUIRED = HTTPStatus(411, Series.CLIENT_ERROR, reasonPhrase: "Length Required")
    static let PRECONDITION_FAILED = HTTPStatus(412, Series.CLIENT_ERROR, reasonPhrase: "Precondition Failed")
    static let PAYLOAD_TOO_LARGE = HTTPStatus(413, Series.CLIENT_ERROR, reasonPhrase: "Payload Too Large")
    @available(*, deprecated, message: "U")
    static let REQUEST_ENTITY_TOO_LARGE = HTTPStatus(413, Series.CLIENT_ERROR, reasonPhrase: "Request Entity Too Large")
    static let URI_TOO_LONG = HTTPStatus(414, Series.CLIENT_ERROR, reasonPhrase: "URI Too Long")
    @available(*, deprecated, message: "U")
    static let REQUEST_URI_TOO_LONG = HTTPStatus(414, Series.CLIENT_ERROR, reasonPhrase: "Request-URI Too Long")
    static let UNSUPPORTED_MEDIA_TYPE = HTTPStatus(415, Series.CLIENT_ERROR, reasonPhrase: "Unsupported Media Type")
    static let REQUESTED_RANGE_NOT_SATISFIABLE = HTTPStatus(416, Series.CLIENT_ERROR, reasonPhrase: "Requested range not satisfiable")
    static let EXPECTATION_FAILED = HTTPStatus(417, Series.CLIENT_ERROR, reasonPhrase: "Expectation Failed")
    static let I_AM_A_TEAPOT = HTTPStatus(418, Series.CLIENT_ERROR, reasonPhrase: "I'm a teapot")
    @available(*, deprecated, message: "U")
    static let INSUFFICIENT_SPACE_ON_RESOURCE = HTTPStatus(419, Series.CLIENT_ERROR, reasonPhrase: "Insufficient Space On Resource")
    @available(*, deprecated, message: "U")
    static let METHOD_FAILURE = HTTPStatus(420, Series.CLIENT_ERROR, reasonPhrase: "Method Failure")
    @available(*, deprecated, message: "U")
    static let DESTINATION_LOCKED = HTTPStatus(421, Series.CLIENT_ERROR, reasonPhrase: "Destination Locked")
    static let UNPROCESSABLE_ENTITY = HTTPStatus(422, Series.CLIENT_ERROR, reasonPhrase: "Unprocessable Entity")
    static let LOCKED = HTTPStatus(423, Series.CLIENT_ERROR, reasonPhrase: "Locked")
    static let FAILED_DEPENDENCY = HTTPStatus(424, Series.CLIENT_ERROR, reasonPhrase: "Failed Dependency")
    static let TOO_EARLY = HTTPStatus(425, Series.CLIENT_ERROR, reasonPhrase: "Too Early")
    static let UPGRADE_REQUIRED = HTTPStatus(426, Series.CLIENT_ERROR, reasonPhrase: "Upgrade Required")
    static let PRECONDITION_REQUIRED = HTTPStatus(428, Series.CLIENT_ERROR, reasonPhrase: "Precondition Required")
    static let TOO_MANY_REQUESTS = HTTPStatus(429, Series.CLIENT_ERROR, reasonPhrase: "Too Many Requests")
    static let REQUEST_HEADER_FIELDS_TOO_LARGE = HTTPStatus(431, Series.CLIENT_ERROR, reasonPhrase: "Request Header Fields Too Large")
    static let UNAVAILABLE_FOR_LEGAL_REASONS = HTTPStatus(451, Series.CLIENT_ERROR, reasonPhrase: "Unavailable For Legal Reasons")
    
    // MARK: - 5xx Server Error

    static let INTERNAL_SERVER_ERROR = HTTPStatus(500, Series.SERVER_ERROR, reasonPhrase: "Internal Server Error")
    static let NOT_IMPLEMENTED = HTTPStatus(501, Series.SERVER_ERROR, reasonPhrase: "Not Implemented")
    static let BAD_GATEWAY = HTTPStatus(502, Series.SERVER_ERROR, reasonPhrase: "Bad Gateway")
    static let SERVICE_UNAVAILABLE = HTTPStatus(503, Series.SERVER_ERROR, reasonPhrase: "Service Unavailable")
    static let GATEWAY_TIMEOUT = HTTPStatus(504, Series.SERVER_ERROR, reasonPhrase: "Gateway Timeout")
    static let HTTP_VERSION_NOT_SUPPORTED = HTTPStatus(505, Series.SERVER_ERROR, reasonPhrase: "HTTP Version not supported")
    static let VARIANT_ALSO_NEGOTIATES = HTTPStatus(506, Series.SERVER_ERROR, reasonPhrase: "Variant Also Negotiates")
    static let INSUFFICIENT_STORAGE = HTTPStatus(507, Series.SERVER_ERROR, reasonPhrase: "Insufficient Storage")
    static let LOOP_DETECTED = HTTPStatus(508, Series.SERVER_ERROR, reasonPhrase: "Loop Detected")
    static let BANDWIDTH_LIMIT_EXCEEDED = HTTPStatus(509, Series.SERVER_ERROR, reasonPhrase: "Bandwidth Limit Exceeded")
    static let NOT_EXTENDED = HTTPStatus(510, Series.SERVER_ERROR, reasonPhrase: "Not Extended")
    static let NETWORK_AUTHENTICATION_REQUIRED = HTTPStatus(511, Series.SERVER_ERROR, reasonPhrase: "Network Authentication Required")
    
    func is1xxInformational() -> Bool { self.series == Series.INFORMATIONAL }
    func is2xxSuccessful() -> Bool { self.series == Series.SUCCESSFUL }
    func is3xxRedirection() -> Bool { self.series == Series.REDIRECTION }
    func is4xxClientError() -> Bool { self.series == Series.CLIENT_ERROR }
    func is5xxServerError() -> Bool { self.series == Series.SERVER_ERROR }
    func isError() -> Bool { self.is4xxClientError() || self.is5xxServerError() }
    
    static func valueOf(statusCode: Int) -> HTTPStatus { HTTPStatus.OK }
}
