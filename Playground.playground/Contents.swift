import TypetalkKit
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


TypetalkAPI.setDeveloperSettings(
    clientId: "your_cliend_id",
    clientSecret: "your_secret_id",
    scopes: [Scope.my, Scope.topicRead])


TypetalkAPI.authorizeWithClientCredentials { (err) -> Void in
    if let err = err { print(err); return }

    TypetalkAPI.send(GetTopics()) { result in
        switch result {
        case .success(let response):
            response.topics.forEach { print($0) }
        case .failure(let error):
            print(error)
        }
    }
}
