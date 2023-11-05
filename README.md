# InterSystem IRIS Smart String

Datatype class that can be extended from or used directly.  
It supports validation of property values using regular expression.  
It supports additional validation of property values using a string to indicate the classmethod to call.  
It supports a stripping sequence for automatic value cleanup.  
The property can be configured with a explicitly set regular expression 
or the reference to a global node containing the regular expression, 
which can then be changed without the need to recompile.  
The additional validator can also be configured to read from a global similar to the regular expression.  
The value cleanup can also be configured to read from a global similar to the regular expression.

# Installation

zpm "install baasvancodeza-iris-smart-string"  
The usage sample is available in the GitHub repo  
```
git clone https://github.com/baasvancodeza/iris-smart-string.git
```

## Using the Demo

### Using Docker Compose
- Clone the repo
- Go nto your terminal of choice into the project directory
- Build the container
  ```
  docker-compose build
  ```
- Start the container
  ```
  docker-compose up -d
  ```
- Open an IRIS session on the running container instance
  ```
  docker-compose exec iris iris session iris -U IRISAPP
  ```
- Run the following  
  ```
  s ^SysConfig("IDNumberRegex") = "^\d{13}$"
  s ^SysConfig("LastNameCleanup") = "$lb($lb(""<=>W"","""",""""),$lb(""*C"","""",""""),$lb(""*P"","""",""- '""))"
  Do ##class(baasvancodeza.Demo.RunDemo).Run()
  ```
- To go tot he Mangement Portal to run SQL queries on the table go to the below. Remember to replace the "hostname-or-ip with your computer's IP or hostname  
  http://hostname-or-ip:9081/csp/sys/UtilHome.csp
  

### From Source
- Clone the repo
- Import the includes and classes and compile
  - baasvancodeza.DataTYpes first
  - baasvancodeza.Demo second
- Open a terminal
  - Change to the namespace where you have imported the package and imported the Demo srouce
  - Run the following  
    ```
    s ^SysConfig("IDNumberRegex") = "^\d{13}$"
    s ^SysConfig("LastNameCleanup") = "$lb($lb(""<=>W"","""",""""),$lb(""*C"","""",""""),$lb(""*P"","""",""- '""))"
    Do ##class(baasvancodeza.Demo.RunDemo).Run()
    ```

### Demo Description

The Demo showcases the following features
 - Person.FirstName: The datatype is used directly on Proerpty, with a regular expression validation, and a data cleanup.
 - Person.LastName: Uses the "LastName" datatype, which defines a cleanup sequence read from a global.
 - Person.IDNumber: Uses the "IDNumber" datatype, which defines a regular expression read from a global, and an additional validation method.
 - Person.PhoneNumber: Uses the "PhoneNumber" datatype, which defines a regular epression literal value in the class parameters.

<br>

First Phase
- The first phase creates a Person object, and assigns values to the properties
  - FirstName with an invalid value
  - LastName with garbage data
  - ID Number that is too long
  - Phone Number of the incorrect format  
- It then validates the Person object and outputs the results.  

<br>

Second Phase
- The second phase runs the %NormalizeOjbect method of the Person instance.
- It displays the cleaned up First Name and Last Name values.
- It then validates the Person object and outputs the results.

<br>

Third Phase
- The third phase corrects the Phone Number and changes the ID Number to the correct length.
- It displays the "set" statements.
- It then validates the Person object and outputs the results.

<br>

Finally
- Finally, it changes the ID Number to a valid value.
- It displays the "set" statement.
- It then validates the Person object and outputs the results.

<br>

# Package Structure

| Path | Purpose |
| --- | --- |
| /src/baasvancodeza/DataTypes | Source to use and include in your deployment |
| /src/baasvancodeza/Demo | A demonstration of usage |

# Usage

Work throught he Demo package to see implementation examples.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/intersystems/TestCoverage/tags).

## Authors

* **Stefan Cronje** - *Initial implementation* - [baasvancodeza](http://github.com/baasvancodeza)  
  InterSystem Communitry: @Stefan.Cronje1399

See also the list of [contributors](https://github.com/baasvancodeza/iris-smart-string/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
