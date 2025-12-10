# RealSense Serial Number & Installation Order Tool

This repository provides a **foolproof workflow** for working with Intel RealSense cameras:

1. Use a **Docker container** to read the camera serial number.
2. Label each physical camera with its serial number.
3. Use a **host-side script** to sort all serials from **smallest to largest** and get the **correct installation order** (Camera 1, Camera 2, etc.).

The goal is to make this process **as simple and robust as possible** for technicians and non-Linux experts.

---

## Contents

This repository contains:

- `Dockerfile`  
  Builds an Ubuntu 22.04–based image with `librealsense` (RSUSB backend) and a script that prints the correct RealSense **Serial Number** for the connected camera.

- `serial.sh`  
  Runs **inside** the Docker container.  
  It calls `rs-enumerate-devices`, extracts only the **main Serial Number** (not the ASIC serial), prints it, and exits.

- `order_realsense.sh`  
  Runs **on the host** (outside Docker).  
  It takes a list of serial numbers, sorts them from smallest to largest, and prints the **recommended installation order**.

---

## Requirements

- A Linux host machine (Ubuntu, Debian, etc. are ideal).
- **Docker installed**.
- Permission to run Docker with `sudo` (most common setup).
- USB access to plug in the RealSense cameras.
- Realsense camera must be connected to a USB-3 port 

---

## Quick Start

# 1) Clone this repository
git clone <YOUR_REPO_URL> realsense-serial-tool
cd realsense-serial-tool

# 2) Make the host-side script executable
chmod +x order_realsense.sh

# 3) Build the Docker image
sudo docker build -t realsense-serial .

# 4) For each camera (one at a time):
#    Plug in ONE camera → run:
sudo docker run --rm --device=/dev/bus/usb:/dev/bus/usb realsense-serial

#    Note the serial printed on screen and label the camera in real life.

# 5) After all cameras are labeled, get installation order:
./order_realsense.sh
#    Paste all serials (one per line), when you are done, press CTRL+D.
