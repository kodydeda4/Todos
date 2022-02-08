import SwiftUI
import ComposableArchitecture
import AuthenticationServices

struct LoginView: View {
  let store: Store<AuthenticationState, AuthenticationAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack(spacing: 20) {
        Circle()
          .frame(width: 30, height: 30)
          .foregroundColor(.red)
          .overlay(Image(systemSymbol: .lock).foregroundColor(.black))
        
        Text("Login")
          .font(.largeTitle)
        
        TextField("Email", text: viewStore.binding(\.$email))
        TextField("Password", text: viewStore.binding(\.$password))
        
        Button(action: {viewStore.send(.signInWithEmail)}) {
          ZStack {
            RoundedRectangle(cornerRadius: 4)
              .foregroundColor(.accentColor)
            
            Text("Log in")
              .foregroundColor(Color(nsColor: .windowBackgroundColor))
            
          }
        }
        .frame(height: 24)
        .buttonStyle(.plain)
        
        Button("Continue as Guest") {
          viewStore.send(.signInAnonymously)
        }
        
        SignInWithAppleButton() {
          viewStore.send(.signInWithApple($0))
        }
        
        HStack {
          Link("Forgot Password?", destination: .personalWebsite)
          
          Spacer()
          Button("Don't have an account? Sign up") {
            viewStore.send(.updateRoute(.signup))
          }
          .foregroundColor(.accentColor)
          .buttonStyle(LinkButtonStyle())
          
        }
        .foregroundColor(.accentColor)
        
        Link("Created by Kody Deda", destination: .personalWebsite)
          .padding(.top)
          .foregroundColor(.gray)
      }
      .padding()
      .padding(.horizontal, 100)
      .navigationTitle("Login")
      .textFieldStyle(RoundedBorderTextFieldStyle())
    }
  }
}


struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView(store: AuthenticationStore.default)
  }
}





