import SwiftUI

struct Property: Identifiable, Codable {
  let id: String
  var images: [String]
  let isVerified: Bool
  var isFavorited: Bool
  let type: String
  let deliveryYear: Int?
  let tags: [String]
  let price: Int
  let currency: String
  let bedrooms: String
  let publishedDate: Date
  let lastContactedDate: String?
  let contactTypes: [ContactType]
  
  var assetImages: [Image] {
    images.map { Image($0) }
  }
  
  var propertyTags: [PropertyTag] {
    tags.map { PropertyTag(rawValue: $0) }
  }
  
  var formattedPrice: String {
    return NumberFormatter.currencyFormatter(for: currency).string(from: NSNumber(value: price)) ?? "\(price)"
  }
  
  init(
    id: String,
    images: [String],
    isVerified: Bool,
    isFavorited: Bool = false,
    type: String,
    deliveryYear: Int? = nil,
    tags: [String],
    price: Int,
    currency: String,
    bedrooms: String,
    publishedDate: Date,
    lastContactedDate: String? = nil,
    contactTypes: [ContactType]
  ) {
    self.id = id
    self.images = images
    self.isVerified = isVerified
    self.isFavorited = isFavorited
    self.type = type
    self.deliveryYear = deliveryYear
    self.tags = tags
    self.price = price
    self.currency = currency
    self.bedrooms = bedrooms
    self.publishedDate = publishedDate
    self.lastContactedDate = lastContactedDate
    self.contactTypes = contactTypes
  }
  
  #if DEBUG
  static let sampleData: [Property] = [
    Property(
      id: "1",
      images: ["FirstImage", "SecondImage"],
      isVerified: true,
      isFavorited: false,
      type: "Apartment",
      deliveryYear: 2022,
      tags: ["verified"],
      price: 2575000,
      currency: "AED",
      bedrooms: "Studio",
      publishedDate: Date(timeIntervalSinceNow: -3 * 86400),
      lastContactedDate: "28 Jul 2021",
      contactTypes: [.phone, .email, .whatsApp]
    ),
    Property(
      id: "2",
      images: ["FirstImage", "SecondImage"],
      isVerified: true,
      isFavorited: false,
      type: "Apartment",
      deliveryYear: 2023,
      tags: ["verified", "new_construction"],
      price: 1850000,
      currency: "AED",
      bedrooms: "1 Bedroom",
      publishedDate: Date(timeIntervalSinceNow: -5 * 86400),
      lastContactedDate: "15 Aug 2021",
      contactTypes: [.phone, .email, .whatsApp]
    ),
    Property(
      id: "3",
      images: ["FirstImage", "SecondImage"],
      isVerified: true,
      isFavorited: false,
      type: "Apartment",
      deliveryYear: 2024,
      tags: ["verified", "live_viewing"],
      price: 3200000,
      currency: "AED",
      bedrooms: "2 Bedrooms",
      publishedDate: Date(timeIntervalSinceNow: -86400),
      lastContactedDate: nil,
      contactTypes: [.phone, .email, .whatsApp]
    )
  ]
  #endif
}
