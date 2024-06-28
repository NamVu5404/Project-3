package com.javaweb.enums;

import java.util.LinkedHashMap;
import java.util.Map;

public enum TransactionType {
    CSKH("Chăm sóc khách hàng"),
    DDX("Dẫn đi xem"),
    DDA("Dẫn đi ăn");

    private final String name;

    TransactionType(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public static Map<String, String> transactionType() {
        Map<String, String> transactionTypes = new LinkedHashMap<>();
        for (TransactionType item : TransactionType.values()) {
            transactionTypes.put(item.toString(), item.getName());
        }
        return transactionTypes;
    }
}
