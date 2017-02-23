# Expanding Toolbar


A customizable menu bar that expands to allow users to access multiple functions

## Features

* Set expansion to any major compass direction (North, South, East West)

* Set a fixed origin for toolbar or set as pannable

* Add an unlimited number of functions

* Customizable toolbar buttons

## Setup

* Add the ExpandingToolbar.swift file to your Xcode project

* Import ExpandingToolbar into the file

* Set a location and size for the expanding toolBar in your view. Most often in ViewDidLoad()

  * The smallest dimension set (`height`, `width`) will set the size of the expanding toolbar's smallest state. In the example below, `height` is the smallest dimension, meaning the smallest state of the toolbar will be a 50x50 square. You can override this size by providing a specific button size in the initializer

  * The maximum length of the toolbar will be the maximum of:
    * Largest dimension specified in the frame
    * Number of actions assigned to the toolbar times the smallest dimension
    * Number of actions times the specified button size.


```
let frame = CGRect(x: 200, y: 250, width: 200, height: 50)

let toolbar = ExpandingToolBar(frame: frame, buttonSize: 50)

```

## Adding and Editing Buttons

### Create Toolbar Actions + Buttons

Add actions with the `addAction()` function. You can choose to add a title, custom font, image, or color. You can pass functions as closures or pass in existing function by name.

```
toolbar.addAction(title: "orange", font: nil, image: nil, color: UIColor.orange, action: makeOrange)

toolbar.addAction(title: "blue", font: nil, image: nil, color: UIColor.blue, action: makeBlue)


// Or add as a closure

toolbar.addAction(title: "red", font: nil, image: nil, color: UIColor.red) {
    self.view.backgroundColor = UIColor.red
}
```

```
func makeOrange() -> (){
    self.view.backgroundColor = UIColor.orange
    print("orange")
}

func makeBlue(){
    self.view.backgroundColor = UIColor.blue
    print("blue")
}
```

### Edit ToolBar Actions + Buttons

The following functions are provided so you can customize the buttons on your Toolbar. Index start from 0 starting from the inside

#### Change Title

  `setTitleForButtonAt(index: Int, title: String, font: UIFont?)`

#### Change Background Color

  `setColorsForActionAt(index: Int, color: UIColor)`

#### Set Image

  `setImageForButtonAt(index:Int, image:UIImage)`



## Setting Direction

The toolbar can expand in the North, South, East, or West direction.

To change the direction set the `direction` variable on an instance of the ExpandingToolbar

`toolbar.direction = .east`

## Setting as Panable

1. Set you ViewController to conform to the `Pannable` protocol

2. Set the delegate for the Expanding ToolBar

3. When if you want to disable panning at any time set the `pannable` field in ExpandingToolBar to `false`

`class ViewController: UIViewController, Pannable`

`toolbar.panDelegate = self`

`toolbar.panable = true`

![](https://github.com/nkhaja/expanding-toolbar/tree/master/ExpandingToolbarPreview.gif)
