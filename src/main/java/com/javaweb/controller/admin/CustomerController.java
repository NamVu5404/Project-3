package com.javaweb.controller.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.enums.Status;
import com.javaweb.enums.TransactionType;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.request.CustomerSearchRequest;
import com.javaweb.model.response.TransactionResponse;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.ICustomerService;
import com.javaweb.service.ITransactionService;
import com.javaweb.service.IUserService;
import com.javaweb.utils.DisplayTagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RestController(value = "customerControllerOfAdmin")
public class CustomerController {

    @Autowired
    private IUserService userService;

    @Autowired
    private ICustomerService customerService;

    @Autowired
    private ITransactionService transactionService;

    @GetMapping(value = "/admin/customer-list")
    public ModelAndView customerList(@ModelAttribute(SystemConstant.MODEL) CustomerSearchRequest model, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/customer/list");
        DisplayTagUtils.of(request, model);

        if (SecurityUtils.getAuthorities().contains("ROLE_STAFF")) {
            Long staffId = SecurityUtils.getPrincipal().getId();
            model.setStaffId(staffId);
        }
        List<CustomerEntity> customers = customerService.findAll(model);
        model.setListResult(customers);
        model.setTotalItems(customerService.countTotalItem(model));

        mav.addObject("staffs", userService.getStaffs());
        mav.addObject("status", Status.type());
        mav.addObject(SystemConstant.MODEL, model);

        return mav;
    }

    @GetMapping(value = "/admin/customer-edit")
    public ModelAndView customerAdd(@ModelAttribute(SystemConstant.MODEL) CustomerDTO model) {
        ModelAndView mav = new ModelAndView("admin/customer/edit");
        mav.addObject("status", Status.type());

        return mav;
    }

    @GetMapping(value = "/admin/customer-edit-{id}")
    public ModelAndView customerEdit(@PathVariable Long id) {
        Long staffId = SecurityUtils.getPrincipal().getId();
        CustomerEntity customer = customerService.findById(id);
        List<Long> staffIds = customer.getUsers().stream().map(UserEntity::getId).collect(Collectors.toList());
        // add manager id
        if (SecurityUtils.getAuthorities().contains("ROLE_MANAGER")) {
            Long managerId = SecurityUtils.getPrincipal().getId();
            staffIds.add(managerId);
        }

        if (customer.getIsActive() == 1 && staffIds.contains(staffId)) {
            ModelAndView mav = new ModelAndView("admin/customer/edit");
            List<TransactionResponse> listCSKH = transactionService.findByCodeAndCustomerId("CSKH", id);
            List<TransactionResponse> listDDX = transactionService.findByCodeAndCustomerId("DDX", id);

            mav.addObject("status", Status.type());
            mav.addObject(SystemConstant.MODEL, customerService.findById(id));
            mav.addObject("transactionType", TransactionType.transactionType());
            mav.addObject("transactionListCSKH", listCSKH);
            mav.addObject("transactionListDDX", listDDX);

            return mav;
        } else {
            throw new AccessDeniedException("Bạn không có quyền truy cập thông tin khách hàng này!");
        }
    }
}
