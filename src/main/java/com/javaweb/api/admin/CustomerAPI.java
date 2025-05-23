package com.javaweb.api.admin;

import com.javaweb.model.dto.AssignmentCustomerDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.impl.CustomerService;
import com.javaweb.service.impl.TransactionService;
import com.javaweb.service.impl.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/customers")
public class CustomerAPI {

    @Autowired
    private CustomerService customerService;

    @Autowired
    private UserService userService;
    @Autowired
    private TransactionService transactionService;

    @PostMapping
    public String addOrUpdateCustomer(@RequestBody CustomerDTO customerDTO) {
        boolean success = customerService.addOrUpdateCustomer(customerDTO);
        return success ? "Add Or Update Customer Success!" : "Add Or Update Customer Failed!";
    }

    @DeleteMapping("/{ids}")
    public String deleteBuilding(@PathVariable List<Long> ids) {
        boolean success = customerService.deleteCustomers(ids);
        return success ? "Delete Customers Success!" : "Delete Customer Failed!";
    }

    @GetMapping("/{id}/staffs")
    public ResponseDTO loadStaffs(@PathVariable Long id) {
        return userService.listStaffCustomer(id);
    }

    @PutMapping
    public void updateAssignmentCustomer(@RequestBody AssignmentCustomerDTO assignmentCustomerDTO) {
        customerService.updateAssignmentCustomer(assignmentCustomerDTO);
    }

    @GetMapping("/{id}/transaction-detail")
    public TransactionDTO loadTransactionDetail(@PathVariable Long id) {
        return transactionService.loadTransactionDetail(id);
    }

    @PostMapping("/transaction")
    public void addOrUpdateTransaction(@RequestBody TransactionDTO transactionDTO) {
        transactionService.addOrUpdateTransaction(transactionDTO);
    }
}
