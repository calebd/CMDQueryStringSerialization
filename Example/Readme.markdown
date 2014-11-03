# CMDQueryStringSerialization [![Build Status](https://travis-ci.org/calebd/CMDQueryStringSerialization.svg?branch=master)](https://travis-ci.org/calebd/CMDQueryStringSerialization)

Easily convert between dictionaries and query strings in iOS and OS X. The API is similar to `NSJSONSerialization`.

## Usage

```objc
NSString *queryString = [CMDQueryStringSerialization queryStringWithDictionary:dictionary];
```

`CMDQueryStringSerialization` supports arrays encoded in one of the following three formats:

* `key=value1&key=value2`
* `key[]=value1&key[]=value2`
* `key=value1,value2`

`CMDQueryStringWritingOptions` contains options that map to each of these formats, with `CMDQueryStringWritingOptionArrayRepeatKeysWithBrackets` being the default if no option is passed.

## License

`CMDQueryStringSerialization` is released under the MIT License.
