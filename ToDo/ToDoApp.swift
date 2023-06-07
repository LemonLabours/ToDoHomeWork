import SwiftUI

@main
struct ToDoApp: App {
    @StateObject var listviewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listviewModel)
        }
    }
}
