#!/usr/bin/python

from __future__ import print_function

import json
import os
import re


def printXCTAssert(value, path):
    path = path.replace('.embed.', '.embed!.')
    if len(path) > 5 and path[-5:] == '.type':
        path += '.rawValue'

    def p(v):
        s = str(v)
        if type(v) == str or type(v) == unicode:
            return '"%s"' % s.replace('"', '\\"').replace('\n', '\\n')
        elif type(v) == type(None):
            return 'nil'
        elif type(v) == bool:
            return s.lower()
        return s

    if type(value) == type(None):
        print('\t\t\t\tXCTAssertNil(%s)' % (path))
        return

    if path[-3:].lower() == 'url' and (value.find('http://') == 0 or value.find('https://') == 0):
        path += '.absoluteString'

    m = re.match(r'(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2})Z', str(value))
    if m:
        path += '.description'
        value = m.group(1) + ' ' + m.group(2) + ' +0000'
    print('\t\t\t\tXCTAssertEqual(%s, %s)' % (path, p(value)))


def printDictionary(dic, prefix='r'):
    for k,v in dic.items():
        varName = ''.join([e if idx == 0 else e[0].upper() + e[1:] for idx, e in enumerate(k.split('_'))])
        pf = prefix + '.' + varName
        t = type(v)
        if t == dict:
            printDictionary(v, pf)
        elif t == list:
            printArray(v, pf)
        else:
            printXCTAssert(v, pf)

def printArray(arr, prefix='r.'):
    print('\t\t\t\tXCTAssertEqual(%s.count, %d)' % (prefix, len(arr)))
    for k,v in enumerate(arr):
        pf = prefix + '[' + str(k) + ']'
        t = type(v)
        if t == dict:
            printDictionary(v, pf)
        elif t == list:
            printArray(v, pf)
        else:
            printXCTAssert(v, pf)


print('''//
//  ClientAPITests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2016/03/19.
//  Copyright (c) 2016 Safx Developers. All rights reserved.
//

import Foundation
import XCTest
import APIKit
import OHHTTPStubs
@testable import TypetalkKit


class ClientAPITests: XCTestCase {

    func createStub(name: String) {
        OHHTTPStubs.stubRequestsPassingTest({ _ in return true }) { _ in
            let fixture = OHPathForFile("api_\(name).json", self.dynamicType)
            return OHHTTPStubsResponse(fileAtPath: fixture!,
                statusCode: 200, headers: ["Content-Type":"application/json"])
        }
    }

    override func setUp() {
        TypetalkAPI.setDummyAccessTokenForTest()
        super.setUp()
    }

    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
''')

paramsDic = {
    'AddMessageToTalk'      : 'topicId: 0, talkId: 0',
    'CreateTalk'            : 'topicId: 0, talkName: ""',
    'CreateTopic'           : 'name: ""',
    'DeleteMessage'         : 'topicId: 0, postId: 0',
    'DeleteTalk'            : 'topicId: 0, talkId: 0',
    'DeleteTopic'           : 'topicId: 0',
    'DownloadAttachment'    : 'topicId: 0, postId: 0, attachmentId: 0, filename: ""',
    'FavoriteTopic'         : 'topicId: 0',
    'GetFriends'            : '',
    'GetMentions'           : '',
    'GetMessage'            : 'topicId: 0, postId: 0',
    'GetMessages'           : 'topicId: 0',
    'GetNotificationStatus' : '',
    'GetNotifications'      : '',
    'GetProfile'            : '',
    'GetSpaceMembers'       : 'spaceKey: ""',
    'GetSpaces'             : '',
    'GetTalk'               : 'topicId: 0, talkId: 0',
    'GetTalks'              : 'topicId: 0',
    'GetTopicDetails'       : 'topicId: 0',
    'GetTopicMembers'       : 'topicId: 0',
    'GetTopics'             : '',
    'LikeMessage'           : 'topicId: 0, postId: 0',
    'OpenNotification'      : '',
    'PostMessage'           : 'topicId: 0, message: ""',
    'RemoveMessageFromTalk' : 'topicId: 0, talkId: 0, postIds: []',
    'SaveReadMention'       : 'mentionId: 0',
    'SaveReadTopic'         : 'topicId: 0',
    'SearchAccounts'        : 'nameOrEmailAddress: ""',
    'UnfavoriteTopic'       : 'topicId: 0',
    'UnlikeMessage'         : 'topicId: 0, postId: 0',
    'UpdateMessage'         : 'topicId: 0, postId: 0, message: ""',
    'UpdateTalk'            : 'topicId: 0, talkId: 0, talkName: ""',
    'UpdateTopicMembers'    : 'topicId: 0',
    'UpdateTopic'           : 'topicId: 0',
    'UploadAttachment'      : 'topicId: 0, name: "", contents: NSData()'
}

ds = [f for f in os.listdir('.') if f.find('api_') == 0]
for d in ds:
    apiName = d[4:-5]
    if apiName == 'streaming':
        continue

    funcName = ''.join([e[0].upper() + e[1:] for e in apiName.split('-')])
    with open(d) as f:
        root = json.loads(f.read())
        print('''
\tfunc test%s() {
\t\tcreateStub("%s")

\t\tlet expectation = expectationWithDescription("")
\t\tTypetalkAPI.sendRequest(%s(%s)) { result in
\t\t\tswitch result {
\t\t\tcase .Success(let r):''' % (funcName, apiName, funcName, paramsDic.get(funcName, '')))
        printDictionary(root)
        print('''
\t\t\t\texpectation.fulfill()
\t\t\tcase .Failure(let error):
\t\t\t\tXCTFail("\(error)")
\t\t\t}
\t\t}

\t\twaitForExpectationsWithTimeout(3) { (error) in
\t\t\tXCTAssertNil(error, "\(error)")
\t\t}
\t}
''')

print('}')
