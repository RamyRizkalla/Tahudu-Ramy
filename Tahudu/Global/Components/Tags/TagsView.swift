import SwiftUI

struct TagsView: View {
    let tags: [PropertyTag]

    var body: some View {
        HStack(spacing: 4) {
            ForEach(tags, id: \.self) { tag in              
              TagView(
                title: tag.displayLabel,
                foregroundColor: .white,
                background: tag.badgeColor
              )
            }
        }
    }
}

#Preview {
    TagsView(tags: [.verified, .newConstruction, .liveViewing])
}
