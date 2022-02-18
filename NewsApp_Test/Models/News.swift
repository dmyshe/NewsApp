import Foundation

struct NewsEnvelope: Decodable {
    let status: String
    let totalResults: Int
    let articles: [News]
}

struct News: Decodable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Decodable {
    let id: Int?
    let name: String
}
