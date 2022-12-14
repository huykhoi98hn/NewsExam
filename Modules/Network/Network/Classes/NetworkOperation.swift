import Foundation

class NetworkOperation: AsynchronousOperation {
    var urlRequest: URLRequest
    var session: URLSession
    var completion: (Data?, Error?) -> Void
    var dataTask: URLSessionDataTask?
    
    init(session: URLSession, urlRequest: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        self.urlRequest = urlRequest
        self.session = session
        self.completion = completion
        super.init()
    }
    
    override func main() {
        dataTask = session.dataTask(
            with: urlRequest,
            completionHandler: { [weak self] data, _, error in
                guard let self = self else {
                    return
                }
                self.completion(data, error)
                self.completeOperation()
            })
        dataTask?.resume()
    }
    
    override func cancel() {
        dataTask?.cancel()
        completion(nil, APIError.cancelRequest)
        super.cancel()
        completeOperation()
    }
}
