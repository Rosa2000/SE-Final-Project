package com.supplementfacts.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.supplementfacts.model.CustomerOrder;

@Repository
public interface CustomerOrderRepository extends JpaRepository<CustomerOrder, Integer> {
	
	@Query(value ="SELECT TOP 1 ID, createdate, total , customername, phone, address, email FROM [customerorder] ORDER BY id DESC ", nativeQuery = true)
	CustomerOrder findLastOrder();
}
