import TypetalkKit
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


TypetalkAPI.setDeveloperSettings(
    clientId: "your_cliend_id",
    clientSecret: "your_secret_id",
    scopes: [Scope.my, Scope.topic_read])


TypetalkAPI.authorizeWithClientCredentials { (err) -> Void in
    if err != nil { print(err); return }

    TypetalkAPI.sendRequest(GetTopics()) { result in
        switch result {
        case .Success(let response):
            response.topics.forEach { print($0) }
        case .Failure(let error):
            print(error)
        }
    }
}
