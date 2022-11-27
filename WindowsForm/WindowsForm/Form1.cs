using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
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
        SupplementFactsEntities se = new SupplementFactsEntities();
        Receipt receipt = new Receipt();
        Goods goods = new Goods();
        DataTable dt = new DataTable();

        public Form1()
        {
            InitializeComponent();

            dt.Columns.Add("No.", typeof(string));
            dt.Columns.Add("Product Name", typeof(string));
            dt.Columns.Add("Quantity", typeof(int));
            dt.Columns.Add("Import Unit Price", typeof(int));
            dt.Columns.Add("Total Amount", typeof(int));

            dataGridView1.RowHeadersVisible = false;
            dataGridView2.RowHeadersVisible= false;

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
                goods = se.Goods.Where(x => x.name == @goodsName).FirstOrDefault();
                goodsName = goods.name;
                Int32 quantity = Convert.ToInt32(textBox2.Text);
                decimal importUnitPrice = (decimal)goods.importPrice;
                decimal totalAmount = quantity* importUnitPrice;
                int rowNumber;
                try
                {
                    rowNumber = dt.Rows.Count;
                }
                catch
                {
                    rowNumber = 0;
                }
                int goodsRowNumber = rowNumber + 1;
                int total = 0;

                //Add product to list
                dt.Rows.Add(goodsRowNumber, goodsName, quantity, importUnitPrice, totalAmount);
                dataGridView1.DataSource = dt;

                foreach (DataRow row in dt.Rows)
                {
                    total += (int)row["Total Amount"];
                    label5.Text = "Total: " + total;
                }
            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

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

        }

        private void button4_Click(object sender, EventArgs e)
        {

        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void button5_Click(object sender, EventArgs e)
        {

        }
    }
}
