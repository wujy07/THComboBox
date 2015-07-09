# THComboBox
An IBDesignable custom combobox control for iOS. The text font can resize adaptively.

<img src="http://wujy07.github.io/img/For github/THComboBox/THComboBox.png">

## Installation
### From [CocoaPods](http://www.cocoapods.org)

	pod 'THComboBox'

Attention:IBDesignable doesn't work with static libraries in Xcode now. Probably you'll meet [this problem](http://stackoverflow.com/questions/28391112/interface-builder-failed-to-load-designables-from-path-null/). Maybe this bug will be fixed in the future. But now you'd better install it from source. 
### From source

* Drag the `THComboBox/` folder to your project 
* `#import "THComboBox.h"`

## How To Use

### With Storyboards or Xib

Create a `UIView` and change its class to `THComboBox`

<img src="http://wujy07.github.io/img/For github/THComboBox/THComboBox_1-1.png">
<img src="http://wujy07.github.io/img/For github/THComboBox/THComboBox_1-2.png">

Change the settings in IB as you like:

<img src="http://wujy07.github.io/img/For github/THComboBox/THComboBox_2.png">

Then set the property listItems like this:
````objective-c
self.comboBox1.listItems = @[@"主楼",@"学堂",@"文图",@"东门"];
self.delegate = self;		//let the viewcontroller implement ComboBoxDelegate
````

### Create programmatically

Very easy like this:

````objective-c
THComboBox *comboBox1 = [[THComboBox alloc] initWithFrame:CGRectMake(200, 400, 210, 60)];
````
Then change the settings programmatically.

