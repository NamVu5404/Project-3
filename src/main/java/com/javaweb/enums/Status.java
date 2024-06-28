package com.javaweb.enums;

import java.util.LinkedHashMap;
import java.util.Map;

public enum Status {
    CHUA_XU_LY("Chưa xử lý"),
    DANG_XU_LY("Đang xử lý"),
    DA_XU_LY("Đã xử lý");

    private final String statusName;

    Status(String statusName) {
        this.statusName = statusName;
    }

    public String getStatusName() {
        return statusName;
    }

    public static Map<String, String> type() {
        Map<String, String> listTypes = new LinkedHashMap<>();
        for (Status item : Status.values()) {
            listTypes.put(item.getStatusName(), item.getStatusName());
        }
        return listTypes;
    }
}
