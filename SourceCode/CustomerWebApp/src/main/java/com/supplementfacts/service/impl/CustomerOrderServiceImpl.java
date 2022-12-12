package com.supplementfacts.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.supplementfacts.model.CustomerOrder;
import com.supplementfacts.repository.CustomerOrderRepository;
import com.supplementfacts.service.CustomerOrderService;


@Service("customerOrderService")
public class CustomerOrderServiceImpl implements CustomerOrderService {

	@Autowired
	private CustomerOrderRepository customerOrderRepository;
	
	@Override
	public void saveCustomerOrder(CustomerOrder customerOrder) {
		customerOrderRepository.save(customerOrder);
	}
	
	@Override
	public CustomerOrder findLastOrder() {
		return customerOrderRepository.findLastOrder();
	}

}
