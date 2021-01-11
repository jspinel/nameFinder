# nameFinder
nameFinder automates profile enumeration with the help of https://github.com/sherlock-project and https://github.com/WebBreacher/WhatsMyName. 

## Installation:
Download and execute dependencies.sh . This will download / update sherlock, WhatsMyName and nameFinder in /usr/bin

## Use:
Run `./usr/bin/nameFinder/nameFinder.sh USERNAME` where USERNAME is the single parameter.

nameFinder takes a single parameter, the username to be enumerated. It creates a folder in your current running directory with that name, runs the 2 enumeration tools, eliminates duplicates and removes error 404 false positives.
The output is 3 files, `sherlock.txt`, `whatsmyname.txt`, and `unique.txt`. 
