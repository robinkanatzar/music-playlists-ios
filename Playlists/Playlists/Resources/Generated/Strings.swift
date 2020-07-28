// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// ok
  internal static let ok = L10n.tr("Localizable", "ok")
  /// inconnu
  internal static let unknown = L10n.tr("Localizable", "unknown")

  internal enum Error {
    /// Une erreur s'est produite
    internal static let unknown = L10n.tr("Localizable", "error.unknown")
  }

  internal enum PlaylistDetail {
    /// par %@
    internal static func author(_ p1: Any) -> String {
      return L10n.tr("Localizable", "playlist_detail.author", String(describing: p1))
    }
  }

  internal enum PlaylistList {
    /// Playlists
    internal static let title = L10n.tr("Localizable", "playlist_list.title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
