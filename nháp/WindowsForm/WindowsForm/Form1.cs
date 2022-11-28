using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Reflection;
using System.Runtime.Remoting.Contexts;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using static WindowsForm.SupplementFactsEntities;

namespace WindowsForm
{
    public partial class Form1 : Form
    {
        SupplementFactsEntities entities = new SupplementFactsEntities();
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
            dataGridView2.RowHeadersVisible= false;

            dataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            //dataGridView1.EnableHeadersVisualStyles = false;
            //dataGridView1.ColumnHeadersDefaultCellStyle.SelectionBackColor = dataGridView1.ColumnHeadersDefaultCellStyle.BackColor;
            button1.Enabled= false;
            button4.Enabled= false;
            button5.Enabled = false;

            if (dataGridView1.Rows.Count == 0)
            {
                label5.Text = "Total: 0";
            }

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
            else
            {
                string goodsName = comboBox1.Text;
                goods = entities.Goods.Where(x => x.name == @goodsName).FirstOrDefault();
                goodsName = goods.name;
                long quantity = Convert.ToInt32(textBox2.Text);
                long importUnitPrice = (long)goods.importPrice;
                long totalAmount = quantity * importUnitPrice;


                //Add goods to list
                dt.Rows.Add(goodsName, quantity, importUnitPrice, totalAmount);
                dataGridView1.DataSource = dt;

                textBox2.Text = string.Empty;

                foreach (DataRow row in dt.Rows)
                {
                    total += (long)row["Total Amount"];
                    label5.Text = "Total: " + total;
                }

                button1.Enabled = true;
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'supplementFactsDataSet1.Goods' table. You can move, or remove it, as needed.
            this.goodsTableAdapter1.Fill(this.supplementFactsDataSet1.Goods);
            // TODO: This line of code loads data into the 'supplementFactsDataSet.Goods' table. You can move, or remove it, as needed.
            this.goodsTableAdapter.Fill(this.supplementFactsDataSet.Goods);

        }

        private void comboBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = true;
        }

        //Create button
        private void button1_Click(object sender, EventArgs e)
        {
            foreach (DataRow row in dt.Rows)
            {
                string goodsName = (string)row["Goods Name"];
                goods = entities.Goods.Where(x => x.name == @goodsName).FirstOrDefault();

                string indentifyCode = goods.ID.ToString();
                string name = goods.name.ToString();
                long importPrice = (long)goods.importPrice.Value;
                long salePrice = (long)goods.salePrice.Value;
                int stock = (int)goods.stock.Value;
                int quantity = (int)row["Quantity"];
                long noteTotal = total;

                Console.WriteLine(stock);
                stock += quantity;
                Console.WriteLine(stock);
                goods.ID = indentifyCode;
                goods.name = name;
                goods.importPrice = importPrice;
                goods.salePrice = salePrice;
                goods.stock = stock;
                
                entities.Entry(goods).State = System.Data.Entity.EntityState.Modified;
                entities.SaveChanges();

                //create new goods received record

                //receipt.ID = 1;
                //receipt.createDate = DateTime.Now;
                //entities.Add(receipt);
                //entities.SaveChanges();
                


            }
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
                    }
                }   
            }
            
        }

        //Update button
        private void button5_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Under construction!", "Add new item");
        }

        //dataGridView row select
        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            button4.Enabled= true;
        }
    }
}
