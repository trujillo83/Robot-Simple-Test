*** Settings ***
Documentation       check for the menu of the day
Variables           lib/variables.py
Resource            lib/keywords.resource


*** Test Cases ***
Get menu of the day
    [Documentation]    Get menus of the day from your favorite restaurants
    [Setup]    Initialize Browser For Test
    [Teardown]    Close All Browsers
    Search In Webpage For Elements In File    ${PATH_FILE_WITH_NAMES}
    Create File With Found Menus    ${PATH_FILE_TO_WRITE}
