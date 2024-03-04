import SwiftUI

struct CustomTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontDesign(.monospaced)
    }
}

extension View {
    func customTextStyle() -> some View {
        ModifiedContent(
            content: self,
            modifier: CustomTextStyle()
        )
    }
}

#Preview {
    Text("hey")
        .customTextStyle()
}
