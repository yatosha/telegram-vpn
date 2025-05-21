# Telegram MTProto Proxy Setup Utility

This project provides a Bash script to set up and manage a Telegram MTProto Proxy using Docker. The proxy helps users bypass censorship and access Telegram securely and reliably.

## Features

- **Simple installation** and uninstallation via an interactive menu.
- **Automatic Docker installation** if it is not already installed.
- **Random secret key generation** for enhanced security.
- **Configuration summary** saved to a file for easy reference.
- **Compatible with Debian-based Linux distributions**.

## Requirements

Before using this script, ensure you have the following:

- A Debian-based Linux system (e.g., Ubuntu).
- `curl`, `openssl`, `grep`, and `docker`. The script will install these dependencies if they are missing.
- Root or sudo privileges to execute the script.

## Quick Start

To quickly set up the proxy, run the following command:

```bash
curl -s https://raw.githubusercontent.com/yatosha/telegram-vpn/main/mtproto.sh | sudo bash
```

This command will download and execute the script directly.

## Usage

You can use the script in one of the following ways:

1. **Quick Start**:
   ```bash
   curl -s https://raw.githubusercontent.com/yatosha/telegram-vpn/main/mtproto.sh | sudo bash
   ```

2. **Manual Method**:
   - Clone or download this repository.
   - Run the script:
     ```bash
     sudo bash mtproto.sh
     ```

3. Follow the interactive menu to install or uninstall the MTProto Proxy.

After installation, the script will display your proxy configuration (IP, port, secret key, etc.) and save it to `mtproto_config.txt`.

## Uninstall

To remove the proxy and its Docker image, rerun the script and select the uninstall option. This will clean up all related resources.

## Notes

- The proxy listens on port **443** by default.
- Ensure your firewall allows incoming connections on the chosen port.

## License

This project is licensed under the MIT License.
