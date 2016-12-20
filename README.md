![](/images/icon-readme.png)
# Juice ⚡️
Make your battery information a bit more interesting by making your own measurement scale instead of a boring battery indicator.

I was browsing Tumblr one day and saw Cyle make a post about this:
![](/images/cyle-post.png)

This got me to thinking if something like that was possible from the frameworks that Apple gives us developers. As it turns out the `IOKit` framework provides a wealth of information and triggers about what's going on with your computer. With this framework you can get power source information and generate callback when values of these sources change!

Going a step further, I wanted to define a format that would allow for people to create their own scales! Which you can now do, but it's strings only for the time being.

## Screenshots
![](https://d3vv6lp55qjaqc.cloudfront.net/items/2N0v171X0y0z3m0A2M1E/Image%202016-12-17%20at%209.29.43%20PM.png?X-CloudApp-Visitor-Id=137600)

## Installation

You can either compile the app through Xcode with the sources, or downloaded the latest binary that has been released [here](https://github.com/brianmichel/Juice/releases/latest)

## Adding A Scale

1. Go to preferences and click the "Add New Scale", this will attempt to create and open a new `plist` file that can be used by Juice to load a custom scale. The structure of the plist is described below
2. Make the desired changes to your scale `plist` in your favorite text editor and save.
3. Go to preferences and rescan for scales, you should now see the title of the scale you just created in the drop down list of scales to pick from.

## Plist Format

The format currently used to load custom scales is a simple `plist` file, let's look at the structure of the document:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>default</key>
	<string>Edit The Default Value To Show</string>
	<key>detents</key>
	<dict>
		<key>0</key>
		<string>Edit Me, I'll be triggered from 0 to 10%</string>
		<key>1</key>
		<string>Edit Me, I'll be triggered from 10 to 20%</string>
		<key>2</key>
		<string>Edit Me, I'll be triggered from 20 to 30%</string>
		<key>3</key>
		<string>Edit Me, I'll be triggered from 30 to 40%</string>
		<key>4</key>
		<string>Edit Me, I'll be triggered from 40 to 50%</string>
		<key>5</key>
		<string>Edit Me, I'll be triggered from 50 to 60%</string>
		<key>6</key>
		<string>Edit Me, I'll be triggered from 60 to 70%</string>
		<key>7</key>
		<string>Edit Me, I'll be triggered from 70 to 80%</string>
		<key>8</key>
		<string>Edit Me, I'll be triggered from 80 to 90%</string>
		<key>9</key>
		<string>Edit Me, I'll be triggered from 90 to 100%</string>
	</dict>
	<key>title</key>
	<string>Edit The Title</string>
</dict>
</plist>
```

| Key Name | Value Type | Description |
|----------|------|-------------|
| `default` | `String` | The default value to be shown if Juice can't figure out what's going on with the power source |
| `detents` | `Dictionary<String, String>` | A mapping of detents (steps in the charge ratio) to string values to show to the user |
| `title` | `String` | The title of the scale to be displayed in the preference UI |

**NOTE:** The name of the plist file you save should be unique, by default UUID's are generated as the name of files if you create a scale through the UI.

If you'd like to drop your own plist to be used by the application, new files can be dropped into the `~/Library/Containers/com.bsm.macos.Juice/Data/Library/Application Support/Juice` folder.

## ✌️

Feel free to contribute by making a pull request and I'll take a look when I can! If you'd like to reach me, feel free to hit me up on Twitter [@brianmichel](https://www.twitter.com/brianmichel).
