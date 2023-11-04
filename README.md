# InterSystem IRIS String Regular Expression

Datatype class that can be extended from or used directly.  
It supports validation of property values using regular expression.  
It supports a stripping sequence for automatic value cleanup.  
The property can be configured with a explicitly set regular expression 
or the reference to a global node containing the regular expression, 
which can then be changed without the need to recompile.  
The value cleanup can also be configured to read from a global.

# Installation

zpm "install baasvancodeza-iris-string-rgx"  
The usage sample is available in the GitHub repo  
```
git clone https://github.com/baasvancodeza/iris-string-rgx.git
```

## Using the Demo

- Clone the repo
- Import the includes and classes and compile
  - baasvancodeza.StrinRgx first
  - baasvancodeza.Demo second
- Open a terminal
  - Change to the namespace where you have imported the package and imported the Demo srouce
  - Run the following  
    ``Do ##class(baasvancodeza.Demo.RunDemo).Run()``

# Package Structure

| Path | Purpose |
| --- | --- |
| /src/baasvancodeza/StringRgx | Source to use and include in your deployment |
| /src/baasvancodeza/Demo | A demonstration of usage |

# Usage
## Implementation

TODO

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/intersystems/TestCoverage/tags).

## Authors

* **Stefan Cronje** - *Initial implementation* - [baasvancodeza](http://github.com/baasvancodeza)  
  InterSystem Communitry: @Stefan.Cronje1399

See also the list of [contributors](https://github.com/baasvancodeza/iris-string-rgx/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.