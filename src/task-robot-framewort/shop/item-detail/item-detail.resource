*** Settings ***
Resource     item-detail_mapping.resource
Resource     ../../utils.resource

*** Keywords ***
Add items to cart
    [Arguments]  ${sort}

    ${itemsData}  Get Length  ${sort}
    # Count items in data
    set test variable  ${addedItems}  0
    # New variable for multiple items adding

    wait for element   ${loc_LIST_ITEM_BOX}
    set test variable  ${CountItemsXpath}  ${loc_LIST_ITEM_BOX}
    ${ItemsNumber}  Get Element Count  ${CountItemsXpath}
    # Count web elements from list of elements

    FOR  ${item}  IN RANGE  1  ${ItemsNumber}+1

        ${nameWEB}          Get text  (${loc_LIST_ITEM_BOX}//a[contains(@class,'name browsinglink')])[${item}]
        ${descriptionWEB}   Get text  (${loc_LIST_ITEM_BOX}//*[@class='Description'])[${item}]
        ${priceWEB}         Get text  (//*[@class='bottom']//*[@class='price-box__price'])[${item}]
        # Get web elements

        IF  "${nameWEB}" == "${sort}[${addedItems}][name]" and "${descriptionWEB}" == "${sort}[${addedItems}][description]" and "${priceWEB}" == "${sort}[${addedItems}][price]"
           Click on element   (//a[@class='btnk1'])[${item}]
           # If web elements equal to data elements, then it should click on it and go to next cycle

           ${addedItems}  Evaluate  ${addedItems} + 1
           # After the condition is met, switches to the next object in  data

           Exit For Loop If   ${addedItems} == ${itemsData}
           # End cycling, when all data from json is correct
        END

        IF  ${item} == ${ItemsNumber}  Fail  Item is not exist
    END

Sort by
    [Arguments]  ${sort}

    Click on element    //li[contains(.,'${sort}')]
    # dynamic function can be controlled by text

    Wait Until Element Is Enabled    ${loc_LOADER_CONTAINER}
    # Waiting for sorting

Open Catalogue
    [Arguments]  ${catalogue}

    Click on element    //a[contains(.,'${catalogue}[catalogue]')]
    # dynamic function can be controlled by json file

Open Category
    [Arguments]  ${category}

    Click on element    ${loc_BUTTON_COTALOG}//a[contains(.,'${category}[category]')]
    # dynamic function can be controlled by json file

Specify Category
    [Arguments]  ${specified_category}

    Click on element    //a[contains(.,'${specified_category}[specifiedCategory]')]
    # dynamic function can be controlled by json file

Close advertising

    Click on element     //*[@id='alzaDialog']//*[@class='close']
