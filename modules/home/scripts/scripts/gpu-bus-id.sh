#!/usr/bin/env bash

get_bus_id() {
    vendor="$1"
    case "$vendor" in
        intel)
            gpu=$(lspci | grep -i 'vga' | grep -i 'intel')
            ;;
        nvidia)
            gpu=$(lspci | grep -i 'nvidia')
            ;;
        amd)
            gpu=$(lspci | grep -i 'amd/ati')
            ;;
        *)
            echo "Unknown vendor"
            return 1
            ;;
    esac

    bus_id=$(echo "$gpu" | awk '{print $1}')
    IFS=':.' read -r bus slot func <<< "$bus_id"

    if [[ ! -z $bus ]]; then
        bus_dec=$((16#$bus))
        if [[ ! -z $slot ]]; then
            slot_dec=$((16#$slot))
            echo "PCI:$bus_dec:$slot_dec:$func"
        fi
    fi
}

echo -e "{"
echo -e "  intelBusId = \"$(get_bus_id intel)\";"
echo -e "  nvidiaBusId = \"$(get_bus_id nvidia)\";"
echo -e "  amdgpuBusId = \"$(get_bus_id amd)\";"
echo -e "}"