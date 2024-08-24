# Sorbbet

A robust storage management system with a Flask-based WebGUI for easy configuration and monitoring.

## Features

- **Disk and File Management**: Handles file migration, snapshot creation, and directory monitoring.
- **WebGUI**: Interactive web interface for managing storage operations.
- **Real-Time Parity and Recovery**: Ensures data integrity and recovery from failures.

## Installation

### Prerequisites

- Debian-based Linux distribution
- Root or sudo privileges

### Steps

1. **Clone the Repository**
    ```bash
    git clone https://github.com/yourusername/sorbbet.git
    cd sorbbet
    ```

2. **Run the Installation Script**
    ```bash
    sudo bash scripts/install.sh
    ```

3. **Access the WebGUI**
    Open your web browser and navigate to `http://localhost` to access the WebGUI.

## Usage

- **File Migration**: Use the `/migrate` endpoint to migrate files.
- **Snapshot Creation**: Use the `/snapshot` endpoint to create snapshots of files.
- **Status**: Check the `/status` endpoint for current system status.

## Contributing

Feel free to submit issues or pull requests to improve the project.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
