package com.javaweb.converter;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.exception.MyException;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.repository.CustomerRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CustomerConverter {
    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private CustomerRepository customerRepository;

    public CustomerEntity convertToEntity(CustomerDTO customerDTO) {
        CustomerEntity customerEntity = modelMapper.map(customerDTO, CustomerEntity.class);
        customerEntity.setIsActive((byte) 1);
        Long customerId = customerDTO.getId();

        if (customerId != null) {
            CustomerEntity customer = customerRepository.findById(customerId)
                    .orElseThrow(() -> new MyException("Customer not found"));
            customerEntity.setUsers(customer.getUsers());
            customerEntity.setCreatedBy(customer.getCreatedBy());
            customerEntity.setCreatedDate(customer.getCreatedDate());
            customerEntity.setTransactionTypes(customer.getTransactionTypes());
        }

        return customerEntity;
    }
}
