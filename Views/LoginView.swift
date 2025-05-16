import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isLoginMode = true
    @State private var error: String?

  var body: some View {
      ZStack {
          // Arka plan
          LinearGradient(
              colors: [Color(red: 0.9, green: 0.95, blue: 1.0),
                       Color(red: 0.8, green: 0.9, blue: 1.0)],
              startPoint: .top,
              endPoint: .bottom
          )
          .ignoresSafeArea()
          
          // Ana içerik
          ScrollView {
              VStack(spacing: 25) {
                  // Logo ve başlık
                  VStack(spacing: 5) {
                      Image(systemName: "film")
                          .font(.system(size: 60))
                          .foregroundColor(.blue)
                          .padding(.bottom, 5)
                      
                      Text("CineView")
                          .font(.largeTitle)
                          .fontWeight(.bold)
                          .foregroundColor(.black)
                      
                      Text(isLoginMode ? "Hesabınıza giriş yapın" : "Yeni bir hesap oluşturun")
                          .font(.subheadline)
                          .foregroundColor(.gray)
                          .padding(.bottom, 15)
                  }
                  
                  // Form
                  VStack(spacing: 15) {
                      // Email
                      HStack {
                          Image(systemName: "envelope")
                              .foregroundColor(.gray)
                          TextField("E-posta adresiniz", text: $email)
                              .keyboardType(.emailAddress)
                              .autocapitalization(.none)
                      }
                      .padding()
                      .background(Color.white)
                      .cornerRadius(12)
                      .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                      
                      // Şifre
                      HStack {
                          Image(systemName: "lock")
                              .foregroundColor(.gray)
                          SecureField("Şifreniz", text: $password)
                              .autocapitalization(.none)
                      }
                      .padding()
                      .background(Color.white)
                      .cornerRadius(12)
                      .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                      
                      // Şifremi unuttum
                      if isLoginMode {
                          Button("Şifremi Unuttum") {
                              // Şifremi unuttum işlemi (gelecekte eklenebilir)
                              error = "Şifre sıfırlama henüz uygulanmadı."
                          }
                          .font(.footnote)
                          .foregroundColor(.blue)
                          .frame(maxWidth: .infinity, alignment: .trailing)
                          .padding(.trailing, 5)
                      }
                  }
                  
                  // Butonlar
                  VStack(spacing: 15) {
                      // Ana buton
                      Button {
                          Task {
                              guard !email.isEmpty, !password.isEmpty else {
                                  error = "Lütfen e-posta ve şifre alanlarını doldurun."
                                  return
                              }
                              
                              if isLoginMode {
                                  await authViewModel.signIn(email: email, password: password)
                              } else {
                                  await authViewModel.signUp(email: email, password: password)
                              }
                          }
                      } label: {
                          Text(isLoginMode ? "Giriş Yap" : "Hesap Oluştur")
                              .fontWeight(.medium)
                              .foregroundColor(.white)
                              .padding()
                              .frame(maxWidth: .infinity)
                              .background(Color.blue)
                              .cornerRadius(12)
                              .shadow(color: .blue.opacity(0.3), radius: 5, x: 0, y: 3)
                      }
                      
                      // Geçiş butonu
                      Button {
                          withAnimation {
                              isLoginMode.toggle()
                          }
                      } label: {
                          Text(isLoginMode ? "Hesabınız yok mu? Üye Olun" : "Zaten hesabınız var mı? Giriş Yapın")
                              .font(.footnote)
                              .foregroundColor(.gray)
                      }
                  }
                  .padding(.top, 10)
                  
                  // Hata mesajı
                  if let error = error {
                      Text(error)
                          .font(.footnote)
                          .foregroundColor(.red)
                          .multilineTextAlignment(.center)
                          .padding(.top, 10)
                  }
              }
              .padding(.horizontal, 25)
              .padding(.vertical, 30)
          }
      }
  }

}

#Preview {
    LoginView() .environmentObject(AuthViewModel())
}
