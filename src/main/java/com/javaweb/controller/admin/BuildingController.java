package com.javaweb.controller.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.enums.districtCode;
import com.javaweb.enums.typeCode;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.service.IBuildingService;
import com.javaweb.service.IUserService;
import com.javaweb.utils.DisplayTagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController(value = "buildingControllerOfAdmin")
public class BuildingController {

    @Autowired
    private IBuildingService buildingService;

    @Autowired
    private IUserService userService;

    @GetMapping(value = "/admin/building-list")
    public ModelAndView buildingList(@ModelAttribute(SystemConstant.MODEL) BuildingSearchRequest model, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/building/list");
        DisplayTagUtils.of(request, model);

        List<BuildingSearchResponse> buildings = buildingService.findAll(model, PageRequest.of(model.getPage() - 1, model.getMaxPageItems()));
        model.setListResult(buildings);
        model.setTotalItems(buildingService.countTotalItem(model));

        mav.addObject("staffs", userService.getStaffs());
        mav.addObject("district", districtCode.district());
        mav.addObject("typeCodes", typeCode.getTypeCode());
        mav.addObject(SystemConstant.MODEL, model);

        return mav;
    }

    @GetMapping(value = "/admin/building-edit")
    public ModelAndView buildingAdd(@ModelAttribute(SystemConstant.MODEL) BuildingDTO model) {
        ModelAndView mav = new ModelAndView("admin/building/edit");
        mav.addObject("district", districtCode.district());
        mav.addObject("typeCodes", typeCode.getTypeCode());

        return mav;
    }

    @GetMapping(value = "/admin/building-edit-{id}")
    public ModelAndView buildingEdit(@PathVariable Long id) {
        ModelAndView mav = new ModelAndView("admin/building/edit");
        mav.addObject("district", districtCode.district());
        mav.addObject("typeCodes", typeCode.getTypeCode());
        mav.addObject(SystemConstant.MODEL, buildingService.findById(id));

        return mav;
    }

}