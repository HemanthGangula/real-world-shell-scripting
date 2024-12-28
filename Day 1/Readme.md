# EC2 Backup Automation Script

## Challenge: Automate AWS EC2 Backup and Cleanup

### Scenario
You are responsible for maintaining backups of a critical EC2 instance. The goal is to automate the following tasks using a shell script:

- Create an AMI (Amazon Machine Image) of the EC2 instance
- Tag the AMI with a name and timestamp
- Log all actions into a file for auditing

### Requirements
- Use the AWS CLI to interact with your AWS account
- Implement error handling for failures in any step
- Log every operation (e.g., AMI creation, deletion) into a log file named `ec2_backup.log`

### Expected Features
- **Configuration:** Allow the instance ID and retention period (in days) to be configurable via variables
- **Automation:** No manual intervention; the script should handle everything
- **Logging:** Ensure all actions are logged, including timestamps

### Prerequisites
1. Install and configure the AWS CLI with appropriate IAM permissions to manage EC2 instances and create AMIs
2. Ensure your system has bash shell support
3. Active AWS account with EC2 instances running


### Installation & Usage
```bash
# Clone the repository
git clone <repository-url>

# Navigate to script directory
cd Day1

# Make script executable
chmod +x ec2_backup_script.sh

# Run the script
./ec2_backup_script.sh
```

### Script Overview
1. Lists all running EC2 instances with their names
2. Prompts the user to select an instance for backup
3. Creates an AMI of the selected instance
4. Tags the AMI with a name and timestamp
5. Logs the operation details in `ec2_backup.log`

#### For detailed explanation please refer 

### Notes
- This script is a prototype and should be customized as per your environment and requirements
- Test in a non-production environment before using it in production
