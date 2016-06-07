#!/bin/bash
# Marathon servers to use:
serverlist=(
	"control.demo.aws.mrsmiggins.net"
	"control.metapod.mrsmiggins.net"
)

# Username
username="admin"

# Password (get from input)
echo 'Enter password:'
read -sr password


for server in ${serverlist[@]}; do
	echo "Deploying to $server";
	output=$(curl -k -X POST -H "Content-Type: application/json" https://$username:$password@$server:8080/v2/apps -d@mrsmiggins.json 2>/dev/null)
	if [[ $output == *"already exists"* ]]; then
		echo "Failed - application already exists"
	else
		echo "Done";
	fi
done
