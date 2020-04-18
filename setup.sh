#!/bin/bash

#Get path to script
SP="$(dirname ${BASH_SOURCE[0]})"

# check the device tree overlay is setup correctly ...
# firstly disable PWM audio
sudo bash -c "sed -i \"s/^\s*dtparam=audio/#dtparam=audio/\" /boot/config.txt"
# now check to see the correct device tree overlay is loaded ...
cnt=`grep -c audioinjector-wm8731-audio /boot/config.txt`
if [ "$cnt" -eq "0" ]; then
	sudo bash -c "echo '# enable the AudioInjector.net sound card
	dtoverlay=audioinjector-wm8731-audio' >> /boot/config.txt"
fi

sudo mkdir -p /usr/share/doc/audioInjector/
sudo mv $SP/*.test /usr/share/doc/audioInjector/

echo The audio injector sound card is now setup.
echo Please reboot to enable the correct device tree.
echo

