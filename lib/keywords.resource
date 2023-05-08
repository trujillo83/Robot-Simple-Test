*** Settings ***
Documentation       keywords used in get_menu.robot suite


*** Keywords ***
Open Web Page
    [Documentation]    open webpage where test will run
    Open Browser    ${HOMEPAGE}    ${BROWSER}

Get Text Using Keyword
    [Documentation]    get the text in webpage using an specific element path
    [Arguments]    ${element_path}
    ${xpath}=    Set Variable    ${element_path}
    ${text}=    Get Text    xpath=(${xpath})
    RETURN    ${text}

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
        Sleep    1
        Input Text    //body/div[1]/div[2]/div[2]/div[1]/form[1]/input[1]    ${element_in_list}
        Click Element    //button[contains(text(),'Hae')]
        Sleep    1
        ${whole_day_menu}=    Get Text Using Keyword    //body/div[5]/div[1]/div[2]/div[1]/div[2]
        Append To List    ${MENUS_LIST}    ${whole_day_menu}
    END
    Set Test Variable    ${MENUS_LIST}
    Set Test Variable    ${RESTAURANTS_LIST}    ${restaurants_to_look_for}

Create File With Found Menus
    [Documentation]    write in a file the items found in webpage
    [Arguments]    ${file_name_to_write}
    Log Many    @{MENUS_LIST}
    Write To File    ${file_name_to_write}    ${MENUS_LIST}    ${RESTAURANTS_LIST}    ${DATETIME}
