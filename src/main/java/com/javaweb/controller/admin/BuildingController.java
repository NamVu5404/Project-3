package com.javaweb.controller.admin;

import com.javaweb.enums.districtCode;
import com.javaweb.enums.typeCode;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.service.IBuildingService;
import com.javaweb.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController(value = "buildingControllerOfAdmin")
public class BuildingController {

    @Autowired
    private IBuildingService buildingService;

    @Autowired
    private IUserService userService;

    @GetMapping(value = "/admin/building-list")
    public ModelAndView buildingList(@ModelAttribute("modelSearch") BuildingSearchRequest buildingSearchRequest) {
        ModelAndView mav = new ModelAndView("admin/building/list");
        mav.addObject("staffs", userService.getStaffs());
        mav.addObject("district", districtCode.district());
        mav.addObject("typeCodes", typeCode.getTypeCode());
        List<BuildingSearchResponse> buildings = buildingService.findAll(buildingSearchRequest);
        mav.addObject("buildings", buildings);
        return mav;
    }

    @GetMapping(value = "/admin/building-edit")
    public ModelAndView buildingAdd(@ModelAttribute("buildingEdit") BuildingDTO buildingDTO) {
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
        // findBuildingById
        BuildingDTO buildingDTO = buildingService.findById(id);
        mav.addObject("buildingEdit", buildingDTO);
        return mav;
    }

}