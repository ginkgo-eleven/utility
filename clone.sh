#!/usr/bin/env bash
args=$*
branch="eleven"
base_url="https://github.com/ginkgo-eleven"

function remove_hals() {
    echo "Removing existing hals (if present)"
    rm -rf hardware/qcom-caf/sm6125/media
    rm -rf hardware/qcom-caf/sm6125/display
    rm -rf hardware/qcom-caf/sm6125/audio
}

function remove_trees() {
    echo "Removing existing trees (if present)"
    rm -rf device/xiaomi/sm6125-common
    rm -rf device/xiaomi/ginkgo
    rm -rf vendor/xiaomi
    rm -rf kernel/xiaomi/sm6125
}

function clone_trees() {
    [[ "$args" =~ .*"--force".* ]] && remove_trees
    echo "======== Cloning Device Trees ========"
    # Git clone
    git clone $base_url/device_xiaomi_sm6125-common -b $branch device/xiaomi/sm6125-common
    git clone $base_url/device_xiaomi_ginkgo -b $branch device/xiaomi/ginkgo
    git clone $base_url/vendor_xiaomi -b $branch vendor/xiaomi
    git clone $base_url/kernel_xiaomi_sm6125 -b $branch kernel/xiaomi/sm6125
}

function clone_hals() {
    [[ "$args" =~ .*"--force".* ]] && remove_hals
    echo "======== Cloning hals ========"
    # Git clone
    git clone $base_url/hardware_qcom_display -b $branch hardware/qcom-caf/sm6125/display
    git clone $base_url/hardware_qcom_audio -b $branch hardware/qcom-caf/sm6125/audio
    git clone $base_url/hardware_qcom_media -b $branch hardware/qcom-caf/sm6125/media   
}

if [[ "$args" =~ .*"--remove-all-nexit".* ]];then
    remove_trees
    remove_hals
    exit 0
elif [[ "$args" =~ .*"--remove-trees-nexit".* ]];then
    remove_trees
    exit 0
elif [[ "$args" =~ .*"--remove-hals-nexit".* ]]; then
    remove_hals
    exit 0
fi

if [[ "$args" =~ .*"--clone-all".* ]];then
    clone_trees
    clone_hals
elif [[ "$args" =~ .*"--clone-trees".* ]]; then
    clone_trees
elif [[ "$args" =~ .*"--clone-hals".* ]]; then
    clone_hals
fi
