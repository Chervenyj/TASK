*** Variables ***

${BROWSER}          chrome                      # headlesschrome for run headless REMOTE chrome, to imitate virtual machine.
${HEADLESS}         False                       # Only for chrome
${orig_timeout}     10
${spinner_timeout}  10
${selenium_speed}   0.0 sec

${URL}              https://www.alza.cz/EN/

${LOG}             0                            # 0 - disable , 1 - Log to report, 2 - Log to console