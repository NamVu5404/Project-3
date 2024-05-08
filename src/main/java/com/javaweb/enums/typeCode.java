package com.javaweb.enums;

import java.util.HashMap;
import java.util.Map;

public enum typeCode {

    NOI_THAT("Nội thất"),
    TANG_TRET("Tầng trệt"),
    NGUYEN_CAN("Nguyên căn");

    private final String typeCodeName;

    typeCode(String typeCodeName) {
        this.typeCodeName = typeCodeName;
    }

    public String getTypeCodeName() {
        return typeCodeName;
    }

    public static Map<String, String> getTypeCode() {
        Map<String, String> typeCodes = new HashMap<String, String>();
        for (typeCode item : typeCode.values()) {
            typeCodes.put(item.toString(), item.getTypeCodeName());
        }
        return typeCodes;
    }

}
