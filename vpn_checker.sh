#!/bin/bash

LOG_FILE=/var/log/vpn_boot.log
DATE_STR=$(date +'%d/%m/%Y %H:%M:%S')
WIFI_CONNECTION="wlp3s0"
#feel in as you pleased
VYPER_GATEWAYS=(fr1.vpn.goldenfrog.com eu1.vpn.goldenfrog.com dk1.vpn.goldenfrog.com se1.vpn.goldenfrog.com uk1.vpn.goldenfrog.com de1.vpn.goldenfrog.com ch1.vpn.goldenfrog.com lu1.vpn.goldenfrog.com ie1.vpn.goldenfrog.com it1.vpn.goldenfrog.com es1.vpn.goldenfrog.com no1.vpn.goldenfrog.com fi1.vpn.goldenfrog.com cz1.vpn.goldenfrog.com at1.vpn.goldenfrog.com be1.vpn.goldenfrog.com lt1.vpn.goldenfrog.com gr1.vpn.goldenfrog.com)
VYPER_VPN_CONF=/etc/NetworkManager/system-connections/VyperVPN

#attempts limit
LIMIT=3
LIMIT_N=0

# by default, i assume there is table 200 is already here > /etc/iproute2/rt_tables
IP_LOCAL='192.168.0.0/16'
# external ip
IP_EXTER='X.X.X.X' 
IP_GATE='192.168.1.1'


WIFI_STATUS=`nmcli con | grep "${WIFI_CONNECTION}"`
if [ -z "${WIFI_STATUS}" ]; then
        echo "${DATE_STR} WIFI IS DEAD";
        exit 0;
fi

STATUS=`nmcli con | grep "vpn" | grep -v "\-\-"`;

if [ ! -z "${STATUS}" ]; then
        echo "${DATE_STR} VPN_OK -> ${STATUS}";
        exit 0;
fi

echo "${DATE_STR} VPN ISN'T OK"

SELECTED_GATEWAY="fr1.vpn.goldenfrog.com"
gateway() {
        RANDOM=$$$(date +%s)
        SELECTED_GATEWAY=${VYPER_GATEWAYS[$RANDOM % ${#VYPER_GATEWAYS[@]} ]}
}

reconnect_vpn() {
        ((LIMIT_N++))
        if [ $LIMIT_N -gt $LIMIT ]; then
                echo "EXCEEDED ATTEMPTS LIMIT ${LIMIT_N} > ${LIMIT}"
                sleep 1
                exit 5
        fi


        if nmcli con up id VyperVPN; then
                echo "VYPER CONNECTED";
                cat $VYPER_VPN_CONF | grep "gateway"
        else
                echo "ERROR WHILE CONNECTING TO VYPER";
                gateway
                echo "REPLACING GATEWAY TO ${SELECTED_GATEWAY}"
                sed -i -E "s/gateway=.*$/gateway=${SELECTED_GATEWAY}/g" $VYPER_VPN_CONF
                sleep 2
                reconnect_vpn
        fi
}
reconnect_vpn


add_rules() {
# IF VPN IS DEFAULT
#       STATUS=`ip rule | grep "${IP_LOCAL}"`
#       if [ ! -z "${STATUS}" ]; then
#               echo "rules are already there";
#               return
#       fi

#       ip rule add from $IP_LOCAL table 200
#       ip rule add from $IP_EXTER table 200
#       ip route add table 200 default via $IP_GATE


# if vpn ISN't default
        #getting vyper ip
        CURRENT_VYPER_IP=`ip addr show dev ppp0 | grep "inet" | sed  -E "s/[ ]+/ /" | cut -d" " -f3`;


        STATUS=`ip rule | grep "${CURRENT_VYPER_IP}"`
        if [ ! -z "${STATUS}" ]; then
                echo "rules are already there";
                return
        fi

        ip rule add from $CURRENT_VYPER_IP table 200
        ip rule add to   $CURRENT_VYPER_IP table 200

        ip route add default dev ppp0 table 200

        # because otherwise dante for some fucking reason will send dns requests through default network... we don't want that.
        ip route del 8.8.8.8/32
        ip route del 8.8.4.4/32
        ip route add 8.8.8.8/32 via $CURRENT_VYPER_IP
        ip route add 8.8.4.4/32 via $CURRENT_VYPER_IP

        echo "IP RULES ADDED:"
        ip rule
        echo "ROUTE:"
        ip route show
        echo "ROUTE TABLE 200:"
        ip route show table 200
}
add_rules

start_sockd(){
        STATUS=`/etc/init.d/sockd status | grep "Active:" | grep "running"`
        if [ ! -z "${STATUS}" ]; then
                echo "sockd is running";
                return
        fi

        /etc/init.d/sockd start
}
start_sockd
