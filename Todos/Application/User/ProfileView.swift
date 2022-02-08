import SwiftUI
import ComposableArchitecture

struct ProfileView: View {
  let store: Store<UserState, UserAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      ScrollView {
        Spacer()
        
        Text(viewStore.user.email ?? "Guest")
          .font(.title)
          .foregroundColor(.gray)
          .opacity(0.5)
        
        Spacer()
      }
      .padding()
      .alert(store.scope(state: \.alert), dismiss: .dismissAlert)
      .navigationTitle("Profile")
      .toolbar {
        Button("Upgrade") {
          viewStore.send(.buyPremiumButtonTapped)
        }
        .disabled(viewStore.isPremiumUser)
        
        Button("Sign Out") {
          viewStore.send(.createSignoutAlert)
        }
      }
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView(store: UserStore.default)
  }
}
