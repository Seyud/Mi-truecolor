device=$(getprop ro.product.device)
device_features="/product/etc/device_features/${device}.xml"
modpath_features="${MODPATH}/system/product/etc/device_features/${device}.xml"
END_STRING="<string-array name=\"dynamic_partition_list\">"

create_mod() {
    touch $modpath_features
    cp $device_features $modpath_features
}

tonic() {
    if grep -q "$SEARCH_STRING" "$FILE_PATH"; then
        # 如果存在，则替换
        sed -i "s/$SEARCH_STRING/$REPLACE_STRING/g" "$FILE_PATH"
    elif grep -q "$REPLACE_STRING" "$FILE_PATH"; then
        return
    else
        # 如果不存在，则追加
        sed -i "/$END_STRING/i $ADD_STRING_1\n$ADD_STRING_2" "$FILE_PATH"
    fi
}


truetone() {
    # 原色模式
    FILE_PATH="$modpath_features"
    SEARCH_STRING="<bool name=\"support_truetone\">false</bool>"
    REPLACE_STRING="<bool name=\"support_truetone\">true</bool>"
    ADD_STRING_1="\ \ \ \ <!--whether support truetone -->"
    ADD_STRING_2="\ \ \ \ <bool name=\"support_truetone\">true</bool>"
    tonic
}

true_color() {
    # 真彩显示
    FILE_PATH="$modpath_features"
    SEARCH_STRING="<bool name=\"support_true_color\">false</bool>"
    REPLACE_STRING="<bool name=\"support_true_color\">true</bool>"
    ADD_STRING_1="\ \ \ \ <!--whether support true color-->"
    ADD_STRING_2="\ \ \ \ <bool name=\"support_true_color\">true</bool>"
    tonic
}

create_mod
truetone
true_color



