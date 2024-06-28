package com.javaweb.repository.custom.impl;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.model.request.CustomerSearchRequest;
import com.javaweb.repository.custom.CustomerRepositoryCustom;
import com.javaweb.utils.StringUtils;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;

@Repository
public class CustomerRepositoryImpl implements CustomerRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;

    public void queryJoin(CustomerSearchRequest customer, StringBuilder sql) {
        Long staffId = customer.getStaffId();
        if (staffId != null) {
            sql.append(" JOIN assignmentcustomer asmc ON asmc.customerid = ctm.id ");
        }
    }

    public void queryWhereNormal(CustomerSearchRequest customer, StringBuilder where) {
        try {
            Field[] fields = CustomerSearchRequest.class.getDeclaredFields();
            for (Field item : fields) {
                item.setAccessible(true);
                String fieldName = item.getName();
                if (!fieldName.equals("staffId")) {
                    String value = item.get(customer) != null ? item.get(customer).toString() : null;
                    if (StringUtils.check(value)) {
                        if (item.getType().getName().equals("java.lang.Long")) {
                            where.append(" AND ctm." + fieldName.toLowerCase() + " = " + value);
                        } else if (item.getType().getName().equals("java.lang.Integer")) {
                            where.append(" AND ctm." + fieldName.toLowerCase() + " = " + value);
                        } else if (item.getType().getName().equals("java.lang.String")) {
                            where.append(" AND ctm." + fieldName.toLowerCase() + " LIKE '%" + value + "%'");
                        }
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void queryWhereSpecial(CustomerSearchRequest customer, StringBuilder where) {
        Long staffId = customer.getStaffId();
        if (staffId != null) {
            where.append(" AND asmc.staffid = " + staffId);
        }
    }

    @Override
    public List<CustomerEntity> findAll(CustomerSearchRequest customer) {
        StringBuilder sql = new StringBuilder(buildQueryFilter(customer));

        Query query = entityManager.createNativeQuery(sql.toString(), CustomerEntity.class);
        return query.getResultList();
    }

    @Override
    public int countTotalItem(CustomerSearchRequest customer) {
        String sql = buildQueryFilter(customer);
        Query query = entityManager.createNativeQuery(sql.toString());
        return query.getResultList().size();
    }

    private String buildQueryFilter(CustomerSearchRequest customer) {
        StringBuilder sql = new StringBuilder("SELECT ctm.* FROM Customer ctm ");
        queryJoin(customer, sql);

        StringBuilder where = new StringBuilder("WHERE 1 = 1 ");
        queryWhereNormal(customer, where);
        queryWhereSpecial(customer, where);
        where.append(" AND ctm.is_active = 1 ");
        sql.append(where).append(" GROUP BY ctm.id ");

        return sql.toString();
    }
}
