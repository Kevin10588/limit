import SwiftUI
import FirebaseCore
import Firebase
import FirebaseFirestore


final class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct FirebaseTest: App {
  // register app delegate for Firebase setup
   
    
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject var sessionService = SessionServiceImpl()
    

  var body: some Scene {
      WindowGroup {
          NavigationView{
              switch sessionService.state{
              case .loggedIn:
                      LimitTabView()
                          .environmentObject(sessionService)
              case .loggedOut:
                  LoginView()
              }
              
          }
      }
    }
  }

