ROUTER_IP="192.168.11.1"

echo "==========================================================================="
echo "This batch file will upload tomato.trx in the current directory to"
echo "192.168.11.1 during the router's bootup."
echo ""
echo "* Set your ethernet card's settings to:"
echo "     IP:      192.168.11.2"
echo "     Mask:    255.255.255.0"
echo "     Gateway: 192.168.11.1."
echo "* Unplug the router's power cable."
echo ""

echo "Press Ctrl+C to abort or any other key to continue..."
read -n 1

echo ""
echo "* Re-plug the router's power cable."
echo ""
echo "==============================================================================="
echo "Waiting for the router... Press Ctrl+C to abort."
echo ""

while [ 1 = 1 ]; do
    ping_out=`ping -c 1 $ROUTER_IP |grep ttl=`

    #exit loop on success
    [ $? = "0" ] && break;
done

echo -n "Router found. Uploading firmware... "

tftp_out=`tftp -m binary $ROUTER_IP -c put tomato.trx 2>&1`

if [ $? = "0" ]; then
    echo "done."
else
    echo "failed:"
    echo $tftp_out
fi

echo ""
echo "==============================================================================="
echo "* WAIT for about 2 minutes while the firmware is being flashed."
echo "* Reset your ethernet card's settings back to DHCP."
echo "* The default router address will be at 192.168.1.1."
echo ""
