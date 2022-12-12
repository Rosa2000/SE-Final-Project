package com.supplementfacts.controller;

import java.time.LocalDateTime;
import java.util.Collection;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.supplementfacts.model.CartItem;
import com.supplementfacts.model.CustomerOrder;
import com.supplementfacts.model.Goods;
import com.supplementfacts.service.CartService;
//import com.supplementfacts.service.CustomerOrderDetailsService;
import com.supplementfacts.service.CustomerOrderService;
import com.supplementfacts.service.GoodsService;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.transaction.Transactional;

@Controller
//@RequestMapping("/")
@Transactional
public class OrderController {
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private CustomerOrderService customerOrderService;
	
	@Autowired
	public JavaMailSender emailSender;
	
	@RequestMapping("/")
	public String Index(ModelMap modelMap) {
		modelMap.put("Goods", goodsService.findAll());
		return "index";
	}
	
	@GetMapping("cart")
	public String list(ModelMap modelMap) {
		Collection<CartItem> cartItems = cartService.getCartItems();
		modelMap.addAttribute("cartItems", cartItems);
		modelMap.addAttribute("total", cartService.getTotal());
		return "cart";
	}
	@GetMapping("add/{ID}")
	public String add(@PathVariable("ID") String ID) {
		
		Goods goods = goodsService.findGoods(ID);
		if (goods != null) {
			CartItem item = new CartItem();
			BeanUtils.copyProperties(goods, item);
			cartService.add(item);
			//Update quantity if item is existed
			cartService.update(item.getID());
			
			cartService.getTotal();
		}
		return "redirect:/cart";
	}
	
	@GetMapping("remove/{ID}")
	public String remove(@PathVariable("ID") String ID) {
		cartService.remove(ID);
		return "redirect:/cart";
	}
	
	@GetMapping("checkout")
	public String checkout(ModelMap modelMap) {
		Collection<CartItem> cartItems = cartService.getCartItems();
		CustomerOrder customerOrder = new CustomerOrder();
		
		modelMap.addAttribute("cartItems", cartItems);
		modelMap.addAttribute("total", cartService.getTotal());
		modelMap.addAttribute("customerOrder", customerOrder);
		
		return "checkout";
	}
	
	@PostMapping("checkout")
	public String submitForm(@ModelAttribute("customerOrder") CustomerOrder customerOrder) {
		
		System.out.print(customerOrder.toString());
		LocalDateTime now = LocalDateTime.now(); 
		if (customerOrderService.findLastOrder() == null) {
			customerOrder.setID(0);
			System.out.print(customerOrder.toString());
		}
		
		customerOrder.setID(customerOrderService.findLastOrder().getID() + 1);
		customerOrder.setCreateDate(now);
		customerOrder.setTotal(cartService.getTotal());
		customerOrder.setCustomerName(customerOrder.getCustomerName());
		customerOrder.setAddress(customerOrder.getAddress());
		customerOrder.setPhone(customerOrder.getPhone());
		customerOrder.setEmail(customerOrder.getEmail());
		customerOrderService.saveCustomerOrder(customerOrder);
		System.out.print(customerOrder.toString());
		return "redirect:/orderCompleted";
	}
	
	@GetMapping("orderCompleted")
	public String orderCompleted() throws MessagingException {
	      
		//mail sender
		CustomerOrder customerOrder = customerOrderService.findLastOrder();
	      String customerEmail = customerOrder.getEmail();
	      String customerName = customerOrder.getCustomerName();
	      String customerAddress = customerOrder.getAddress();
	      String customerPhone = customerOrder.getPhone();    
	      long orderTotal = (long)customerOrder.getTotal();
	      
	      MimeMessage message = emailSender.createMimeMessage();
	      MimeMessageHelper helper = new MimeMessageHelper(message);
	      
	      helper.setFrom("springbootshoppingcard@gmail.com");
	      helper.setTo(customerEmail);
	      helper.setSubject("Order Successfully!");
	      
	      boolean html = true;
	      
	      String content = "<b>Hello </b>"+ customerName + ", <br>";
	      content += "Thank you for your order." + "<br>";
	      content += "<i>Here's your personal information</i>" + "\n";
	      content += "<li>Name: " + customerName + "</li>" + "\n";
	      content += "<li>Email: " + customerEmail +"</li>" + "\n";
	      content += "<li>Phone: " + customerPhone + "</li>" + "\n";
	      content += "<li>Address: "+ customerAddress + "</li>" + "\n";
	      content += "<br>" + "\n";
		  content += "<i>Here's your order summary</i>" + "<br>";
		  
		  for (CartItem item : cartService.getCartItems())
		  {
			  content += "<i>"+ item.getQuantity() + "x \t" +  item.getName() + "\t" + 
					  item.getSalePrice() + "</i>" + "<br>";
		  }

		  content += "<hr>";
		  content += "<i> Total: " + orderTotal + "</i>" +  "<br>";
		  content += "You will receive your order after 7 - 10 days." + "<br>";
		  content += "Payment will be made when the order is received" + "<br>";
	      
	      helper.setText(content, html);
	  
	      emailSender.send(message);
	      cartService.clear();
		return "orderCompleted";
	}
	
}
