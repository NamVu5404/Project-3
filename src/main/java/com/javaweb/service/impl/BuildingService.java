package com.javaweb.service.impl;

import com.javaweb.converter.BuildingConverter;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.RentAreaEntity;
import com.javaweb.exception.MyException;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.repository.AssignmentBuildingRepository;
import com.javaweb.repository.BuildingRepository;
import com.javaweb.repository.RentAreaRepository;
import com.javaweb.service.IBuildingService;
import com.javaweb.utils.UploadFileUtils;
import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class BuildingService implements IBuildingService {

    @Autowired
    private BuildingRepository buildingRepository;

    @Autowired
    private RentAreaRepository rentAreaRepository;

    @Autowired
    private BuildingConverter buildingConverter;

    @Autowired
    private AssignmentBuildingRepository assignmentBuildingRepository;

    @Autowired
    private UploadFileUtils uploadFileUtils;

    @Override
    public List<BuildingSearchResponse> findAll(BuildingSearchRequest buildingSearchRequest, Pageable pageable) {
        List<BuildingEntity> buildingEntities = buildingRepository.findAll(buildingSearchRequest, pageable);
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
        buildingRepository.save(buildingEntity);

        if (buildingDTO.getId() != null) { // update
            rentAreaRepository.deleteByBuildingIdIn(Arrays.asList(buildingDTO.getId()));
        }
        Arrays.stream(buildingDTO.getRentArea().split(",")).forEach(it -> {
            RentAreaEntity rentAreaEntity = new RentAreaEntity();
            rentAreaEntity.setBuilding(buildingEntity);
            rentAreaEntity.setValue(Long.parseLong(it.trim()));
            rentAreaRepository.save(rentAreaEntity);
        });
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

            rentAreaRepository.deleteByBuildingIdIn(ids);
            assignmentBuildingRepository.deleteByBuildings_IdIn(ids);
            buildingRepository.deleteByIdIn(ids);
        }
    }

    @Override
    public int countTotalItem(BuildingSearchRequest builder) {
        return buildingRepository.countTotalItem(builder);
    }

}