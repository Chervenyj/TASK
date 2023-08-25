*** Settings ***
Test Setup      SetupTearDown.Setup test suite
Suite Teardown  SetupTearDown.End test

Resource        ../../../utils.resource


*** Test Cases ***
Add items to cart Test

    Read data           src/task-robot-framewort/tests/shop/item-detail/item-detail.json
    Reject all cookies
    Open Catalogue      ${data}[items][0]
    Close advertising
    Open Category       ${data}[items][0]
    Specify Category    ${data}[items][0]
    Sort by             Price High to Low
    Add items to cart   ${data}[items]
    