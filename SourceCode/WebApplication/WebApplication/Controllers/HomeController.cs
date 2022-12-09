using PagedList;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity;
using System.Drawing.Printing;
using System.Dynamic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.DynamicData.ModelProviders;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.WebPages;
using WebApplication.Models;
using WebGrease.ImageAssemble;

namespace WebApplication.Controllers
{
    public class HomeController : Controller
    {
        SupplementFactsEntities db = new SupplementFactsEntities();

        // GET: Application
        public ActionResult Index()
        {
            dynamic dy = new ExpandoObject();
            dy.goodsList = GetGoods();
            dy.receiptsList = GetReceipt();
            dy.receiptDetailsList = GetReceiptDetails();
            dy.orderList = GetOrder();
            dy.orderDetailsList = GetOrderDetails();
            dy.agentList = GetAgent();
            dy.deliList = GetDelivery();

            List<Agents> agents = db.Agents.ToList();
            SelectList agentIDList = new SelectList(agents, "ID", "ID" );
            ViewBag.agentIDList = agentIDList;

            return View(dy);
        }
        public ActionResult OrderComplete()
        {
            return View();
        }

        [HttpGet]
        public ActionResult OrderHistory() 
        {
            return View(db.Orders.OrderByDescending(x => x.ID).ToList());
        }

        public ActionResult OrderDetails(int id)
        {
            var orderDetail = db.OrderDetails.Where(x => x.orderID == id).ToList();
            System.Diagnostics.Debug.WriteLine(orderDetail);
            return View(orderDetail);
        }

        [HttpPost]
        public ActionResult FormSubbmit(FormCollection form)
        {
            List<int> quantityList = new List<int>();
            string goodsQuantity = form["goodsQuantity"];
            foreach (string c in goodsQuantity.Split(','))
            {
                quantityList.Add(Int32.Parse(c));
            }

            string paymentMethod = form["paymentMethod"].ToString();
            var goods = db.Goods.ToList();
            string agentID = form["AgentID"];//get agent id
            var agent = db.Agents.Where(x => x.ID == agentID).FirstOrDefault();//select agent by id
            string agentName = agent.name;
            decimal discount = (int)agent.discount;//agent discount
            DateTime createDate = DateTime.Now;
            decimal total = 0;

            for (int i = 0 ; i < quantityList.Count; i++)
            {
                decimal quantity = quantityList[i];
                decimal salePrice = (decimal)goods[i].salePrice;
                total += (quantity * salePrice);
            }

            decimal afterDiscount = total - (total * discount / 100);
            db.Orders.Add(new Order {
                createDate = createDate,
                agentID = agentID,
                discount = (int)discount,
                total = afterDiscount,
                paymentMethod = paymentMethod ,
                paymentStatus = "Unpaid",
                orderStatus = "New"
            });
            db.SaveChanges();

            var order = db.Orders.OrderByDescending(p => p.ID).FirstOrDefault();
            for (int i = 0; i < quantityList.Count; i++)
            {
                int orderID = order.ID;
                string goodsID = goods[i].ID;
                int quantity = quantityList[i];
                int stock = (int)goods[i].stock;
                decimal salePrice = (decimal)goods[i].salePrice;
                total = (decimal)quantity * salePrice;

                if (quantity != 0)
                {
                    db.OrderDetails.Add(new OrderDetails
                    {
                        orderID = orderID,
                        goodsID = goodsID,
                        quantity = quantity,
                        total = total,
                    });

                    stock = stock - quantity;
                    goods[i].stock = stock;

                    db.SaveChanges();
                }
            }
            return RedirectToAction("OrderComplete");
        }

        public List<Goods> GetGoods()
        {
            List<Goods> goods = db.Goods.ToList();
            return goods;
        }

        public List<Agents> GetAgent()
        {
            List<Agents> agents = db.Agents.ToList();
            return agents;
        }

        public List<Order> GetOrder()
        {
            List<Order> orders = db.Orders.ToList();
            return orders;
        }

        public List<OrderDetails> GetOrderDetails()
        {
            List<OrderDetails> orderDetails = db.OrderDetails.ToList();
            return orderDetails;
        }

        public List<Receipt> GetReceipt()
        {
            List<Receipt> receipts = db.Receipts.ToList();
            return receipts;
        }

        public List<Delivery> GetDelivery()
        {
            List<Delivery> deliveries = db.Deliveries.ToList();
            return deliveries;
        }

        public List<ReceiptDetails> GetReceiptDetails()
        {
            List<ReceiptDetails> receiptDetails = db.ReceiptDetails.ToList();
            return receiptDetails;
        }

    }
}
