# geoOdooHelper: Bash Script for Pulling Changes and Restarting Services

## Description
This Bash script is designed to automate the process of pulling changes from Git repositories and restarting services. It provides options for pulling changes and restarting services for both Docker projects and local projects. The script accepts two arguments: an option (-d for Docker projects, -l for local projects) and a filename or pattern to search for.


## Installation
``` bash
git clone https://github.com/GeorgeEM7/geoOdooHelper.git
```
``` bash
cd geoOdooHelper
```
``` bash
./installer.sh
```


## Usage
Usage: ./script.sh [option] [filename or pattern]

Options:
-h Display this help message
-d Pull changes and restart services for Docker projects
-l Pull changes and restart services for local projects

Arguments:
filename or pattern Specify the filename or pattern to search for


## Example Usage
```bash
# Pull changes and restart services for Docker project
./script.sh -d project_name

# Pull changes and restart services for local project
./script.sh -l pattern
```

## Prerequisites
* Git must be installed for pulling changes from repositories.
* Docker must be installed for restarting Docker services.


## License
This project is licensed under the MIT License.
