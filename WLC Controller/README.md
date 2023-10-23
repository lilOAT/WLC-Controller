# WLC-Controller
CMPE3003 - Computer Project
by Joel Pita 2023

##Intentions:
The WLC Controller iOS Application is designed to establish an SSH session with a Cisco WLC for WLAN management.
The app provides a select handful of controls with the beta version. These controls are to operate by sending the
WLC a command whenever a specific button is pressed, then if the action desired is to display a list of lets say
clients, then the response string will be parsed into client ojbects and displayed in a list.

    Version: 1.0 (prototype)
        - Uses raw TCP connection to Asus RT-AX58U Home Router.
            - SSH session will be implemented in future releases
        - IPv4 only.
        - Only provides list of currently connected clients.
        - WLANs and APs lists are samples to display app functionality.
        - Provides a terminal for all other commands.
        - Does not close TCP connection on app close.

##Login
    - Each field IP address, User and Password must not be left blank.
    - The user must provide a valid IPv4 address of the WLC controller. A valid IP address is that of 4 dotted octets,
    each in the range of 0-255. Eg 192.168.1.1.
    - (prototype)The admin or password field must not contain the special character '@'. This is because
    that character is present when login is a success.
    - The user must provide authorized credentials to progress into the app.
    - (prototype) The keyboard pop-up covers the password field. Touching the background will minimise the
    keyboard. Can not view password as entering, with keyboard present.
    - (protoype)Attempting to login to a valid IP address that is unreachable will not display an error.
    
##WLAN List
    - (future)Designed to display all WLANs managed by WLC.
    - (future)Selecting a WLAN will display action options to the selected WLAN:
        - Enable/Disable SSID
        - Change SSID
        - Change WPA password
    - (prototype)Displays a sample list of WLANs with no further functions.
    - Returning back to menu requires a swipe down on the view controller.
    
##AP List
    - (future)Designed to display all APs managed by WLC.
    - (future)Selecting a WLAN will display action options to the selected AP:
        - Enable/Disable AP
    - (prototype)Displays a sample list of APs with no further functions.
    - Returning back to menu requires a swipe down on the view controller.
    
##CLIENT List
    - (future)Designed to display all Clients currently connected to any WLAN managed by the WLC.
    - (future)Selecting a client will display details and perform a speed test.
    - (prototype)Selecting a client displays their:
        - IP Address
        - MAC Address
        - Interface that they are connected to [eth4 or br0]
    - Returning back to menu requires a swipe down on the view controller.

##Terminal
    - (future)Provides the user a means to perform any and all commands on the WLC
    - (prototype)Provides the user a means to perform any and all commands on the Asus home router
    - Returning back to menu requires a swipe down on the view controller.
