import Foundation



class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    let itemsKey: String = "items_list"

    init() {
        getItems()
    }

    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }

        self.items = savedItems
    }

    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }

    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }

    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }

    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }

    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}

//import Foundation
//
//struct TodoItem: Codable {
//    let id: Int
//    let title: String
//    let completed: Bool
//}
//
//class ListViewModel: ObservableObject {
//    @Published var items: [TodoItem] = [] {
//        didSet {
//            saveItems()
//        }
//    }
//    let itemsKey: String = "items_list"
//
//    init() {
//        getItems()
//    }
//
//    func getItems() {
//        // Make a GET request to fetch the items from the API
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
//            return
//        }
//
//        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                do {
//                    let fetchedItems: [TodoItem] = try JSONDecoder().decode([TodoItem].self, from: data)
//                    DispatchQueue.main.async {
//                        self.items = fetchedItems
//                    }
//                } catch {
//                    // Handle error
//                    print("Error decoding fetched items: \(error)")
//                }
//            } else if let error = error {
//                // Handle error
//                print("Error fetching items: \(error)")
//            }
//        }.resume()
//    }
//
//    func deleteItem(indexSet: IndexSet) {
//        // Get the item to be deleted
//        let item = items[indexSet.first!]
//
//        // Make a DELETE request to delete the item from the API
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/\(item.id)") else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "DELETE"
//
//        URLSession.shared.dataTask(with: request) { _, _, error in
//            if let error = error {
//                // Handle error
//                print("Error deleting item: \(error)")
//            } else {
//                DispatchQueue.main.async {
//                    self.items.remove(atOffsets: indexSet)
//                }
//            }
//        }.resume()
//    }
//
//    func moveItem(from: IndexSet, to: Int) {
//        items.move(fromOffsets: from, toOffset: to)
//    }
//
//    func addItem(title: String) {
//        let newItem = TodoItem(id: items.count + 1, title: title, completed: false)
//
//        // Make a POST request to add the item to the API
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        do {
//            let encodedItem = try JSONEncoder().encode(newItem)
//            request.httpBody = encodedItem
//
//            URLSession.shared.dataTask(with: request) { data, _, error in
//                if let data = data {
//                    do {
//                        let addedItem: TodoItem = try JSONDecoder().decode(TodoItem.self, from: data)
//
//                        DispatchQueue.main.async {
//                            self.items.append(addedItem)
//                        }
//                    } catch {
//                        // Handle error
//                        print("Error decoding added item: \(error)")
//                    }
//                } else if let error = error {
//                    // Handle error
//                    print("Error adding item: \(error)")
//                }
//            }.resume()
//        } catch {
//            // Handle error
//            print("Error encoding new item: \(error)")
//        }
//    }
//
//    func updateItem(item: TodoItem) {
//        // Make a PUT request to update the item on the API
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/\(item.id)") else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        do {
//            let encodedItem = try JSONEncoder().encode(item)
//            request.httpBody = encodedItem
//
//            URLSession.shared.dataTask(with: request) { data, _, error in
//                if let data = data {
//                    do {
//                        let updatedItem: TodoItem = try JSONDecoder().decode(TodoItem.self, from: data)
//
//                        DispatchQueue.main.async {
//                            if let index = self.items.firstIndex(where: { $0.id == updatedItem.id }) {
//                                self.items[index] = updatedItem
//                            }
//                        }
//                    } catch {
//                        // Handle error
//                        print("Error decoding updated item: \(error)")
//                    }
//                } else if let error = error {
//                    // Handle error
//                    print("Error updating item: \(error)")
//                }
//            }.resume()
//        } catch {
//            // Handle error
//            print("Error encoding item: \(error)")
//        }
//    }
//
//    func saveItems() {
//        do {
//            let encodedData = try JSONEncoder().encode(items)
//            UserDefaults.standard.set(encodedData, forKey: itemsKey)
//        } catch {
//            // Handle error
//            print("Error encoding items: \(error)")
//        }
//    }
//}
