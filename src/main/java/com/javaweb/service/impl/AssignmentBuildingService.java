package com.javaweb.service.impl;

import com.javaweb.entity.AssignmentBuildingEntity;
import com.javaweb.exception.MyException;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.repository.AssignmentBuildingRepository;
import com.javaweb.repository.BuildingRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.service.IAssignmentBuildingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;

@Service
public class AssignmentBuildingService implements IAssignmentBuildingService {

    @Autowired
    private AssignmentBuildingRepository assignmentBuildingRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BuildingRepository buildingRepository;

    @Transactional
    @Override
    public void updateAssignmentBuilding(AssignmentBuildingDTO assignmentBuildingDTO) {
        assignmentBuildingRepository.deleteByBuildings_IdIn(Arrays.asList(assignmentBuildingDTO.getBuildingId()));

        for (Long staffId : assignmentBuildingDTO.getStaffs()) {
            AssignmentBuildingEntity assignmentBuildingEntity = new AssignmentBuildingEntity();
            assignmentBuildingEntity.setStaffs(userRepository.findById(staffId)
                    .orElseThrow(() -> new MyException("Staffs not found!")));
            assignmentBuildingEntity.setBuildings(buildingRepository.findById(assignmentBuildingDTO.getBuildingId())
                    .orElseThrow(() -> new MyException("Building not found!")));
            assignmentBuildingRepository.save(assignmentBuildingEntity);
        }
    }

}
