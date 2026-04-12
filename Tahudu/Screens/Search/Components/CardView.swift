import SwiftUI

struct CardView: View {
  let property: Property
  var onFavouriteToggle: () -> Void = {}
  var onContactTap: () -> Void = {}
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      ZStack(alignment: .topTrailing) {
        CarouselView(images: property.images)
        
        HStack {
          VStack(alignment: .leading) {
            TagsView(tags: property.propertyTags)
              .padding(12)
          }
          Spacer()
          
          FavoriteButton(isFavorited: property.isFavorited) {
            onFavouriteToggle()
          }
          .padding(12)
        }
      }
      
      VStack(alignment: .leading, spacing: 12) {
        VStack(alignment: .leading, spacing: 4) {
          HStack(spacing: 8) {
            Text(property.type)
              .font(.caption)
              .foregroundColor(.gray)
            
            if let year = property.deliveryYear {
              VStack {
                Text("Delivery: \(year)")
                  .font(.caption)
                  .fontWeight(.medium)
                  .foregroundColor(.darkBlue)
                  .padding(.horizontal, 8)
              }
              .frame(height: 24)
              .background(Color.darkBlue.opacity(0.05))
              .cornerRadius(12)
            }
          }
          
          Text(property.price)
            .font(.headline)
            .fontWeight(.semibold)
        }
        .padding(.horizontal, 12)
        .padding(.top, 12)
        
        HStack(spacing: 8) {
          Image(sfSymbol: .bedDouble)
            .font(.caption)
            .foregroundColor(.black)
          Text(property.bedrooms)
            .font(.caption)
            .foregroundColor(.black)
        }
        .padding(.horizontal, 12)
        
        Divider()
          .padding(.horizontal, 12)
        
        HStack {
          Text("Published \(property.publishedDate.relativeString)")
            .font(.caption)
            .foregroundColor(.gray)
          
          Spacer()
          
          HStack(spacing: 8) {
            ForEach(property.contactTypes, id: \.self) { type in
              ContactButton(type) {
                print("Tapped contact button")
                onContactTap()
              }
            }
          }
        }
        .padding(.horizontal, 12)
        
        if let lastContactedDate = property.lastContactedDate {
          HStack(spacing: 6) {
            Image(sfSymbol: .phoneFill)
              .font(.caption)
            Text("Last contacted: \(lastContactedDate)")
              .font(.caption)
          }
          .foregroundColor(.black)
          .padding(.horizontal, 12)
          .padding(.vertical, 8)
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(Color.cream)
        }
      }
    }
    .background(Color.white)
    .cornerRadius(12)
    .shadow(radius: 2)
    .padding(.horizontal, 12)
    .padding(.vertical, 8)
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  CardView(property: Property.sampleData[0]) {}
}
