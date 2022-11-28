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
            dt.Columns.Add("Import Unit Price", typeof(int));
            dt.Columns.Add("Total Amount", typeof(long));

            dataGridView1.RowHeadersVisible = false;
            dataGridView2.RowHeadersVisible = false;

            dataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            //dataGridView1.EnableHeadersVisualStyles = false;
            //dataGridView1.ColumnHeadersDefaultCellStyle.SelectionBackColor = dataGridView1.ColumnHeadersDefaultCellStyle.BackColor;
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
            long importUnitPrice = (long)goods.importPrice;
            long totalAmount = quantity * importUnitPrice;

            if (dt.Rows.Count == 0)
            {
                //Add goods to list
                dt.Rows.Add(goodsName, quantity, importUnitPrice, totalAmount);
                dataGridView1.DataSource = dt;
                foreach (DataRow row in dt.Rows)
                {
                    Console.WriteLine(row["Goods name"].ToString());
                }
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
                 
                dt.Rows.Add(goodsName, quantity, importUnitPrice, totalAmount);
                dataGridView1.DataSource = dt;
            }
            

            foreach (DataRow row in dt.Rows)
            {
                total += (long)row["Total Amount"];
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
            int receiptID;
            DateTime date = DateTime.Now;

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
            receipt = context.Receipts.OrderByDescending(p => p.ID).FirstOrDefault();
            if (receipt != null)
            {
                receiptID = (int)receipt.ID + 1;
            }
            else
            {
                receiptID = 1;
            }
            context.Receipts.Add(new Receipt { ID = receiptID, createDate = date });
            context.SaveChanges();

            //Create goods received detail record
            foreach (DataRow row in dt.Rows)
            {
                string goodsName = (string)row["Goods Name"];
                goods = context.Goods.Where(x => x.name == @goodsName).FirstOrDefault();
                int quantity = (int)row["Quantity"];
                ReceiptDetail receiptDetail = new ReceiptDetail()
                {
                    receiptID = receiptID,
                    goodsID = goods.ID,
                    quantity = quantity,
                    total = total,
                };

                Console.WriteLine(receiptDetail.ToString());

                context.ReceiptDetails.Add(receiptDetail);
                context.SaveChanges();
                
            }

            MessageBox.Show("SUCCESSFULLY CREATED!", "Good Received Note");
            
            //Reset form
            dt.Rows.Clear();
            button1.Enabled = false;

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
    }
}
