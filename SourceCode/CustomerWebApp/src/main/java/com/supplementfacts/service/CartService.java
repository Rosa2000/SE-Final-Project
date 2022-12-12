package com.supplementfacts.service;

import java.util.Collection;

import com.supplementfacts.model.CartItem;

public interface CartService {

	void clear();

	Collection<CartItem> getCartItems();

	void remove(String ID);

	void update(String ID);

	void add(CartItem item);

	double getTotal();

}
