# Kobo Toolbox Json Formater

KoBoToolbox is a suite of tools for field data collection for use in challenging environments. AFter you create the form in their website, it can be downloaded in a few formats, incuding xls.

This project takes and exported file and generates the form in a JSON structure, ready to be used in visualization tools or any javascript program.

## Install
You have to have Ruby installed. You can use https://rvm.io and install the last version.

Then, install the two following gems
```
gem install spreadsheet json
```
## How to use

run the script in command line passing two arguments:
* the input spreadsheet file.
* the output json file name to be created.
```
ruby form_parser_kobo.rb survey.xls survey_out.json
```
