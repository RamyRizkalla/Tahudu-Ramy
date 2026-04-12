import Foundation

struct PropertiesResponse: Codable {
  struct Listing: Codable, Identifiable {
    let id: String
    let type: String
    let deliveryYear: Int
    let price: Int
    let currency: String
    let priceInclusive: Bool
    let location: String
    let bedrooms: Int?
    let bathrooms: Int
    let areaSqft: Int
    let publishedAt: String
    let lastContactedAt: String?
    let tags: [String]
    let images: [String]
    let contactOptions: [String]
  }

  let listings: [Listing]
}

extension PropertiesResponse: APIToDomainConvertable {
  var domainModel: [Property] {
    listings.map(\.domainModel)
  }
}

extension PropertiesResponse.Listing: APIToDomainConvertable {
  var domainModel: Property {
    let parsedDate = ISO8601DateFormatter().date(from: publishedAt) ?? Date()
    return Property(
      id: id,
      images: images,
      isVerified: tags.contains("verified"),
      isFavorited: false,
      type: type,
      deliveryYear: deliveryYear,
      tags: tags,
      price: price,
      currency: currency,
      bedrooms: bedrooms.map { String($0) } ?? "Studio",
      publishedDate: parsedDate,
      lastContactedDate: lastContactedAt,
      contactTypes: contactOptions.compactMap { ContactType(rawValue: $0) }
    )
  }
}
