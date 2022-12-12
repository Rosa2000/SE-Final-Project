package com.supplementfacts.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.supplementfacts.model.Goods;
import com.supplementfacts.repository.GoodsRepository;
import com.supplementfacts.service.GoodsService;

import jakarta.transaction.Transactional;

@Transactional
@Service("goodsService")
public class GoodsServiceImpl implements GoodsService {

	@Autowired
	private GoodsRepository goodsRepository;

	@Override
	public Iterable<Goods> findAll() {
		return goodsRepository.findAll();
	}

	@Override
	public Goods findGoods(String ID) {
		return goodsRepository.getReferenceById(ID);
	}
	
}
