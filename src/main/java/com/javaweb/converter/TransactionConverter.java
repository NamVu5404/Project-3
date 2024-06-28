package com.javaweb.converter;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.TransactionEntity;
import com.javaweb.exception.MyException;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.response.TransactionResponse;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.repository.TransactionRepository;
import com.javaweb.repository.UserRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TransactionConverter {
    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TransactionRepository transactionRepository;

    public TransactionDTO convertToDto(TransactionEntity transactionEntity) {
        TransactionDTO transactionDTO = modelMapper.map(transactionEntity, TransactionDTO.class);
        transactionDTO.setCustomerId(transactionEntity.getCustomer().getId());
        return transactionDTO;
    }

    public TransactionEntity convertToEntity(TransactionDTO transactionDTO) {
        TransactionEntity transactionEntity = modelMapper.map(transactionDTO, TransactionEntity.class);
        CustomerEntity customerEntity = customerRepository.findById(transactionDTO.getCustomerId())
                .orElseThrow(() -> new MyException("Customer not found"));
        transactionEntity.setCustomer(customerEntity);
        Long id = transactionDTO.getId();

        if (id != null) {
            TransactionEntity transaction = transactionRepository.findById(id)
                    .orElseThrow(() -> new MyException("Transaction not found"));
            transactionEntity.setCreatedBy(transaction.getCreatedBy());
            transactionEntity.setCreatedDate(transaction.getCreatedDate());
            transactionEntity.setModifiedBy(transaction.getModifiedBy());
            transactionEntity.setModifiedDate(transaction.getModifiedDate());
        }

        return transactionEntity;
    }

    public TransactionResponse convertToResponse(TransactionEntity transactionEntity) {
        TransactionResponse transactionResponse = modelMapper.map(transactionEntity, TransactionResponse.class);
        transactionResponse.setCreatedBy(userRepository.findByUserName(transactionEntity.getCreatedBy()).getFullName());
        transactionResponse.setModifiedBy(userRepository.findByUserName(transactionEntity.getModifiedBy()).getFullName());

        if (transactionEntity.getCreatedDate().equals(transactionEntity.getModifiedDate())) {
            transactionResponse.setModifiedBy(null);
            transactionResponse.setModifiedDate(null);
        }

        return transactionResponse;
    }
}
