#!/vendor/bin/sh

chmod 0666 /dev/kmsg 2>/dev/null
chmod 0666 /dev/qseecom
chmod 0666 /dev/dma_heap/qcom,qseecom
chmod 0666 /dev/dma_heap/qcom,qseecom-ta

#Battery
setprop ro.boot.hardware.health.allow_battery_read true
/vendor/bin/hw/android.hardware.health-service.qti &

#decrypt plz!!!
/vendor/bin/qseecomd &
sleep 0.5

/vendor/bin/hw/android.hardware.gatekeeper@1.0-service-qti &
sleep 2

/vendor/bin/hw/android.hardware.security.keymint-service-qti &