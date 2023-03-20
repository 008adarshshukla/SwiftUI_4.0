import SwiftUI

struct EnterOTP: View {
    
    @Environment(\.dismiss) private var dismiss
    //@State var viewModel = ViewModel()
    @State var otpString: String = ""
    var characterLimit = 6
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    upperView()
                    Spacer()
                    lowerView()
                }
                //.environmentObject(viewModel)
                .padding(.horizontal, 25)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image(systemName: "chevron.left")
                            .font(.custom("Poppins-Bold", size: 25))
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
                .frame(minHeight: geometry.size.height)
            }
            .navigationBarBackButtonHidden()
            .scrollDisabled(true)
            .frame(width: geometry.size.width)
        }
    }
    
    @ViewBuilder
    private func upperView() -> some View {
        VStack {
            HStack {
                Text("Enter OTP")
                    .font(.custom("Poppins-Bold", size: 30))
                Spacer()
            }
            .padding(.top, 30)
            .padding(.bottom, 11)
            
            HStack {
                Text("Enter your OTP sent to 9172 XXXX XX, we only allow authentic users")
                    .font(.custom("Poppins-Medium", size: 18))
                Spacer()
            }
            .padding(.bottom, 100)
            
            //OTOHolderView()
            optField()
                .padding(.bottom, 73)
            
            Text("Resend OTP")
                .font(.custom("Poppins-Medium", size: 18))
            
            //Text(viewModel.otp)
        }
    }
    
    @ViewBuilder
    private func lowerView() -> some View {
        Button {
            
        } label: {
            RoundedRectangle(cornerRadius: 40)
                .frame(height: 81)
                .overlay {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Bold", size: 18))
                }
                .shadow(radius: 5, y: 5)
        }
        //.disabled(!isValidOtp(code: viewModel.otpField))
    }
    
    @ViewBuilder
    private func optField() -> some View {
        ZStack {
            HStack {
                otpBubble(with: otpString.count >= 1 ? String(otpString[0]) : "")
                otpBubble(with: otpString.count >= 2 ? String(otpString[1]) : "")
                otpBubble(with: otpString.count >= 3 ? String(otpString[2]) : "")
                otpBubble(with: otpString.count >= 4 ? String(otpString[3]) : "")
                otpBubble(with: otpString.count >= 5 ? String(otpString[4]) : "")
                otpBubble(with: otpString.count >= 6 ? String(otpString[5]) : "")
            }
            
            TextField("", text: $otpString)
                .font(.custom("Poppins-light", size: 0))
                .foregroundColor(Color(hex: "90FFB6"))
                .frame(height: 60)
                .opacity(0.1)
                .tint(.clear)
                .onReceive(otpString.publisher.collect()) {
                    let s = String($0.prefix(characterLimit))
                    if otpString != s {
                        otpString = s
                    }
                }
        }
    }
    
    @ViewBuilder
    private func otpBubble(with text: String) -> some View {
        Circle()
            .foregroundColor(Color(hex: "90FFB6"))
            .frame(width: 56, height: 56)
            .overlay {
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color(hex: "20DC60"))
                    .overlay {
                        Text(text)
                            .font(.custom("Poppins-Medium", size: 21))
                    }
            }
    }
}

struct EnterOTP_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EnterOTP()
        }
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
