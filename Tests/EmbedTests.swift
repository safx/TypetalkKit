//
//  EmbedTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/04/07.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import XCTest
@testable import TypetalkKit

class EmbedTests: XCTestCase {

    func testProfile() {
        let model = try! decode(Embed.self, fromJsonFile: "model_embed")

        XCTAssertEqual(model.type, "rich")
        XCTAssertEqual(model.version, 1)
        XCTAssertEqual(model.providerName, "Speaker Deck")
        XCTAssertEqual(model.providerUrl!.absoluteString, "https://speakerdeck.com/")
        XCTAssertEqual(model.title, "Nulab's Way of Working Remotely")
        XCTAssertEqual(model.authorName, "Nulab Inc.")
        XCTAssertEqual(model.authorUrl!.absoluteString, "https://speakerdeck.com/nulabinc")
        XCTAssertEqual(model.html, "<iframe allowfullscreen=\"true\" allowtransparency=\"true\" frameborder=\"0\" height=\"596\" id=\"talk_frame_130304\" mozallowfullscreen=\"true\" src=\"//speakerdeck.com/player/4445cf303b350132afda224ffdff9a3d\" style=\"border:0; padding:0; margin:0; background:transparent;\" webkitallowfullscreen=\"true\" width=\"710\"></iframe>\n")
        XCTAssertEqual(model.width, 710)
        XCTAssertEqual(model.height, 596)
    }
}
