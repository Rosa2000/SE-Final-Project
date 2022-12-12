package com.supplementfacts.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Goods")
public class Goods {

	@Id
	@Column(name = "id")
    private String ID;
    
	@Column(name = "name")
    private String name;
    
	@Column(name = "importprice")
    private double importPrice;
	
	@Column(name = "saleprice")
    private double salePrice;
	
	@Column
    private int stock;

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getImportPrice() {
		return importPrice;
	}

	public void setImportPrice(double importPrice) {
		this.importPrice = importPrice;
	}

	public double getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(double salePrice) {
		this.salePrice = salePrice;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	@Override
	public String toString() {
		return "Goods [ID=" + ID + ", name=" + name + ", importPrice=" + importPrice + ", salePrice=" + salePrice
				+ ", stock=" + stock + "]";
	}
    
}