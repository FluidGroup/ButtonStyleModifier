import SwiftUI

public protocol ProcessingButtonStyle: ButtonStyle {
  
  func processing(_ isProcessing: Bool) -> Self
  
}

public struct ButtonState: Equatable {
  /// available also `_styled_isPressed`
  public let isPressed: Bool

  public let isEnabled: Bool
  /// available also `_styled_isProcessing`
  public let isProcessing: Bool
}

/// A button style that applies a modifier to the button's label.
///
/// - Available Environment Values:
/// - isPressed: ``\._styled_isPressed``
/// - isProcessing: ``\._styled_isProcessing``
public struct ButtonStyleModifier<Modified: View>: ProcessingButtonStyle {

  @Environment(\.isEnabled) private var isEnabled

  public var isProcessing: Bool = false

  private let modify: (ButtonStyle.Configuration.Label, ButtonState) -> Modified

  public init(
    @ViewBuilder modify: @escaping (ButtonStyle.Configuration.Label, ButtonState) -> Modified
  ) {
    self.modify = modify
  }

  public init<Modifier: ViewModifier>(modifier: Modifier)
  where Modified == ModifiedContent<ButtonStyle.Configuration.Label, Modifier> {
    self.init(modify: { label, _ in
      label.modifier(modifier)
    })
  }

  public func makeBody(configuration: Configuration) -> some View {
    /// iOS 14 can't use @Environment in ButtonStyle protocol.
    modify(
      configuration.label,
      .init(isPressed: configuration.isPressed, isEnabled: isEnabled, isProcessing: isProcessing)
    )
    .environment(\._styled_isPressed, configuration.isPressed)
    .environment(\._styled_isProcessing, isProcessing)
    .contentShape(Rectangle())
    .allowsHitTesting(isProcessing == false)
  }

  public consuming func processing(_ isProcessing: Bool) -> Self {
    self.isProcessing = isProcessing
    return self
  }

}

extension EnvironmentValues {

  @Entry public var _styled_isPressed: Bool = false

  @Entry public var _styled_isProcessing: Bool = false
}
