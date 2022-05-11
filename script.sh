#!/bin/bash

recursiv() {
        local fisiere=$(ls -lh | awk '{print $9}')

        declare -a fis=()
        declare -a dir=()

        for item in $fisiere; do
                if [ -f $item ]; then
                        fis+=($item)
                elif [ -d $item ]; then
                        dir+=($item)
                fi
        done

        for i in ${!fis[@]}; do
                local size=$(ls -lh ${fis[$i]} | awk '{print $5}')
                if [ $size -eq 0 ]; then
                        rm ${fis[$i]}
                fi
        done

        for j in ${!dir[@]}; do
                cd ${dir[$j]}
                unset fis
                recursiv
                cd ..
                if [ ! $(ls -A ${dir[$j]}) ]; then
                        rm -rf ${dir[$j]}
                fi
        done
}

recursiv
