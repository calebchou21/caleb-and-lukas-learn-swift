import SwiftUI

struct Option: View {
    let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                .cornerRadius(12)
                .shadow(radius: 4)
        }
        .padding(.horizontal)
    }
}

#Preview {
    Group {
        Option(text: "True", action: {})
        Option(text: "False", action: {})
    }
}
