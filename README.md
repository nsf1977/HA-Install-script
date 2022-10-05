Hass.io Installer for S9xx box running Armbian (not for S905X2)
This script is largely based on Dale Higgs' <@dale3h> work. (almost a total copy, just changing the architecture) This script will install all requirements, and then install Hass.io. Please report any [issues][issues] that experience.

Requirements
S9xx TV BOX
ARMBIAN (Debian Stretch)
Installation Instructions
Flash the latest ARMBIAN stretch image.
Run this as root user:
curl -sL https://raw.githubusercontent.com/MadDoct/hassio-installer/master/hassio_s905armbian | bash -s
Known Issues
SSH server add-on (from Official add-ons) does not work

Fix: use community SSH add-on instead
Port conflict when using SSH add-on

Fix: change the port in the SSH add-on options
License
MIT License

Copyright (c) 2018 MadDoct and Dale Higgs <@dale3h>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Footer
© 2022 GitHub, Inc.
Footer navigation
Terms
Privacy
