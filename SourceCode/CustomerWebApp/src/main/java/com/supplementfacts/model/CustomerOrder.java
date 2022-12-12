package com.supplementfacts.model;

import java.time.LocalDateTime;
import jakarta.persistence.*;

@Entity
@Table(name = "[customerorder]")
public class CustomerOrder {
	
	@Id
	@Column(name = "id")
	private int ID;
	
	@Column(name = "createdate")
	private LocalDateTime createDate;
	
	@Column(name = "total")
	private double total;
	
	@Column(name = "customername")
	private String customerName;
	
	@Column(name = "phone")
	private String phone;
	
	@Column(name = "address")
	private String address;
	
	@Column(name = "email")
	private String email;
	
//	public CustomerOrder(CustomerOrder customerOrder) {
//        if (customerOrder != null) {
//        	this.ID = customerOrder.getID();
//        	this.createDate = customerOrder.getCreateDate();
//        	this.total = customerOrder.getTotal();
//        	this.customerName = customerOrder.getCustomerName();
//            this.address = customerOrder.getAddress();
//            this.phone = customerOrder.getPhone();
//            this.email = customerOrder.getEmail();
//        }
//    }

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "CustomerOrder [ID=" + ID + ", createDate=" + createDate + ", total=" + total + ", customerName="
				+ customerName + ", phone=" + phone + ", address=" + address + ", email=" + email + "]";
	}
	
	
	
	
}
