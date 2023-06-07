
import SwiftUI

struct AddView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("write Your Task Here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 56)
                    .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(16)
                
                Button {
                    saveButtonPressed()
                } label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(16)
                }

            }
            .padding(16)
        }
        .navigationTitle("Add an Item 🖊")
        .alert(isPresented: $showAlert) {
            getAlert()
        }
    }
    
    func saveButtonPressed() {
        if (textIsAppropiate()) {
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropiate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Your new todo item must be at lest 3 characters long! 👀"
            showAlert.toggle()
            
            return false
        }
        
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}
