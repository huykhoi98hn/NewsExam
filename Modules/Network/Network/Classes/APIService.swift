import Foundation

public enum APIError: Error {
    case noData
    case parseFail
    case unknowed
    case invalidUrl
    case cancelRequest
    case noInternet
}

public class APIService {
    private let session: URLSession
    private let domain: String
    private let networkQueue: OperationQueue
    private var operationCount = 0
    private let lock = NSLock()
    
    public static let shared: APIService = {
        let domain = "https://newsapi.org/"
        let session = URLSession.shared
        let networkQueue = OperationQueue()
//        networkQueue.maxConcurrentOperationCount = 1 //set this value to limit number of request
        return APIService(domain: domain, session: session, networkQueue: networkQueue)
    }()
    
    private init(domain: String, session: URLSession, networkQueue: OperationQueue) {
        self.domain = domain
        self.session = session
        self.networkQueue = networkQueue
    }
    
    public func doRequest<T: Codable>(_ request: RequestType, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = request.makeUrlRequest(domain) else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        let operation = NetworkOperation(
            session: session,
            urlRequest: urlRequest
        ) { [weak self] data, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    let decoder = JSONDecoder()
                    if let model = try? decoder.decode(T.self, from: data) {
                        completion(.success(model))
                    } else {
                        completion(.failure(APIError.parseFail))
                    }
                } else {
                    completion(.failure(APIError.noData))
                }
                self?.finishOperation()
            }
        }
        networkQueue.addOperation(operation)
    }
    
    public func doRequestArray<T: Codable>(_ request: RequestType, completion: @escaping (Result<[T], Error>) -> Void) {
        guard let urlRequest = request.makeUrlRequest(domain) else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        let operation = NetworkOperation(
            session: session,
            urlRequest: urlRequest
        ) { [weak self] data, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    let decoder = JSONDecoder()
                    if let model = try? decoder.decode([T].self, from: data) {
                        completion(.success(model))
                    } else {
                        completion(.failure(APIError.parseFail))
                    }
                } else {
                    completion(.failure(APIError.noData))
                }
                self?.finishOperation()
            }
        }
        addOperation(operation)
    }
    
   
    
    func haveNoRequesting() -> Bool {
        return operationCount == 0
    }
    
    func addOperation(_ operation: NetworkOperation) {
        networkQueue.addOperation(operation)
        lock.lock()
        operationCount += 1
        lock.unlock()
    }
    
    private func finishOperation() {
        lock.lock()
        if operationCount > 0 {
            operationCount -= 1
        }
        lock.unlock()
    }
}
