# Telegram MTProto Proxy Setup Utility

This project provides a simple Bash script to install and manage a Telegram MTProto Proxy using Docker. The proxy allows users to bypass censorship and access Telegram securely.

## Features

- **Easy installation** and uninstallation via interactive menu
- **Automatic Docker installation** if not present
- **Random secret key generation** for security
- **Configuration summary** saved to a file
- **Works on Debian-based Linux distributions**

## Requirements

- Debian-based Linux system (e.g., Ubuntu)
- `curl`, `openssl`, `grep`, and `docker` (installed automatically if missing)
- Root or sudo privileges

## Quick Start

Run this command to download and execute the script directly:

```bash
curl -s https://raw.githubusercontent.com/yatosha/telegram-vpn/main/mtproto.sh | sudo bash
```

## Usage

You can use the script in one of the following ways:

1. **Direct execution** (quick start):
   ```bash
   curl -s https://raw.githubusercontent.com/yatosha/telegram-vpn/main/mtproto.sh | sudo bash
   ```

2. **Manual download and execution**:
   - **Clone or download** this repository.
   - **Run the script:**
     ```bash
     sudo bash mtproto.sh
     ```

3. **Follow the interactive menu** to install or uninstall the MTProto Proxy.

After installation, the script will display and save your proxy configuration (IP, port, secret key, etc.) in `mtproto_config.txt`.

## Uninstall

To remove the proxy and its Docker image, rerun the script and select the uninstall option.

## Notes

- The proxy listens on port **443** by default.
- Make sure your firewall allows incoming connections on the chosen port.

## License

MIT License
