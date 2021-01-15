#! /usr/bin/env bash

# Automates using Sherlock & WhatsMyName. Creates Fodlers for the
# username if it doesn't exist. Runs both tools from within that
# folder.

#Check that only 1 username is provided
if [[ $# -ne 1 ]]
then
    echo "Wrong number of parameters";
    echo "Usage: nameFinder.sh USERNAME";
    exit 2;
fi

# If folder does not exist in working directory, create it
# Then run the tools from within that directory

if [[ -d "$@" ]]
then
    cd "$@";
else
    mkdir "$@";
    cd "$@";
fi


# Sherlock
echo "Running sherlock";
python3 /usr/share/sherlock/sherlock -o sherlock.txt "$@";
echo "Ran sherlock";
sleep 1;

# WhatsMyName
python3 /usr/share/WhatsMyName/web_accounts_list_checker_threading.py -in /usr/share/WhatsMyName/web_accounts_list.json -of whatsmyname.txt -u "$@";
echo "Ran both tests successfully";

perl /usr/share/nameFinder/parser.pl;

echo "Removed Duplicates & 404 errors";

python3 /usr/share/EyeWitness/Python/EyeWitness.py -f unique.txt --timeout 20 --max-retries 10 --web -d EyeWitness/
