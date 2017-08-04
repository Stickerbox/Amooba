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

## Contributing

If you would like to contribute, create a pull request and submit it to me.

## Authors

* **Jordan Dixon** - *Initial work* - [Stickerbox](https://github.com/stickerbox)

## License

This project is licensed under the MIT License

## Recommended frameworks

Using this library in conjunction with the [Hero pod](https://github.com/lkzhao/Hero) makes animations on iOS with Swift a lot easier. Hero can animate between view controllers, and Amooba can help you animate within a single view controller.
