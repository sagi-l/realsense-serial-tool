FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install only the minimum required dependencies for RSUSB backend
RUN apt-get update && \
    apt-get install -y \
        git \
        cmake \
        build-essential \
        libusb-1.0-0-dev \
        pkg-config \
        udev \
        usbutils && \
    rm -rf /var/lib/apt/lists/*

# Build librealsense with RSUSB backend only
RUN git clone https://github.com/IntelRealSense/librealsense.git /librealsense && \
    cd /librealsense && \
    mkdir build && cd build && \
    cmake ../ \
        -DFORCE_RSUSB_BACKEND=true \
        -DBUILD_EXAMPLES=false \
        -DBUILD_GRAPHICAL_EXAMPLES=false && \
    make -j$(nproc) && \
    make install

# Force RSUSB backend at runtime
ENV RS2_USB_BACKEND=libusb


# Copy your working serial script
COPY serial.sh /usr/local/bin/serial.sh
RUN chmod +x /usr/local/bin/serial.sh

# Run script automatically when container starts
CMD ["/usr/local/bin/serial.sh"]
