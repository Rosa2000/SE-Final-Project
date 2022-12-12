package com.supplementfacts.service;

import com.supplementfacts.model.CustomerOrder;

public interface CustomerOrderService {

	CustomerOrder findLastOrder();

	void saveCustomerOrder(CustomerOrder customerOrder);

}
