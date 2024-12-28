###############################################################################
# Script Name: ec2-backup.sh                                                  #
# Description: Creates and tags AMI backups of selected EC2 instances         #
# Author: Hemanth Gangula                                                     #
# Created Date: 2024-12-28                                                    #
# Dependencies: AWS CLI, valid AWS credentials                                #
# For detailed instructions, see README.md                                    #
###############################################################################

#!/bin/bash

# Retrieve and display available running EC2 instances
CURRENT_REGION=$(aws configure get region)

echo "Retrieving active instances in region: $CURRENT_REGION..."

mapfile -t instances < <(aws ec2 describe-instances \
    --filters "Name=instance-state-name,Values=running" \
    --query 'Reservations[].Instances[].{ID:InstanceId, Name:Tags[?Key==`Name`].Value | [0]}' \
    --output text)

if [ ${#instances[@]} -eq 0 ]; then
    echo "Sorry No active instances found in region: $CURRENT_REGION"
    exit 1
fi

# Display instances with numbers
for i in "${!instances[@]}"; do
    echo "$((i + 1)). ${instances[i]//\\t/ - }"
done

# Check if any instances are available
if [ ${#instances[@]} -eq 0 ]; then
    echo "No active instances found."
    exit 1
fi

# Prompt user to select an instance
read -p "Select the instance number: " selection

# Validate selection
if [[ "$selection" -ge 1 && "$selection" -le "${#instances[@]}" ]]; then
    INSTANCE_ID=$(echo "${instances[$((selection-1))]}" | awk '{print $1}')
    INSTANCE_NAME=$(echo "${instances[$((selection-1))]}" | awk '{print $2}')
    echo "Selected Instance ID: $INSTANCE_ID (${INSTANCE_NAME:-No Name Tag})"
else
    echo "Invalid selection."
    exit 1
fi

# Create AMI of the selected instance
echo "Creating AMI for instance $INSTANCE_ID..."
AMI_NAME="${INSTANCE_ID}-backup-$(date +%Y%m%d%H%M%S)"
IMAGE_ID=$(aws ec2 create-image \
    --instance-id "$INSTANCE_ID" \
    --name "$AMI_NAME" \
    --no-reboot \
    --output text \
    --query 'ImageId')

# Check if AMI creation succeeded
if [[ -z "$IMAGE_ID" ]]; then
    echo "Failed to create AMI for instance $INSTANCE_ID."
    exit 1
fi

# Tag the AMI
echo "Tagging AMI $IMAGE_ID..."
aws ec2 create-tags --resources "$IMAGE_ID" --tags Key=Name,Value="$AMI_NAME" Key=Timestamp,Value="$(date)"
if [[ $? -ne 0 ]]; then
    echo "Failed to tag AMI $IMAGE_ID."
    exit 1
fi

echo "AMI $IMAGE_ID created successfully with name: $AMI_NAME"

# Log the operation
LOG_ENTRY="$(date): Created AMI $IMAGE_ID for instance $INSTANCE_ID (${INSTANCE_NAME:-No Name Tag})"
echo "$LOG_ENTRY" >> ec2_backup.log
echo "$LOG_ENTRY"
echo "Backup process complete. Details logged in ec2_backup.log."
