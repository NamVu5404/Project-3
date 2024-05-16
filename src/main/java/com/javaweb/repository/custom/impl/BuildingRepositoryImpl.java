package com.javaweb.repository.custom.impl;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.repository.custom.BuildingRepositoryCustom;
import com.javaweb.utils.StringUtils;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;
import java.util.stream.Collectors;

@Repository
public class BuildingRepositoryImpl implements BuildingRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;

    public void queryJoin(BuildingSearchRequest builder, StringBuilder sql) {
        Long areaFrom = builder.getAreaFrom();
        Long areaTo = builder.getAreaTo();
        if (areaFrom != null || areaTo != null) {
            sql.append(" JOIN rentarea r ON r.buildingid = b.id ");
        }
        Long staffId = builder.getStaffId();
        if (staffId != null) {
            sql.append(" JOIN assignmentbuilding asm ON asm.buildingid = b.id ");
        }
    }

    public void queryWhereNormal(BuildingSearchRequest builder, StringBuilder where) {
        try {
            Field[] fields = BuildingSearchRequest.class.getDeclaredFields();
            for (Field item : fields) {
                item.setAccessible(true);
                String fieldName = item.getName();
                if (!fieldName.equals("staffId") && !fieldName.equals("typeCode") && !fieldName.startsWith("area")
                        && !fieldName.startsWith("rentPrice")) {
                    String value = item.get(builder) != null ? item.get(builder).toString() : null;
                    if (StringUtils.check(value)) {
                        if (item.getType().getName().equals("java.lang.Long")) {
                            where.append(" AND b." + fieldName.toLowerCase() + " = " + value);
                        } else if (item.getType().getName().equals("java.lang.Integer")) {
                            where.append(" AND b." + fieldName.toLowerCase() + " = " + value);
                        } else if (item.getType().getName().equals("java.lang.String")) {
                            where.append(" AND b." + fieldName.toLowerCase() + " LIKE '%" + value + "%'");
                        }
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void queryWhereSpecial(BuildingSearchRequest builder, StringBuilder where) {
        Long staffId = builder.getStaffId();
        if (staffId != null) {
            where.append(" AND asm.staffid = " + staffId);
        }

        Long areaFrom = builder.getAreaFrom();
        Long areaTo = builder.getAreaTo();
        if (areaFrom != null) {
            where.append(" AND r.value >= " + areaFrom);
        }
        if (areaTo != null) {
            where.append(" AND r.value <= " + areaTo);
        }

        Long rentPriceFrom = builder.getRentPriceFrom();
        Long rentPriceTo = builder.getRentPriceTo();
        if (rentPriceFrom != null) {
            where.append(" AND b.rentprice >= " + rentPriceFrom);
        }
        if (rentPriceTo != null) {
            where.append(" AND b.rentprice <= " + rentPriceTo);
        }

        List<String> typeCode = builder.getTypeCode();
        if (typeCode != null && !typeCode.isEmpty()) {
            where.append(" AND (");
            where.append(typeCode.stream().map(item -> " b.type LIKE '%" + item + "%' ")
                    .collect(Collectors.joining(" OR ")));
            where.append(" ) ");
        }
    }

    @Override
    public List<BuildingEntity> findAll(BuildingSearchRequest builder, Pageable pageable) {
        StringBuilder sql = new StringBuilder(buildQueryFilter(builder))
                .append(" LIMIT ").append(pageable.getPageSize()).append("\n")
                .append(" OFFSET ").append(pageable.getOffset());

        Query query = entityManager.createNativeQuery(sql.toString(), BuildingEntity.class);
        return query.getResultList();
    }

    @Override
    public int countTotalItem(BuildingSearchRequest builder) {
        String sql = buildQueryFilter(builder);
        Query query = entityManager.createNativeQuery(sql.toString());
        return query.getResultList().size();
    }

    private String buildQueryFilter(BuildingSearchRequest builder) {
        StringBuilder sql = new StringBuilder("SELECT b.* FROM Building b ");
        queryJoin(builder, sql);

        StringBuilder where = new StringBuilder("WHERE 1 = 1 ");
        queryWhereNormal(builder, where);
        queryWhereSpecial(builder, where);
        sql.append(where).append(" GROUP BY b.id ");

        return sql.toString();
    }
}
