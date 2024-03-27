Certainly! Below is a **sample README file** for your script. You can customize it further based on your specific project details:

---

# EC2 Nexus Configuration Script

This Bash script automates the setup and configuration of an EC2 instance for running the Nexus repository manager. It performs the following tasks:

1. **Changing the Hostname**:
   - Sets the hostname of the EC2 instance to "nexus."

2. **Updating and Upgrading Ubuntu**:
   - Updates package information and upgrades installed packages.

3. **Creating a User Named "nexus"**:
   - Adds a new user called "nexus" to manage Nexus services.
   - Grants sudo access to the "nexus" user (avoid running Nexus as root).

4. **Installing Java and Nexus**:
   - Installs OpenJDK 8.
   - Downloads and extracts the Nexus repository manager.
   - Renames the extracted directory to "nexus."
   - Adjusts ownership of Nexus and sonatype-work directories.

5. **Configuring Nexus**:
   - Adds the "nexus" user to the Nexus.rc file.
   - Creates a systemd service unit for Nexus.
   - Starts the Nexus service.

## Usage

1. Clone this repository to your EC2 instance.
2. Make the script executable: `sudo bash Nexus_install_script.sh`
3. Run the script: `sudo ./Nexus_install_script.sh`

## Author

- **Paul Amoah**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
Thanks to chriscloudz for collaborating on this project with me

