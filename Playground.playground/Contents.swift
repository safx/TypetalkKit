//: Playground - noun: a place where people can play

import Cocoa
import Result
import TypetalkKit
import XCPlayground
XCPSetExecutionShouldContinueIndefinitely()



TypetalkAPI.setDeveloperSettings(
    clientId: "your_cliend_id",
    clientSecret: "your_secret_id",
    scopes: [Scope.my, Scope.topic_read])



TypetalkAPI.authorizeWithClientCredentials { (err) -> Void in
    if err != nil { print(err); return }

    TypetalkAPI.sendRequest(GetTopics()) { result in
        switch result {
        case .Success(let response):
            response.topics.map{$0.topic.name}.map(print)
        case .Failure(let error):
            print(error)
        }
    }
}
