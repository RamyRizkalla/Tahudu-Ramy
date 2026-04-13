import SwiftUI

struct Property: Identifiable, Codable {
  let id: String
  var images: [String]
  var isFavorited: Bool
  let type: String
  let deliveryYear: Int?
  let tags: [String]
  let price: Int
  let currency: String
  let bedrooms: String
  let publishedDate: Date
  let lastContactedDate: Date?
  let location: String
  let contactTypes: [ContactType]
  
  var assetImages: [Image] {
    images.map { Image($0) }
  }
  
  var propertyTags: [PropertyTag] {
    tags.map { PropertyTag(rawValue: $0) }
  }

  func matches(_ query: String) -> Bool {
    let lowercased = query.lowercased()
    return type.lowercased().contains(lowercased)
      || location.lowercased().contains(lowercased)
      || bedrooms.lowercased().contains(lowercased)
      || tags.contains { $0.lowercased().contains(lowercased) }
  }
  
  var formattedPrice: String {
    return NumberFormatter.currencyFormatter(for: currency).string(from: NSNumber(value: price)) ?? "\(price)"
  }
  
  init(
    id: String,
    images: [String],
    isFavorited: Bool = false,
    type: String,
    deliveryYear: Int? = nil,
    tags: [String],
    price: Int,
    currency: String,
    bedrooms: String,
    location: String,
    publishedDate: Date,
    lastContactedDate: Date? = nil,
    contactTypes: [ContactType]
  ) {
    self.id = id
    self.images = images
    self.isFavorited = isFavorited
    self.type = type
    self.deliveryYear = deliveryYear
    self.tags = tags
    self.price = price
    self.currency = currency
    self.bedrooms = bedrooms
    self.publishedDate = publishedDate
    self.lastContactedDate = lastContactedDate
    self.location = location
    self.contactTypes = contactTypes
  }
  
  #if DEBUG
  static let sampleData: [Property] = [
    Property(
      id: "1",
      images: ["FirstImage", "SecondImage"],
      isFavorited: false,
      type: "Apartment",
      deliveryYear: 2022,
      tags: ["verified"],
      price: 2575000,
      currency: "AED",
      bedrooms: "Studio",
      location: "Laguna Tower, Jumeirah Lake Tower",
      publishedDate: Date(timeIntervalSinceNow: -3 * 86400),
      lastContactedDate: DateFormatter().date(from: "28 Jul 2021") ?? Date(timeIntervalSinceNow: -30 * 86400),
      contactTypes: [.phone, .email, .whatsApp]
    ),
    Property(
      id: "2",
      images: ["FirstImage", "SecondImage"],
      isFavorited: false,
      type: "Apartment",
      deliveryYear: 2023,
      tags: ["verified", "new_construction"],
      price: 1850000,
      currency: "AED",
      bedrooms: "1 Bedroom",
      location: "Dubai Marina",
      publishedDate: Date(timeIntervalSinceNow: -5 * 86400),
      lastContactedDate: DateFormatter().date(from: "15 Aug 2021") ?? Date(timeIntervalSinceNow: -20 * 86400),
      contactTypes: [.phone, .email, .whatsApp]
    ),
    Property(
      id: "3",
      images: ["FirstImage", "SecondImage"],
      isFavorited: false,
      type: "Villa",
      deliveryYear: 2024,
      tags: ["verified", "live_viewing"],
      price: 3200000,
      currency: "AED",
      bedrooms: "2 Bedrooms",
      location: "Palm Jumeirah",
      publishedDate: Date(timeIntervalSinceNow: -86400),
      lastContactedDate: nil,
      contactTypes: [.phone, .email, .whatsApp]
    )
  ]
  #endif
}
