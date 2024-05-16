package com.javaweb.service;

import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface IBuildingService {
    List<BuildingSearchResponse> findAll(BuildingSearchRequest buildingSearchRequest, Pageable pageable);
    BuildingDTO findById(Long id);
    void addOrUpdateBuilding(BuildingDTO buildingDTO);
    void deleteBuilding(List<Long> ids);
    int countTotalItem(BuildingSearchRequest builder);
}
