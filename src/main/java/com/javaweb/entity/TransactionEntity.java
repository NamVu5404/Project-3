package com.javaweb.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "transaction")
@Getter
@Setter
public class TransactionEntity extends BaseEntity {
    @Column(name = "code")
    private String code;

    @Column(name = "note")
    private String note;

    @ManyToOne
    @JoinColumn(name = "customerid")
    private CustomerEntity customer;

    @Column(name = "staffid")
    private Long staffId;
}
