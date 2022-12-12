package com.supplementfacts.service;

import com.supplementfacts.model.Goods;

public interface GoodsService {
	public Iterable<Goods> findAll();

	Goods findGoods(String ID);
}
