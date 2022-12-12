package com.supplementfacts.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.supplementfacts.model.Goods;

@Repository("goodsRepository")
public interface GoodsRepository extends JpaRepository<Goods, String> {

}
