import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let welcomeIs: Is?

    enum CodingKeys: String, CodingKey {
        case welcomeIs = "is"
    }
}

// MARK: - Is
struct Is: Codable {
    let statusCode: Int?
    let headers: Headers?
    let body: Body?
}

// MARK: - Body
struct Body: Codable {
    let page, perPage, total, totalPages: Int?
    let data: [Datum]?
    let support: Support?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int?
    let email, firstName, lastName: String?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

// MARK: - Support
struct Support: Codable {
    let url: String?
    let text: String?
}

// MARK: - Headers
struct Headers: Codable {
    let contentType: String?

    enum CodingKeys: String, CodingKey {
        case contentType = "Content-Type"
    }
}

typealias Welcome = [WelcomeElement]

