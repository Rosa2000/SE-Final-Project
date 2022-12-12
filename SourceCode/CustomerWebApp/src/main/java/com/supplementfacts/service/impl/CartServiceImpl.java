package com.supplementfacts.service.impl;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.context.annotation.SessionScope;

import com.supplementfacts.model.CartItem;
import com.supplementfacts.service.CartService;

@Service
@SessionScope
public class CartServiceImpl implements CartService {
	private Map<String, CartItem> map = new HashMap<String, CartItem>();
	
	@Override
	public void add(CartItem item) {
		CartItem existedItem = map.get(item.getID());
		
		if (existedItem != null) {
			existedItem.setQuantity(item.getQuantity() + existedItem.getQuantity());
		}
		else {
			map.put(item.getID(), item);
		}
	}
	
	@Override
	public void update(String ID) {
		CartItem item = map.get(ID);
		item.setQuantity(item.getQuantity() +1);
		
		if (item.getQuantity() <= 0) {
			map.remove(ID);
		}
	}
	
	
	@Override
	public void remove(String ID) {
		map.remove(ID);
	}
	
	@Override
	public Collection<CartItem> getCartItems() {
		return map.values();
	}
	
	@Override
	public void clear() {
		map.clear();
	}
	
	@Override
	public double getTotal() {
		return map.values().stream().mapToDouble(item -> item.getQuantity()  * item.getSalePrice()).sum();
	}
}
