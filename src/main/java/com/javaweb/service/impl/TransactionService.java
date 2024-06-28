package com.javaweb.service.impl;

import com.javaweb.converter.TransactionConverter;
import com.javaweb.entity.TransactionEntity;
import com.javaweb.exception.MyException;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.response.TransactionResponse;
import com.javaweb.repository.TransactionRepository;
import com.javaweb.service.ITransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TransactionService implements ITransactionService {
    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private TransactionConverter transactionConverter;

    @Override
    public List<TransactionResponse> findByCodeAndCustomerId(String code, Long customerId) {
        List<TransactionEntity> transactions = transactionRepository.findByCodeAndCustomerId(code, customerId);
        return transactions.stream().map(transaction ->
                transactionConverter.convertToResponse(transaction)
        ).collect(Collectors.toList());
    }

    @Override
    public TransactionDTO loadTransactionDetail(Long id) {
        return transactionConverter.convertToDto(transactionRepository.findById(id)
                .orElseThrow(() -> new MyException("Transaction not found")));
    }

    @Override
    public void addOrUpdateTransaction(TransactionDTO transactionDTO) {
        TransactionEntity transactionEntity = transactionConverter.convertToEntity(transactionDTO);
        transactionRepository.save(transactionEntity);
    }
}
