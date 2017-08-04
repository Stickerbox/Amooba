# Amooba
An Animation and Constraint helper library written in Swift 3

## Getting Started

A declarative animation framework for Swift, allowing you to easily chain animations without needing to use the completion block of UIView.animate

### Usage

Using the framework is as simple as calling .animate on your UIView subclass.

```
  yourView.animate(.changeColor(to: .red), .move(toX: 100, y: 150))
```

You can perform a bunch of animations together by calling .animateTogether

```
  yourView.animateTogether(.changeColor(to: .red), .move(toX: 100, y: 150))
```

You can also wrap a bunch of animations that affect different views in an animate() block.

```
  animate(
      yourView.animate(.changeColor(to: .red), .move(toX: 100, y: 150)),
      yourView.animateTogether(.changeColor(to: .red), .move(toX: 100, y: 150))
    )
```

Amooba also helps you set constraints with a much cleaner syntax. You can also animate some of these constraint changes.

You can easily fill the superview with:

```
  yourView.fillSuperview()
```

Or you can specify padding with:

```
  yourView.fill(toFit: self.view, topPadding: 50, leftPadding: 50, bottomPadding: 50, rightPadding: 50)
```

Both of these you can animate like this:
```
  yourView.animate(.fillSuperview())
```

There are also a bunch of other constraint helper functions within Amooba:

```
  anchor(width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat
  anchorCenterToSuperview(x: CGFloat = 0, y: CGFloat = 0)
  anchorCenterXToSuperview(constant: CGFloat = 0)
  anchorCenterYToSuperview(constant: CGFloat = 0)
```

## Contributing

If you would like to contribute, create a pull request and submit it to me.

Adding new animations is simple: in the Animations.swift file, in the extension for Animation, you can create a new static func where you specify your animation. For example, if you wanted to add a new animation that moved a view up by 10 pixels, you would write:

```
public extension Animation {
  static func moveByTen(duration: TimeInterval = 0.3) -> Animation {
    return Animation(duration: duration, updatesConstraint: false) { $0.center.y += 10 }
  }
}
```

## Authors

* **Jordan Dixon** - *Initial work* - [Stickerbox](https://github.com/stickerbox)

## License

This project is licensed under the MIT License

## Recommended frameworks

Using this library in conjunction with the [Hero pod](https://github.com/lkzhao/Hero) makes animations on iOS with Swift a lot easier. Hero can animate between view controllers, and Amooba can help you animate within a single view controller.
