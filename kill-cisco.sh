#/bin/bash
if [ "$#" -lt 1 ]; 
    then echo "Pass method: disconnect or connect"
    exit 1
fi
method=$1
echo "Method: ${method}"
if [ "$method" = "disconnect" ]; then
    # Disconnect
    /opt/cisco/anyconnect/bin/vpn disconnect
    # Force Quit AnyConnect
    pkill -x "Cisco AnyConnect Secure Mobility Client"
    pkill -x "Cisco AnyConnect Socket Filter"


    # # kill process
    killall -9 "com.cisco.anyconnect.macos.acsockext"

    # systemextensionsctl uninstall DE8Y96K9QP com.cisco.anyconnect.macos.acsockext
    /Applications/Cisco/Cisco\ AnyConnect\ Socket\ Filter.app/Contents/MacOS/Cisco\ AnyConnect\ Socket\ Filter -deactivateExt

    # sleep 1
    # retry kill process
    # killall -9 "com.cisco.anyconnect.macos.acsockext"
elif [ "$method" == "connect" ]; then
    sudo spctl --master-disable
    /Applications/Cisco/Cisco\ AnyConnect\ Socket\ Filter.app/Contents/MacOS/Cisco\ AnyConnect\ Socket\ Filter -activateExt
    open -n /Applications/Cisco/Cisco\ AnyConnect\ Secure\ Mobility\ Client.app
else
    echo "Pass method: import or export"
    exit 1
fi