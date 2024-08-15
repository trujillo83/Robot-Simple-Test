*** Settings ***
Documentation       keywords used in get_menu.robot suite
Library             Collections
Library             DateTime
Library             String
Library             SeleniumLibrary
Library             custom_library.py

*** Keywords ***
Initialize Browser For Test
    Get Current Date As Datetime Format
    Open Web Page
    Maximize Browser Window
    Check Cookies Box

Open Web Page
    [Documentation]    open webpage where test will run
    Open Browser    ${HOMEPAGE}    ${BROWSER}

Get Current Date As Datetime Format
    [Documentation]    get the current date in computer where running test
    ${current_date}=    Get Current Date
    ${datetime}=    Convert Date    ${current_date}    datetime    exclude_millis=True
    Set Test Variable    ${DATETIME}    ${datetime}

Search In Webpage For Elements In File
    [Documentation]    write and search in webpage with elements found in text file
    [Arguments]    ${file_name}
    ${MENUS_LIST}=    Create List
    ${restaurants_to_look_for}=    Read From File    ${file_name}
    ${list_range}=    Get Length    ${restaurants_to_look_for}
    FOR    ${element_in_list}    IN    @{restaurants_to_look_for}
        Click Element    //*[@id="navi"]/a[1]
        Sleep    3
        Input Text    //div[@class='form-container']//input[@data-lounaat-element='query']    ${element_in_list}
        Click Element    //button[contains(text(),'Hae')]
        Sleep    3
        ${whole_day_menu}=    Get Text    //div[@class='item-body']
        Append To List    ${MENUS_LIST}    ${whole_day_menu}
    END
    Set Test Variable    ${MENUS_LIST}
    Set Test Variable    ${RESTAURANTS_LIST}    ${restaurants_to_look_for}

Create File With Found Menus
    [Documentation]    write in a file the items found in webpage
    [Arguments]    ${file_name_to_write}
    Log Many    @{MENUS_LIST}
    Write To File    ${file_name_to_write}    ${MENUS_LIST}    ${RESTAURANTS_LIST}    ${DATETIME}

Check Cookies Box
    [Documentation]    Check if pop-up cookies dialog is shown and close
    ${cookie_dialog}    Run Keyword And Return Status
    ...    Wait Until Page Contains Element
    ...    //div[@class='qc-cmp2-summary-buttons']
    ...    timeout=5
    IF    ${cookie_dialog}
        Click Element    //*[@id="qc-cmp2-ui"]/div[2]/div/button[3]
    ELSE
        Log To Console    No open cookies dialog
    END
