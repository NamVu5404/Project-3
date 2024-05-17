package com.javaweb.service.impl;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.exception.MyException;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.repository.BuildingRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.service.IAssignmentBuildingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AssignmentBuildingService implements IAssignmentBuildingService {

    @Autowired
    private BuildingRepository buildingRepository;

    @Autowired
    private UserRepository userRepository;

    @Transactional
    @Override
    public void updateAssignmentBuilding(AssignmentBuildingDTO assignmentBuildingDTO) {
        BuildingEntity building = buildingRepository.findById(assignmentBuildingDTO.getBuildingId())
                .orElseThrow(() -> new MyException("Building Not Found"));

        building.getStaffs().clear();;
        buildingRepository.save(building);

        List<UserEntity> staffs = userRepository.findAllById(assignmentBuildingDTO.getStaffs());
        building.setStaffs(staffs);

        buildingRepository.save(building);
    }
}
