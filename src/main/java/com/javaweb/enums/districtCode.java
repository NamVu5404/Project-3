package com.javaweb.enums;

import java.util.HashMap;
import java.util.Map;

public enum districtCode {

    QUAN_1("Quận 1"),
    QUAN_2("Quận 2"),
    QUAN_3("Quận 3"),
    QUAN_4("Quận 4"),
    QUAN_5("Quận 5");

    private final String districtName;

    districtCode(String districtName) {
        this.districtName = districtName;
    }

    public String getDistrictName() {
        return districtName;
    }

    public static Map<String, String> district() {
        Map<String, String> listDistrict = new HashMap<String, String>();
        for(districtCode item : districtCode.values()) {
            listDistrict.put(item.toString(), item.getDistrictName());
        }
        return listDistrict;
    }

}