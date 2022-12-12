package com.supplementfacts.model;

public class CartItem {

	private String ID;
	private String name;
	private double salePrice;
	private int quantity;
	private double total;
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
	public double getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(double salePrice) {
		this.salePrice = salePrice;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public double getTotal() {
		return salePrice*quantity;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	@Override
	public String toString() {
		return "CartItem [ID=" + ID + ", name=" + name + ", salePrice=" + salePrice + ", quantity=" + quantity
				+ ", total=" + total + "]";
	}
	
}
