An easier way to make a button style with closure or passing an instance of `ViewModifier`.

```swift
Button("Button") {
  print("")
}
.buttonStyle(
  ButtonStyleModifier { label, state in
    label
      .padding()
      .background(
        RoundedRectangle(cornerRadius: .infinity, style: .continuous)                
          .foregroundColor(Color.secondary)
      )
      .opacity(state.isEnabled ? 1 : 0.3)
  } 
```

`ButtonStyleModifier` supports indicating state of processing by `.processing()` modifier.  
This state can be read from state parameter in ButtonStyleModifier.

ButtonStyleModifier sets the following environment values for making styles in ViewModifier.

```swift
extension EnvironmentValues {
  @Entry public var _styled_isPressed: Bool = false

  @Entry public var _styled_isProcessing: Bool = false
}
```
