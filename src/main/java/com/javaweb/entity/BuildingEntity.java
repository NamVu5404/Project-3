package com.javaweb.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "building")
@Getter
@Setter
public class BuildingEntity extends BaseEntity {
    @Column(name = "name")
    private String name;

    @Column(name = "ward")
    private String ward;

    @Column(name = "street")
    private String street;

    @Column(name = "district")
    private String district;

    @Column(name = "numberofbasement")
    private Long numberOfBasement;

    @Column(name = "managername")
    private String managerName;

    @Column(name = "managerphone")
    private String managerPhone;

    @Column(name = "floorarea")
    private Long floorArea;

    @Column(name = "rentprice")
    private Long rentPrice;

    @Column(name = "brokeragefee")
    private Double brokerageFee;

    @Column(name = "servicefee")
    private String serviceFee;

    @Column(name = "level")
    private String level;

    @Column(name = "overtimefee")
    private String overtimeFee;

    @Column(name = "waterfee")
    private String waterFee;

    @Column(name = "electricityfee")
    private String electricityFee;

    @Column(name = "deposit")
    private String deposit;

    @Column(name = "payment")
    private String payment;

    @Column(name = "renttime")
    private String rentTime;

    @Column(name = "decorationtime")
    private String decorationTime;

    @Column(name = "rentpricedescription")
    private String rentPriceDescription;

    @Column(name = "carfee")
    private String carFee;

    @Column(name = "motofee")
    private String motoFee;

    @Column(name = "structure")
    private String structure;

    @Column(name = "direction")
    private String direction;

    @Column(name = "note")
    private String note;

    @Column(name = "type")
    private String typeCode;

    @Column(name = "avatar")
    private String avatar;

    @OneToMany(mappedBy = "building", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<RentAreaEntity> rentAreas = new ArrayList<>();

    @ManyToMany
    @JoinTable(name = "assignmentbuilding",
            joinColumns = @JoinColumn(name = "buildingid"),
            inverseJoinColumns = @JoinColumn(name = "staffid"))
    private List<UserEntity> staffs = new ArrayList<>();

}