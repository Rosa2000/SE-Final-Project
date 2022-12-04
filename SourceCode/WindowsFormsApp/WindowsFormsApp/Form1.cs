using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static WindowsFormsApp.SupplementFactsEntities;


namespace WindowsFormsApp
{
    public partial class Form1 : Form
    {
        SupplementFactsEntities context = new SupplementFactsEntities();
        Receipt receipt = new Receipt();
        Goods goods = new Goods();
        DataTable dt = new DataTable();
        long total = 0;

        public Form1()
        {
            InitializeComponent();

            dt.Columns.Add("Goods Name", typeof(string));
            dt.Columns.Add("Quantity", typeof(int));
            dt.Columns.Add("Import Price", typeof(int));
            dt.Columns.Add("Total Value", typeof(long));

            dataGridView1.RowHeadersVisible = false;
            dataGridView2.RowHeadersVisible = false;
            dataGridView3.RowHeadersVisible = false;

            dataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dataGridView2.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dataGridView3.SelectionMode= DataGridViewSelectionMode.FullRowSelect;


            button1.Enabled = false;
            button4.Enabled = false;
            button5.Enabled = false;

            if (dataGridView1.Rows.Count == 0)
            {
                label5.Text = "Total: 0";
                button1.Enabled = false;
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'supplementFactsDataSet1.Order' table. You can move, or remove it, as needed.
            this.orderTableAdapter.Fill(this.supplementFactsDataSet1.Order);
            // TODO: This line of code loads data into the 'supplementFactsDataSet.Goods' table. You can move, or remove it, as needed.
            this.goodsTableAdapter.Fill(this.supplementFactsDataSet.Goods);
            GoodsDataGridView();
        }

        private void textBox2_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar) && (e.KeyChar != '.'))
            {
                e.Handled = true;
            }
        }

        //Add button
        private void button3_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(textBox2.Text))
            {
                MessageBox.Show("Quantity required!");
                textBox2.Focus();
            }

            string goodsName = comboBox1.Text;
            goods = context.Goods.Where(x => x.name == @goodsName).FirstOrDefault();
            goodsName = goods.name;
            long quantity = Convert.ToInt32(textBox2.Text);
            long importPrice = (long)goods.importPrice;
            long totalValue = quantity * importPrice;

            if (dt.Rows.Count == 0)
            {
                //Add goods to preview list
                dt.Rows.Add(goodsName, quantity, importPrice, totalValue);
                dataGridView1.DataSource = dt;
            }
            else
            {  
                List<DataRow> toDelete = new List<DataRow>();

                foreach(DataRow row in dt.Rows){
                    if(comboBox1.Text == (string)row["Goods name"]){
                        toDelete.Add(row);
                    }
                }

                foreach (DataRow row in toDelete){
                    dt.Rows.Remove(row);
                } 
                 
                dt.Rows.Add(goodsName, quantity, importPrice, totalValue);
                dataGridView1.DataSource = dt;
            }
            
            foreach (DataRow row in dt.Rows)
            {
                total += (long)row["Total Value"];
                label5.Text = "Total: " + total;
            }

            textBox2.Text = string.Empty;
            button1.Enabled = true;
        }

        //Remove button
        private void button4_Click(object sender, EventArgs e)
        {
            foreach (DataGridViewCell oneCell in dataGridView1.SelectedCells)
            {
                if (oneCell.Selected)
                {
                    DialogResult rs = MessageBox.Show("Remove this item ?", "Remove item");
                    if (rs == DialogResult.OK)
                    {
                        dataGridView1.Rows.RemoveAt(oneCell.RowIndex);
                        button4.Enabled = false;

                        //Disable create button if no data in table
                        if (dataGridView1.Rows.Count == 0)
                        {
                            button1.Enabled = false;
                        }
                    }
                }
            }
        }

        //Create button
        private void button1_Click(object sender, EventArgs e)
        {
            long noteTotal = total;
            DateTime date = DateTime.Now;

            //Update goods stock
            foreach (DataRow row in dt.Rows)
            {
                string goodsName = (string)row["Goods Name"];
                goods = context.Goods.Where(x => x.name == @goodsName).FirstOrDefault();

                string indentifyCode = goods.ID.ToString();
                string name = goods.name.ToString();
                long importPrice = (long)goods.importPrice.Value;
                long salePrice = (long)goods.salePrice.Value;
                int stock = (int)goods.stock.Value;
                int quantity = (int)row["Quantity"];
                long totalValue = (long)row["Total Value"];

                stock += quantity;

                goods.ID = indentifyCode;
                goods.name = name;
                goods.importPrice = importPrice;
                goods.salePrice = salePrice;
                goods.stock = stock;

                context.Entry(goods).State = System.Data.Entity.EntityState.Modified;
                context.SaveChanges();
            }

            // Create new goods received record
            context.Receipts.Add(new Receipt { createDate = date, total = total });
            context.SaveChanges();

            //Create goods received detail record
            foreach (DataRow row in dt.Rows)
            {
                string goodsName = (string)row["Goods Name"];
                goods = context.Goods.Where(x => x.name == @goodsName).FirstOrDefault();
                receipt = context.Receipts.OrderByDescending(p => p.ID).FirstOrDefault();
                int quantity = (int)row["Quantity"];
                long totalValue = (long)row["Total Value"];

                ReceiptDetails receiptDetail = new ReceiptDetails()
                {
                    receiptID = receipt.ID,
                    goodsID = goods.ID,
                    quantity = quantity,
                    total = totalValue,
                };

                context.ReceiptDetails.Add(receiptDetail);
                context.SaveChanges();
            }

            MessageBox.Show("SUCCESSFULLY CREATED!", "Good Received Note");

            //Reset form
            Clear();
        }

        private void comboBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = true;
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            button4.Enabled = true;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Under construction!", "Add new item");
        }

        void GoodsDataGridView()
        {
            dataGridView2.DataSource = context.Goods.ToList<Goods>();
        }

        void Clear()
        {
            label5.Text = "Total: ";

            button1.Enabled = false;
            button4.Enabled = false;
            textBox2.Text = string.Empty;

            dt.Rows.Clear();
        }

        private void dataGridView3_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var row = dataGridView3.CurrentRow.Cells[1];
            string id = row.ToString();
            Console.WriteLine(id);
            //OrderDetail = context.OrderDetails.Where(x => x.orderID == )
        }
    }
}
