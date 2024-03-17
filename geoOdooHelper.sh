#!/bin/bash

# Function to pull changes and restart
pull_then_restart() {
    if [[ "$1" == "-d" ]]; then
        # Docker container
        user_variable="$2"
        search_pattern="*$user_variable*"

        cd /home/devops/projects/$search_pattern || { echo "Error in changing to first directory."; exit 1; }
        cd addons/custom/$search_pattern || { echo "Error in changing to second directory."; exit 1; }
        git pull || { echo "Error pulling from git."; exit 1; }
        cd ../../../ || { echo "Error changing back to the first directory."; exit 1; }
        docker-compose restart || { echo "Error restarting docker-compose."; exit 1; }
        echo "Script executed successfully."
    elif [[ "$1" == "-l" ]]; then
        # Local
        pattern="*$2*conf*"
        filename=$(find /etc/ -type f -name "$pattern")

        if [ -z "$filename" ]; then
            echo -e "\n ** Error: No file matching pattern '$pattern' found in /etc/ \n"
            exit 1
        fi

        contents=$(cat "$filename")
        addons_path_line=$(echo "$contents" | grep -i "^addons_path")
        last_directory=$(echo "$addons_path_line" | awk -F'[,=]' '{print $NF}')
        
        cd "$last_directory" || { echo -e "\n** Error changing to repository or custome modules directory.\n"; exit 1; }
        echo -e "\n......\n Current directory: $(pwd) \n......\n"
        
        git pull || { echo -e "\n** Error while pulling (git pull).\n"; exit 1; }
        
        config_file=$(basename "$filename")
        service_name=${config_file%.conf}
        
        echo -e "\n\n service $service_name restart \n\n"
        service $service_name restart || { echo -e "\n** Error while restarting the service.\n"; exit 1; }
        
        echo -e "...... \n May executed successfully for $service_name \n......\n"
    else
        echo "Invalid option: $1"
        exit 1
    fi
}

# Function to display usage information
display_usage() {
    echo "Usage: $0 [option] [project_name]"
    echo "Options:"
    echo "  -h  Display this help message that you see now"
    echo "  -d  Pull for docker project"
    echo "  -l  Pull for local project"
    echo "Arguments:"
    echo "  project_name  or a pattern"
}

# Check if the user provided two arguments
if [ "$#" -ne 2 ]; then
    echo -e "\nUsage: $(basename "$0") <option> <filename or pattern>\n"
    exit 1
fi

# Parse command line options
while getopts ":hdl" option; do
    case "$option" in
        h)  # Display usage information
            display_usage
            exit 0
            ;;
        d)  # Pull for docker project
            pull_then_restart "$1" "$2"
            ;;
        l)  # Pull for local project
            pull_then_restart "$1" "$2"
            ;;
        \?) # Invalid option
            echo "Invalid option: -$OPTARG" >&2
            display_usage
            exit 1
            ;;
    esac
done
