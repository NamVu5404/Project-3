package com.javaweb.service.impl;

import com.javaweb.converter.BuildingConverter;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.exception.MyException;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.repository.BuildingRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.service.IBuildingService;
import com.javaweb.utils.UploadFileUtils;
import lombok.AllArgsConstructor;
import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
public class BuildingService implements IBuildingService {

    private final BuildingRepository buildingRepository;
    private final BuildingConverter buildingConverter;
    private final UploadFileUtils uploadFileUtils;
    private final UserRepository userRepository;

    @Override
    public List<BuildingSearchResponse> findAll(BuildingSearchRequest buildingSearchRequest) {
        List<BuildingEntity> buildingEntities = buildingRepository.findAll(buildingSearchRequest);
        List<BuildingSearchResponse> result = new ArrayList<>();

        for (BuildingEntity item : buildingEntities) {
            BuildingSearchResponse buildingSearchResponse = buildingConverter.convertToSearchResponse(item);
            result.add(buildingSearchResponse);
        }

        return result;
    }

    @Override
    public BuildingDTO findById(Long id) {
        BuildingEntity buildingEntity = buildingRepository.findById(id)
                .orElseThrow(() -> new MyException("Building not found!"));
        return buildingConverter.convertToDTO(buildingEntity);
    }

    @Transactional
    @Override
    public void addOrUpdateBuilding(BuildingDTO buildingDTO) {
        Long buildingId = buildingDTO.getId();
        BuildingEntity buildingEntity = buildingConverter.convertToEntity(buildingDTO);

        // save avatar
        if (buildingId != null) {
            BuildingEntity foundBuilding = buildingRepository.findById(buildingId)
                    .orElseThrow(() -> new MyException("Building not found!"));
            buildingEntity.setAvatar(foundBuilding.getAvatar());
        }
        saveThumbnail(buildingDTO, buildingEntity);

        if (buildingId != null) {
            List<UserEntity> staffs = buildingRepository.findById(buildingId)
                    .orElseThrow(() -> new MyException("Building not found!"))
                    .getStaffs();
            buildingEntity.setStaffs(staffs);
        }

        buildingRepository.save(buildingEntity);
    }

    private void saveThumbnail(BuildingDTO buildingDTO, BuildingEntity buildingEntity) {
        String path = "/building/" + buildingDTO.getImageName();
        if (null != buildingDTO.getImageBase64()) {
            if (null != buildingEntity.getAvatar()) {
                if (!path.equals(buildingEntity.getAvatar())) {
                    File file = new File("C://home/office" + buildingEntity.getAvatar());
                    file.delete();
                }
            }
            byte[] bytes = Base64.decodeBase64(buildingDTO.getImageBase64().getBytes());
            uploadFileUtils.writeOrUpdate(path, bytes);
            buildingEntity.setAvatar(path);
        }
    }

    @Transactional
    @Override
    public void deleteBuilding(List<Long> ids) {
        if (!ids.isEmpty()) {
            int count = buildingRepository.countByIdIn(ids);

            if (count != ids.size()) {
                throw new MyException("Building not found!");
            }

            buildingRepository.deleteByIdIn(ids);
        }
    }

    @Override
    public int countTotalItem(BuildingSearchRequest builder) {
        return buildingRepository.countTotalItem(builder);
    }

    @Transactional
    @Override
    public void updateAssignmentBuilding(AssignmentBuildingDTO assignmentBuildingDTO) {
        BuildingEntity building = buildingRepository.findById(assignmentBuildingDTO.getBuildingId())
                .orElseThrow(() -> new MyException("Building Not Found"));

        List<UserEntity> staffs = userRepository.findAllById(assignmentBuildingDTO.getStaffs());
        building.setStaffs(staffs);

        buildingRepository.save(building);
    }

}