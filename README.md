# cocoapods-check_latest

A CocoaPods plugin that checks if the latest version of a pod is up to date.

## Installation

```bash
$ gem install cocoapods-check_latest
```

## Usage

```bash
$ pod check-latest viewcontroller


-> AMBubbleTableViewController
   - Homepage: https://github.com/andreamazz/AMBubbleTableView
   - Latest pod version:0.5.1
   - Latest version in original repo:0.5.1


-> APPinViewController
   - Homepage: https://github.com/Alterplay/APPinViewController
   - Latest pod version:1.0.2
   - Latest version in original repo:1.0.2


-> ARGenericTableViewController
   - Homepage: https://github.com/arconsis/ARGenericTableViewController
   - Latest pod version:1.0.0
   - Latest version in original repo:1.0.1
   Outdated!

...
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
