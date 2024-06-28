package com.javaweb.service;

import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.response.TransactionResponse;

import java.util.List;

public interface ITransactionService {
    List<TransactionResponse> findByCodeAndCustomerId(String code, Long customerId);
    TransactionDTO loadTransactionDetail(Long id);
    void addOrUpdateTransaction(TransactionDTO transactionDTO);
}
