*** Settings ***
Documentation       check for the menu of the day

Variables           lib/variables.py
Library             Collections
Library             DateTime
Library             String
Library             Selenium2Library
Library             lib/custom_library.py
Resource            lib/keywords.resource

Test Setup          Get Current Date As Datetime Format


*** Test Cases ***
Get menu of the day
    [Documentation]    Get menus of the day from your favorite restaurants
    Open Web Page
    Maximize Browser Window
    Search In Webpage For Elements In File    ${PATH_FILE_WITH_NAMES}
    Create File With Found Menus    ${PATH_FILE_TO_WRITE}
