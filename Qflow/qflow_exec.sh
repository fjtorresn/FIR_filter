#!/bin/tcsh -f
#-------------------------------------------
# qflow exec script for project /home/openvlsi/Desktop/Proyecto/Qflow
#-------------------------------------------

# /usr/local/share/qflow/scripts/synthesize.sh /home/openvlsi/Desktop/Proyecto/Qflow fir2n /home/openvlsi/Desktop/Proyecto/Qflow/source/fir2n.v || exit 1
# /usr/local/share/qflow/scripts/placement.sh -d /home/openvlsi/Desktop/Proyecto/Qflow fir2n || exit 1
# /usr/local/share/qflow/scripts/opentimer.sh  /home/openvlsi/Desktop/Proyecto/Qflow fir2n || exit 1
# /usr/local/share/qflow/scripts/vesta.sh -a /home/openvlsi/Desktop/Proyecto/Qflow fir2n || exit 1
# /usr/local/share/qflow/scripts/router.sh /home/openvlsi/Desktop/Proyecto/Qflow fir2n || exit 1
# /usr/local/share/qflow/scripts/opentimer.sh  -d /home/openvlsi/Desktop/Proyecto/Qflow fir2n || exit 1
# /usr/local/share/qflow/scripts/vesta.sh -a -d /home/openvlsi/Desktop/Proyecto/Qflow fir2n || exit 1
# /usr/local/share/qflow/scripts/migrate.sh /home/openvlsi/Desktop/Proyecto/Qflow fir2n || exit 1
/usr/local/share/qflow/scripts/drc.sh /home/openvlsi/Desktop/Proyecto/Qflow fir2n || exit 1
# /usr/local/share/qflow/scripts/lvs.sh /home/openvlsi/Desktop/Proyecto/Qflow fir2n || exit 1
# /usr/local/share/qflow/scripts/gdsii.sh /home/openvlsi/Desktop/Proyecto/Qflow fir2n || exit 1
# /usr/local/share/qflow/scripts/cleanup.sh /home/openvlsi/Desktop/Proyecto/Qflow fir2n || exit 1
# /usr/local/share/qflow/scripts/display.sh /home/openvlsi/Desktop/Proyecto/Qflow fir2n || exit 1
