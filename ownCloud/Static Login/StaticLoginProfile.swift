//
//  StaticLoginProfile.swift
//  ownCloud
//
//  Created by Felix Schwarz on 26.11.18.
//  Copyright © 2018 ownCloud GmbH. All rights reserved.
//

/*
 * Copyright (C) 2018, ownCloud GmbH.
 *
 * This code is covered by the GNU Public License Version 3.
 *
 * For distribution utilizing Apple mechanisms please see https://owncloud.org/contribute/iOS-license-exception/
 * You should have received a copy of this license along with this program. If not, see <http://www.gnu.org/licenses/gpl-3.0.en.html>.
 *
 */

import UIKit
import ownCloudSDK
import ownCloudAppShared

extension OCClassSettingsKey {
	public static let loginProfileIdentifier : OCClassSettingsKey = OCClassSettingsKey("profile-definitions[].identifier")
	public static let loginProfileName : OCClassSettingsKey = OCClassSettingsKey("profile-definitions[].name")
	public static let loginProfileAllowedAuthenticationMethods : OCClassSettingsKey = OCClassSettingsKey("profile-definitions[].allowedAuthenticationMethods")
}

extension StaticLoginProfile : OCClassSettingsSupport {
	static let classSettingsIdentifier : OCClassSettingsIdentifier = .branding

	static func defaultSettings(forIdentifier identifier: OCClassSettingsIdentifier) -> [OCClassSettingsKey : Any]? {
		return [
			.loginProfileAllowedAuthenticationMethods : ["com.owncloud.basicauth", "com.owncloud.oauth2"]
		]
	}

	static func classSettingsMetadata() -> [OCClassSettingsKey : [OCClassSettingsMetadataKey : Any]]? {
		return [
			.loginProfileIdentifier : [
				.type 		: OCClassSettingsMetadataType.string,
				.description	: "Identifier uniquely identifying the static login profile.",
				.category	: "Branding",
				.status		: OCClassSettingsKeyStatus.advanced
			],

			.loginProfileName : [
				.type 		: OCClassSettingsMetadataType.string,
				.description	: "Name of the login profile during setup.",
				.category	: "Branding",
				.status		: OCClassSettingsKeyStatus.advanced
			],

			.loginProfileAllowedAuthenticationMethods : [
				.type 		: OCClassSettingsMetadataType.stringArray,
				.description	: "The identifiers of the authentication methods allowed for this profile. Allows to f.ex. force OAuth2, or to use Basic Auth even if OAuth2 is available.",
				.category	: "Branding",
				.status		: OCClassSettingsKeyStatus.advanced
			]
		]
	}
}

typealias StaticLoginProfileIdentifier = String

class StaticLoginProfile: NSObject {
	static let staticLoginProfileIdentifierKey : String = "static-login-profile-identifier"

	var identifier : StaticLoginProfileIdentifier?
	var name : String?
	var promptForPasswordAuth : String?
	var promptForTokenAuth : String?
	var promptForURL : String?
	var promptForHelpURL : String?
	var helpURLButtonString : String?
	var welcome : String?
	var bookmarkName : String?
	var url : URL?
	var helpURL : URL?
	var canConfigureURL : Bool = false
	var allowedHosts : [String]?
	var allowedAuthenticationMethods : [OCAuthenticationMethodIdentifier]?
	var themeStyleID : ThemeStyleIdentifier?

	convenience init(from profileDict: [String : Any]) {
		self.init()

		if let identifier = profileDict["identifier"] as? String {
			self.identifier = identifier
		}
		if let name = profileDict["name"] as? String {
			self.name = name
		}
		if let prompt = profileDict["promptForTokenAuth"] as? String {
			self.promptForTokenAuth = prompt
		}
		if let promptForPasswordAuth = profileDict["promptForPasswordAuth"] as? String {
			self.promptForPasswordAuth = promptForPasswordAuth
		}
		if let promptForTokenAuth = profileDict["promptForTokenAuth"] as? String {
			self.promptForTokenAuth = promptForTokenAuth
		}
		if let promptForURL = profileDict["promptForURL"] as? String {
			self.promptForURL = promptForURL
		}
		if let promptForHelpURL = profileDict["promptForHelpURL"] as? String {
			self.promptForHelpURL = promptForHelpURL
		}
		if let helpURLButtonString = profileDict["helpURLButtonString"] as? String {
			self.helpURLButtonString = helpURLButtonString
		}
		if let welcome = profileDict["welcome"] as? String {
			self.welcome = welcome
		}
		if let bookmarkName = profileDict["bookmarkName"] as? String {
			self.bookmarkName = bookmarkName
		}
		if let url = profileDict["url"] as? String {
			self.url = URL(string: url)
		}
		if let helpURL = profileDict["helpURL"] as? String {
			self.helpURL = URL(string: helpURL)
		}
		if let canConfigureURL = profileDict["canConfigureURL"] as? Bool {
			self.canConfigureURL = canConfigureURL
		}
		if let allowedAuthenticationMethods = profileDict["allowedAuthenticationMethods"] as? NSArray {
			self.allowedAuthenticationMethods = allowedAuthenticationMethods as? [OCAuthenticationMethodIdentifier]
		}
		if let allowedHosts = profileDict["allowedHosts"] as? NSArray {
			self.allowedHosts = allowedHosts as? [String]
		}
	}
}
