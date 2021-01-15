#! /usr/bin/env bash

echo "$(whoami)"

[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

# Install Sherlock
cd /usr/share;


if [[ -d sherlock ]]
then
    echo "Updating Sherlock";
    cd sherlock;
    git pull -q;
    cd ..;
    echo "Done Updating Sherlock";
else
    echo "Installing Sherlock";
    git clone https://github.com/sherlock-project/sherlock.git;
fi
cd sherlock;
python3 -m pip install -r requirements.txt;
echo "Sherlock is up to date";


cd /usr/share;
if [[ -d WhatsMyName ]]
then
    echo "Updating WhatsMyName";
    cd WhatsMyName;
    git pull -q;
    cd ..;
    echo "Done Updating";
else
    echo "Installing WhatsMyName";
    git clone https://github.com/webbreacher/WhatsMyName.git;
fi
cd WhatsMyName;
python3 -m pip install -r requirements.txt;
echo "WhatsMyName is up to date"


cd /usr/share;
if [[ -d EyeWitness]]
then
    echo "Updating Eyewitness"
    git pull -q;
    cd ..;
    echo "Done updating";
else
    echo "Installing Eyewitness";
    git clone https://github.com/ChrisTruncer/EyeWitness.git;
    cd EyeWitness/
    ./Python/setup/setup.sh;
    apt install xvfb;
fi
echo "EyeWitness is up to date"
    

cd /usr/share;
if [[ -d nameFinder ]]
then
    echo "Updating nameFinder";
    cd nameFinder
    git pull -q;
    cd ..;
    echo "Done Updating";
else
    echo "Installing nameFinder in /usr/bin";
    git clone https://github.com/jspinel/nameFinder.git;
    cd nameFinder;
    chmod a+x nameFinder.sh;
    chmod a+x binary/nameFinder;
    cp binary/namefinder /usr/bin/namefinder ;
fi

