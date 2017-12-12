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

import Foundation

/// PostgreSQLCredentials class
///
/// Contains the credentials for a PostgreSQL service instance.
public class PostgreSQLCredentials: Credentials {

  public let database: String
    init?(uri: String) {      
      guard let parsedURL = URLComponents(string: uri) else {
        return nil
      }
      // Remove slash from path
      var database = parsedURL.path
      database.remove(at: database.startIndex)

      if database.count == 0 {
        return nil
      }

      self.database = database
      super.init(url: uri)
    }
}

extension CloudEnv {

  /// Returns an PostgreSQLCredentials object with the corresponding credentials.
  ///
  /// - Parameter name: The key to lookup the environment variable.
  public func getPostgreSQLCredentials(name: String) -> PostgreSQLCredentials? {
    guard let credentials = getDictionary(name: name),
      let uri = credentials["uri"] as? String else {
      return nil
    }

    return PostgreSQLCredentials(uri: uri)
  }

}
