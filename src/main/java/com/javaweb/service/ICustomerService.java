package com.javaweb.service;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.model.dto.AssignmentCustomerDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.request.CustomerSearchRequest;

import java.util.List;

public interface ICustomerService {
    List<CustomerEntity> findAll(CustomerSearchRequest customerSearchRequest);
    int countTotalItem(CustomerSearchRequest customerSearchRequest);
    CustomerEntity findById(Long id);
    boolean addOrUpdateCustomer(CustomerDTO customerDTO);
    boolean deleteCustomers(List<Long> ids);
    void updateAssignmentCustomer(AssignmentCustomerDTO assignmentCustomerDTO);
}
