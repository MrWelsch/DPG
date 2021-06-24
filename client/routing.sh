#!/bin/sh

# Flush selected interface
ip addr flush dev eth0

# Set up IP for selected interface
ip addr add $IP_CONTAINER dev eth0

# Guarantees that the bridge container can start before
# executing the route command
sleep 15

# If-clause which enables the user to leave the IP_ROUTER and ROUTE_TO variable
# unconfigured in docker-compose.yml.
if [ -z "$ROUTING_A" ]
# Output something.
then
    echo "not defined"
# If set, iterate over each and execute the specified commands.
else
    printenv | grep ROUTING_ |
    while IFS= read -r i; do
        # String = ROUTING_X=10.1.0.3/16,10.2.0.0/16
        # Goal = 10.1.0.3/16,10.2.0.0/16
        # {i%,*} = Remove Prefix ending with '='
        routing=${i#*=}
 
        # String = 10.1.0.3/16,10.2.0.0/16
        # Goal = 10.1.0.3/16
        # {i%,*} = Remove Suffix starting with ','
        router=${routing%,*}
 
        # String = 10.1.0.3/16
        # Goal = 10.1.0.3
        # %%/* = Remove Suffix starting with first '/'
        ip_router=${router%%/*}
 
        # String = 10.1.0.3/16,10.2.0.0/16
        # Goal = 10.2.0.0/16
        # {i#,*} = Remove Prefix ending in ','
        ip_network=${routing#*,}
 
        # Routing to Bridge 
        ip route add "$router" dev eth0
        # Routing to Network B  
        ip route add "$ip_network" via "$ip_router"
    done
fi

