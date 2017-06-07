/*
 * Copyright IBM Corporation 2017
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import XCTest
import Foundation
import Configuration
@testable import CloudFoundryConfig

class ObjectStorageTests: XCTestCase {

    static var allTests : [(String, (ObjectStorageTests) -> () throws -> Void)] {
        return [
            ("testServiceGetters", testServiceGetters),
        ]
    }

    func testServiceGetters() {

        let manager = ConfigurationManager()

        // Modify relative path for your system, make more dynamic later
        let filePath = URL(fileURLWithPath: #file).appendingPathComponent("../config_example.json").standardized
        manager.load(url: filePath)

        guard let credentials =  manager.getObjectStorageCredentials(name: "ObjectStorageService") else {
            XCTFail("Could not load Object Storage credentials.")
            return
        }

        XCTAssertEqual(credentials.authURL, "https://identity.open.softlayer.com", "Object Storage Service authURL should match.")
        XCTAssertEqual(credentials.project, "object_storage", "Object Storage Service project should match.")
        XCTAssertEqual(credentials.projectID, "79f5d7e9c6a64e2d1239f866d6b2d13a", "Object Storage Service projectID should match.")
        XCTAssertEqual(credentials.region, "dallas", "Object Storage Service region should match.")
        XCTAssertEqual(credentials.userID, "123", "Object Storage Service userID should match.")
        XCTAssertEqual(credentials.username, "admin_123", "Object Storage Service username should match.")
        XCTAssertEqual(credentials.password, "<password>", "Object Storage Service password should match.")
        XCTAssertEqual(credentials.domainID, "<domainID>", "Object Storage Service domainID should match.")
        XCTAssertEqual(credentials.domainName, "1070801", "Object Storage Service domainName should match.")

    }

}
