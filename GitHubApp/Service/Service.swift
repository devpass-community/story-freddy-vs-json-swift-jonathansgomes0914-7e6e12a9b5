import Foundation

struct Service {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }

    func fetchList(of user: String, completion: @escaping ([Repository]?) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(user)/repos")
        else {
            completion(nil)
            return
        }
        network.performGet(url: url) { data in
            guard let data = data
            else {
                completion(nil)
                return
            }
            let repository = try? JSONDecoder().decode([Repository].self, from: data)
            completion(repository)
        }
    }
}
