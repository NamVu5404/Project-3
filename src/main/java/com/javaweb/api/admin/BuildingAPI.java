package com.javaweb.api.admin;

import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.IBuildingService;
import com.javaweb.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/buildings")
public class BuildingAPI {

    @Autowired
    private IBuildingService buildingService;

    @Autowired
    private IUserService userService;

    @PostMapping
    public String addOrUpdateBuilding(@RequestBody BuildingDTO buildingDTO) {
        buildingService.addOrUpdateBuilding(buildingDTO);
        return new String("Add Or Update Building Success!");
    }

    @DeleteMapping("/{ids}")
    public String deleteBuilding(@PathVariable List<Long> ids) {
        buildingService.deleteBuilding(ids);
        return new String("Delete Building Success!");
    }

    @GetMapping("/{id}/staffs")
    public ResponseDTO loadStaffs(@PathVariable Long id) {
        return userService.listStaffBuilding(id);
    }

    @PutMapping
    public void updateAssignmentBuilding(@RequestBody AssignmentBuildingDTO assignmentBuildingDTO) {
        buildingService.updateAssignmentBuilding(assignmentBuildingDTO);
    }

}