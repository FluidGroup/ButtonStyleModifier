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
