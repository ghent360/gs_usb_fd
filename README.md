# gs_usb_fd

A backport of the gs_usb driver from kernel v6 which supports CAN-FD, should compile on kernel 5.15 (tested Ubuntu 22.04). Renamed the name of the module, so it does not conflict with the standard distribution.

## Supported Devices

- Tested modified MKS UTC board with upgraded transciever chip (MCP2562FD).
- Tested custom STM32G0B1 boards with candlelight FW (https://github.com/ghent360/candleLight_fw/tree/test_g0)

## Building

1. Install the kernel sources for your platform:

Fedora:

```
sudo dnf install -y kernel-devel
```

Ubuntu:

```
sudo apt install kernel-headers-$(uname -r)
```

Raspbery Pi (raspbian):
```
sudo apt install raspberrypi-kernel-headers
```

2. Use `make` to build the driver

3. Installation part 1 (has to be done once)

Add the following to the end of /etc/modprobe.d/blacklist.conf. This would disable the old gs_usb module from loading.
```
# Doing work on gs_usb, blacklist the system one.
blacklist gs_usb
```
4. Installation part 2 (has to be every time the kernel is updated)

Rebuild the module:
```
make clean
make
sudo make install
sudo depmod
```

## DKMS integration
 * Install the dkms package for your distro
 * From within the git repository folder run
```
git archive --prefix=gs_usb_fd-1.0/ -o /tmp/gs_usb_fd-1.0.tar HEAD
```
 * switch to root shell (sudo -s)
 * change to the /usr/src folder and unpack the source archive
```
cd /usr/src
tar xvf /tmp/gs_usb_fd-1.0.tar
```
 * Run the following commands to add the module to the DKMS system:
```
dkms add -m gs_usb_fd -v 1.0 --verbose
dkms build -m gs_usb_fd -v 1.0 --verbose
dkms install -m gs_usb_fd -v 1.0 --verbose
```

## Credits

Thanks to Maximilian Schneider for authoring the original gs_usb driver.
