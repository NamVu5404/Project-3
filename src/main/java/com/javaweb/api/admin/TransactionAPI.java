package com.javaweb.api.admin;

import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.service.ITransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/transactions")
public class TransactionAPI {
    @Autowired
    private ITransactionService transactionService;

    @GetMapping("/{id}")
    public TransactionDTO loadTransactionDetail(@PathVariable Long id) {
        return transactionService.loadTransactionDetail(id);
    }

    @PostMapping
    public void addOrUpdateTransaction(@RequestBody TransactionDTO transactionDTO) {
        transactionService.addOrUpdateTransaction(transactionDTO);
    }
}
