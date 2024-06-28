package com.javaweb.converter;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.RentAreaEntity;
import com.javaweb.enums.districtCode;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.response.BuildingSearchResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class BuildingConverter {

    @Autowired
    private ModelMapper modelMapper;

    public BuildingSearchResponse convertToSearchResponse(BuildingEntity item) {
        BuildingSearchResponse building = modelMapper.map(item, BuildingSearchResponse.class);

        String districtName = (item.getDistrict() != null && !item.getDistrict().isEmpty()) ?
                districtCode.valueOf(item.getDistrict()).getDistrictName() : "";
        building.setAddress(item.getStreet() + "," + item.getWard() + "," + districtName);

        String rentAreas = item.getRentAreas().stream().map(it -> it.getValue().toString()).collect(Collectors.joining(","));
        building.setRentArea(rentAreas);

        return building;
    }

    public BuildingDTO convertToDTO(BuildingEntity buildingEntity) {
        BuildingDTO buildingDTO = modelMapper.map(buildingEntity, BuildingDTO.class);

        List<String> typeCode = Arrays.asList(buildingEntity.getTypeCode().split(","));
        buildingDTO.setTypeCode(typeCode);

        String rentArea = buildingEntity.getRentAreas().stream().map(it -> it.getValue().toString()).collect(Collectors.joining(","));
        buildingDTO.setRentArea(rentArea);
        return buildingDTO;
    }

    public BuildingEntity convertToEntity(BuildingDTO buildingDTO) {
        BuildingEntity buildingEntity = modelMapper.map(buildingDTO, BuildingEntity.class);

        String typeCode = String.join(",", buildingDTO.getTypeCode());
        buildingEntity.setTypeCode(typeCode);

        List<RentAreaEntity> rentAreaEntities = new ArrayList<>();
        Arrays.stream(buildingDTO.getRentArea().split(",")).forEach(it -> {
            RentAreaEntity rentAreaEntity = new RentAreaEntity();
            rentAreaEntity.setBuilding(buildingEntity);
            rentAreaEntity.setValue(Long.parseLong(it.trim()));
            rentAreaEntities.add(rentAreaEntity);
        });
        buildingEntity.setRentAreas(rentAreaEntities);

        return buildingEntity;
    }

}
