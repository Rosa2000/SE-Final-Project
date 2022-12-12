using Syncfusion.Pdf;
using Syncfusion.Pdf.Graphics;
using Syncfusion.Pdf.Grid;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Core.Common.CommandTrees;
using System.Data.Entity.Core.Common.CommandTrees.ExpressionBuilder;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Migrations;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Reflection.Emit;
using System.Runtime.CompilerServices;
using System.Windows.Forms;
using WindowsFormsApp;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ToolBar;

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

            //Lock window size
            this.FormBorderStyle = FormBorderStyle.FixedDialog;
            this.MaximumSize = this.Size;
            this.MinimumSize = this.Size;

            dt.Columns.Add("Goods Name", typeof(string));
            dt.Columns.Add("Quantity", typeof(int));
            dt.Columns.Add("Import Price", typeof(int));
            dt.Columns.Add("Total Value", typeof(long));

            dateTimePicker1.Format = DateTimePickerFormat.Custom;
            dateTimePicker1.CustomFormat = "MMMM yyyy";
            dateTimePicker1.ShowUpDown = true;

            button1.Enabled = false;
            button4.Enabled = false;
            button6.Enabled = false;

            if (dataGridView1.Rows.Count == 0)
            {
                label5.Text = "Total: 0";
                button1.Enabled = false;
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'supplementFactsDataSet.CustomerOrder' table. You can move, or remove it, as needed.
            this.customerOrderTableAdapter.Fill(this.supplementFactsDataSet.CustomerOrder);
            // TODO: This line of code loads data into the 'supplementFactsDataSet.Goods' table. You can move, or remove it, as needed.
            this.goodsTableAdapter.Fill(this.supplementFactsDataSet.Goods);
            // TODO: This line of code loads data into the 'supplementFactsDataSet.Receipt' table. You can move, or remove it, as needed.
            this.receiptTableAdapter.Fill(this.supplementFactsDataSet.Receipt);
            // TODO: This line of code loads data into the 'supplementFactsDataSet.Delivery' table. You can move, or remove it, as needed.
            this.deliveryTableAdapter.Fill(this.supplementFactsDataSet.Delivery);
            // TODO: This line of code loads data into the 'supplementFactsDataSet.Order' table. You can move, or remove it, as needed.
            this.orderTableAdapter.Fill(this.supplementFactsDataSet.Order);

            GoodsDataGridView();
            OrderDataGridView();
            ImportDataGridView();
            ExportDataGridView();
            BestSellersDataGridView();
        }

        #region goods received tab
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

                foreach (DataRow row in dt.Rows)
                {
                    if (comboBox1.Text == (string)row["Goods name"])
                    {
                        toDelete.Add(row);
                    }
                }

                foreach (DataRow row in toDelete)
                {
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

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            button4.Enabled = true;
        }

        void Clear()
        {
            label5.Text = "Total: ";

            button1.Enabled = false;
            button4.Enabled = false;
            textBox2.Text = string.Empty;

            dt.Rows.Clear();
        }

        #endregion

        #region goods list tab
        private void button2_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Under construction!", "Add new item");
        }

        void GoodsDataGridView()
        {
            var goodsList = context.Goods
                .Select(x => new { x.ID, x.name, x.importPrice, x.salePrice, x.stock }); ;
            dataGridView2.DataSource = goodsList.ToList();
        }

        #endregion

        #region agent order tab

        void OrderDataGridView()
        {
            dataGridView3.DataSource = context.Orders.ToList<Order>();
        }

        private void dataGridView3_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int rowIndex = e.RowIndex;
            if (rowIndex != -1)
            {
                var row = dataGridView3.Rows[rowIndex];
                int id = Convert.ToInt32(row.Cells[0].Value.ToString());

                var orderDetail = context.OrderDetails.Where(x => x.orderID == id)
                    .Select(x => new { x.orderID, x.goodsID, x.quantity, x.total }).ToList(); ;
                dataGridView4.DataSource = orderDetail.ToList();

                if (dataGridView3.Rows[rowIndex].Cells[7].Value.ToString() == "New")
                {
                    button6.Enabled = true;
                }
                else
                {
                    button6.Enabled = false;
                }
            }
        }

        private void dataGridView3_RowLeave(object sender, DataGridViewCellEventArgs e)
        {
            context.SaveChanges();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            //Get order ID
            var rowID = dataGridView4.Rows[0];
            int cellID = Convert.ToInt32(rowID.Cells[0].Value.ToString());
            var order = context.Orders.Where(x => x.ID == cellID).FirstOrDefault();
            int orderID = Convert.ToInt32(order.ID);

            //Get agent information
            string agentID = order.agentID.ToString();
            var agent = context.Agents.Where(x => x.ID == agentID).FirstOrDefault();

            //Get order detail
            var orderDetails = context.OrderDetails.Where(x => x.orderID == orderID);

            string agentName = agent.name.ToString();
            string agentAddress = agent.address.ToString();
            DateTime date = DateTime.Now;

            //Create new deli note
            context.Deliveries.Add(new Delivery()
            {
                createDate = date,
                orderID = orderID,
                status = "Pending",
            });

            //change status
            order.orderStatus = "Confirmed";

            //Save all changes
            context.SaveChanges();

            #region Create PDF file

            ////Create a new PDF document.
            PdfDocument document = new PdfDocument();
            document.PageSettings.Orientation = PdfPageOrientation.Landscape;
            document.PageSettings.Margins.All = 50;

            //Add a page to the document.
            PdfSection section = document.Sections.Add();
            section.PageSettings.Size = PdfPageSize.A3;
            PdfPage page = document.Pages.Add();

            //Create PDF graphics for the page.
            PdfGraphics graphics = page.Graphics;

            //Create a text element with the text and font.
            PdfTextElement element = new PdfTextElement("Yen Nhi Supplement Facts\n19 Nguyen Thi Thap Street,\nHo Chi Minh City,\nViet Nam.");
            element.Font = new PdfStandardFont(PdfFontFamily.TimesRoman, 12);
            element.Brush = new PdfSolidBrush(new PdfColor(89, 89, 93));
            PdfLayoutResult result = element.Draw
                (
                    page,
                    new RectangleF(0, 0,
                    page.Graphics.ClientSize.Width / 2, 200)
                );


            PdfImage img = new PdfBitmap("../../Logo.png");
            graphics.DrawImage(img, new RectangleF(graphics.ClientSize.Width - 200, result.Bounds.Y - 30, 130, 130));
            PdfFont subHeadingFont = new PdfStandardFont(PdfFontFamily.TimesRoman, 14);
            graphics.DrawRectangle
                (
                    new PdfSolidBrush
                    (
                        new PdfColor(126, 151, 173)),
                        new RectangleF(0,
                        result.Bounds.Bottom + 40,
                        graphics.ClientSize.Width, 30
                    )
                );

            //Create a text element with the text and font.
            element = new PdfTextElement("GOODS DELIVERY NOTE", subHeadingFont);
            element.Brush = PdfBrushes.White;
            result = element.Draw(page, new PointF(10, result.Bounds.Bottom + 48));
            string currentDate = "DATE " + DateTime.Now.ToString("MM/dd/yyyy");
            SizeF textSize = subHeadingFont.MeasureString(currentDate);
            graphics.DrawString
                (
                    currentDate,
                    subHeadingFont,
                    element.Brush,
                    new PointF(graphics.ClientSize.Width - textSize.Width - 10,
                    result.Bounds.Y)
                );

            //Create a text element and draw it to PDF page.
            element = new PdfTextElement("DELIVERY TO ", new PdfStandardFont(PdfFontFamily.TimesRoman, 10));
            element.Brush = new PdfSolidBrush(new PdfColor(126, 155, 203));
            result = element.Draw(page, new PointF(10, result.Bounds.Bottom + 25));
            graphics.DrawLine(new PdfPen(new PdfColor(126, 151, 173), 0.70f),
                    new PointF(0, result.Bounds.Bottom + 3),
                    new PointF(graphics.ClientSize.Width,
                    result.Bounds.Bottom + 3)
                );

            //Get products list to create note
            var orderDetailsWithName = context.OrderDetails
                                        .Where(x => x.orderID == orderID)
                                        .Join(
                                        context.Goods,
                                        g => g.goodsID,
                                        i => i.ID,
                                        (g, i) => new
                                        {
                                            goodsID = g.goodsID,
                                            name = i.name,
                                            price = i.salePrice,
                                            quantity = g.quantity,
                                            total = g.total
                                        }).ToList();

            //Create a text element and draw it to PDF page.
            element = new PdfTextElement(agentName, new PdfStandardFont(PdfFontFamily.TimesRoman, 10));
            element.Brush = new PdfSolidBrush(new PdfColor(89, 89, 93));
            result = element.Draw(page, new RectangleF(10, result.Bounds.Bottom + 5, graphics.ClientSize.Width / 2, 100));

            //Create a text element and draw it to PDF page.
            element = new PdfTextElement(agentAddress, new PdfStandardFont(PdfFontFamily.TimesRoman, 10));
            element.Brush = new PdfSolidBrush(new PdfColor(89, 89, 93));
            result = element.Draw(page, new RectangleF(10, result.Bounds.Bottom + 3, graphics.ClientSize.Width / 2, 100));

            //Create a PDF grid with product details.
            PdfGrid grid = new PdfGrid();
            grid.DataSource = orderDetailsWithName;

            //Initialize PdfGridCellStyle and set border color.
            PdfGridCellStyle cellStyle = new PdfGridCellStyle();
            cellStyle.Borders.All = PdfPens.White;
            cellStyle.Borders.Bottom = new PdfPen(new PdfColor(217, 217, 217), 0.70f);
            cellStyle.Font = new PdfStandardFont(PdfFontFamily.TimesRoman, 12f);
            cellStyle.TextBrush = new PdfSolidBrush(new PdfColor(131, 130, 136));

            //Initialize PdfGridCellStyle and set header style.
            PdfGridCellStyle headerStyle = new PdfGridCellStyle();
            headerStyle.Borders.All = new PdfPen(new PdfColor(126, 151, 173));
            headerStyle.BackgroundBrush = new PdfSolidBrush(new PdfColor(126, 151, 173));
            headerStyle.TextBrush = PdfBrushes.White;
            headerStyle.Font = new PdfStandardFont(PdfFontFamily.TimesRoman, 14f, PdfFontStyle.Regular);

            PdfGridRow header = grid.Headers[0];
            var headers = new List<string>()
                            {
                            "Goods ID",
                            "Goods Name",
                            "Unit Price",
                            "Quantity",
                            "Total"
                            };
            for (int i = 0; i < header.Cells.Count; i++)
            {
                grid.Headers[0].Cells[i].Value = headers[i];
            }

            //PdfGridRow header = List<headers>;
            for (int i = 0; i < header.Cells.Count; i++)
            {
                if (i == 4)
                    header.Cells[i].StringFormat = new PdfStringFormat(PdfTextAlignment.Right, PdfVerticalAlignment.Middle);
                else
                    header.Cells[i].StringFormat = new PdfStringFormat(PdfTextAlignment.Left, PdfVerticalAlignment.Middle);
            }
            header.ApplyStyle(headerStyle);

            foreach (PdfGridRow row in grid.Rows)
            {
                row.ApplyStyle(cellStyle);
                for (int i = 0; i < row.Cells.Count; i++)
                {
                    //Create and customize the string formats
                    PdfGridCell cell = row.Cells[i];
                    if (i == 4)
                        cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Right, PdfVerticalAlignment.Middle);
                    else if (i == 3)
                        cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Center, PdfVerticalAlignment.Middle);
                    else
                        cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Left, PdfVerticalAlignment.Middle);

                    if (i > 1)
                    {
                        float val = float.MinValue;
                        float.TryParse(cell.Value.ToString(), out val);
                        cell.Value = string.Format("{0:N0}", val);
                    }
                }
            }

            grid.Columns[0].Width = 70;
            grid.Columns[2].Width = 70;
            grid.Columns[3].Width = 70;
            grid.Columns[4].Width = 80;

            //Set properties to paginate the grid.
            PdfGridLayoutFormat layoutFormat = new PdfGridLayoutFormat();
            layoutFormat.Layout = PdfLayoutType.Paginate;

            //Draw grid to the page of PDF document.
            PdfGridLayoutResult gridResult = grid.Draw
                (
                    page,
                    new RectangleF(new PointF(0, result.Bounds.Bottom + 40),
                    new SizeF(graphics.ClientSize.Width, graphics.ClientSize.Height - 100)),
                    layoutFormat
                );
            float pos = 0.0f;
            for (int i = 0; i < grid.Columns.Count - 1; i++)
                pos += grid.Columns[i].Width;

            PdfFont font12 = new PdfStandardFont(PdfFontFamily.TimesRoman, 12f);
            PdfFont font16 = new PdfStandardFont(PdfFontFamily.TimesRoman, 16f);

            //GetTotalPrice;
            long discount = 0;
            int discountPercent = (int)agent.discount;
            long total = (long)Convert.ToDouble(order.total);
            discount = (total * discountPercent) / 100;

            gridResult.Page.Graphics.DrawString
                (
                    "Sub-Total",
                    font12,
                    new PdfSolidBrush(new PdfColor(126, 151, 173)),
                    new RectangleF(new PointF(pos - 10, gridResult.Bounds.Bottom + 20),
                    new SizeF(grid.Columns[2].Width - pos, 20)),
                    new PdfStringFormat(PdfTextAlignment.Right)
                );
            gridResult.Page.Graphics.DrawString
                (
                    "Discount",
                    font12,
                    new PdfSolidBrush(new PdfColor(126, 151, 173)),
                    new RectangleF(new PointF(pos - 10, gridResult.Bounds.Bottom + 40),
                    new SizeF(grid.Columns[2].Width - pos, 20)),
                    new PdfStringFormat(PdfTextAlignment.Right)
                );
            gridResult.Page.Graphics.DrawString
                (
                    "Total",
                    font16,
                    new PdfSolidBrush(new PdfColor(126, 151, 173)),
                    new RectangleF(new PointF(pos - 10, gridResult.Bounds.Bottom + 60),
                    new SizeF(grid.Columns[2].Width - pos, 20)),
                    new PdfStringFormat(PdfTextAlignment.Right)
                );
            gridResult.Page.Graphics.DrawString
                (
                    "Thank you for your business!",
                    new PdfStandardFont(PdfFontFamily.TimesRoman, 12),
                    new PdfSolidBrush(new PdfColor(89, 89, 93)),
                    new PointF(pos - 70, gridResult.Bounds.Bottom + 100)
                );
            pos += grid.Columns[2].Width;
            gridResult.Page.Graphics.DrawString
                (
                    string.Format("{0:N0}", total),
                    font12,
                    new PdfSolidBrush(new PdfColor(131, 130, 136)),
                    new RectangleF(new PointF(pos, gridResult.Bounds.Bottom + 20),
                    new SizeF(grid.Columns[2].Width - pos, 20)),
                    new PdfStringFormat(PdfTextAlignment.Right)
                );
            gridResult.Page.Graphics.DrawString
                (
                    string.Format("{0:N0}", discount),
                    font12,
                    new PdfSolidBrush(new PdfColor(131, 130, 136)),
                    new RectangleF(new PointF(pos, gridResult.Bounds.Bottom + 40),
                    new SizeF(grid.Columns[2].Width - pos, 20)),
                    new PdfStringFormat(PdfTextAlignment.Right)
                );
            gridResult.Page.Graphics.DrawString
                (
                    string.Format("{0:N0}", total - discount),
                    font16,
                    new PdfSolidBrush(new PdfColor(131, 130, 136)),
                    new RectangleF(new PointF(pos, gridResult.Bounds.Bottom + 60),
                    new SizeF(grid.Columns[2].Width - pos, 20)),
                    new PdfStringFormat(PdfTextAlignment.Right)
                );

            //Save and closes the document. 
            document.Save("InvoicePDF.pdf");
            document.Close(true);

            //This will open the PDF file so, the result will be seen in default PDF Viewer.
            //Process.Start("InvoicePDF.pdf");

            #endregion

            MessageBox.Show("SUCCESS!", "Create and Print Goods Delivery Note");
        }

        #endregion

        #region deli list tab
        private void dataGridView5_RowLeave(object sender, DataGridViewCellEventArgs e)
        {
            context.SaveChanges();
        }

        #endregion

        #region stat tab

        void ImportDataGridView()
        {
            long total = 0;
            var receptList = context.Receipts
                /*.Select(x => new { x.ID, x.createDate, x.total })*/;
            foreach (var receipt in receptList)
            {
                total += (long)receipt.total;
            }
            dataGridView6.DataSource = receptList.ToList();
            label12.Text = "Total: " + total;
        }

        void ExportDataGridView()
        {
            long total = 0;
            var orderList = context.Orders
                .Select(x => new { x.ID, x.createDate, x.agentID, x.discount, x.total });
            foreach (var order in orderList)
            {
                total += (long)order.total;
            }
            dataGridView7.DataSource = orderList.ToList();
            label15.Text = "Total: " + total;
        }

        void BestSellersDataGridView()
        {
            //load best seller datagrid view
            var bestSellerQuery = context.Goods
               .Select(x => new { x.ID, x.name, x.importPrice, x.salePrice });
            dataGridView8.DataSource = bestSellerQuery.ToList();

            //add sold collumn to datagrid view    
            var orderList = context.Orders.ToList();
            foreach (var item in orderList)
            {
                int orderID = item.ID;
                var orderDetailQuery = context.OrderDetails
                    .Where(x => x.orderID == orderID)
                    .Select(x => new { x.goodsID, x.quantity }).ToList();

                foreach (var detail in orderDetailQuery)
                {
                    string goodsID = detail.goodsID;
                    int quantity = (int)detail.quantity;

                    foreach (DataGridViewRow row in dataGridView8.Rows)
                    {
                        int rowIndex = row.Index;
                        foreach (DataGridViewCell cell in row.Cells)
                        {
                            if (cell.Value == null)
                            {
                                cell.Value = 0;
                            }
                        }

                        if (dataGridView8.Rows[rowIndex].Cells[0].Value.ToString() == goodsID)
                        {
                            int old = (int)dataGridView8.Rows[rowIndex].Cells[4].Value;
                            dataGridView8.Rows[rowIndex].Cells[4].Value = old + quantity;
                        }
                    }
                }
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            var month = dateTimePicker1.Value.Month;
            var year = dateTimePicker1.Value.Year;
            long exTotal = 0;
            long imTotal = 0;
            BestSellersDataGridView();

            //Import by month
            var importByMonth = context.Receipts
                .Where(x => x.createDate.Value.Month == month && x.createDate.Value.Year == year)
                .ToList();
            dataGridView6.DataSource = importByMonth;

            foreach (var item in importByMonth)
            {
                imTotal += (long)item.total;
            }
            label12.Text = "Total: " + imTotal.ToString();

            //Export by month
            var exportByMonth = context.Orders
                .Where(x => x.createDate.Value.Month == month && x.createDate.Value.Year == year)
                .ToList();
            dataGridView7.DataSource = exportByMonth;

            foreach (var item in exportByMonth)
            {
                exTotal += (long)item.total;
            }
            label15.Text = "Total: " + exTotal.ToString();

            //Best sellers
            foreach (DataGridViewRow row in dataGridView8.Rows)
            {
                foreach (DataGridViewCell cell in row.Cells)
                {
                    cell.Value = 0;
                }
            }

            foreach (var item in exportByMonth)
            {
                int orderID = item.ID;
                var orderDetailQuery = context.OrderDetails
                    .Where(x => x.orderID == orderID)
                    .Select(x => new { x.goodsID, x.quantity }).ToList();

                foreach (var detail in orderDetailQuery)
                {
                    string goodsID = detail.goodsID;
                    int quantity = (int)detail.quantity;
                    int rowIndex = 0;

                    foreach (DataGridViewRow row in dataGridView8.Rows)
                    {
                        foreach (DataGridViewCell cell in row.Cells)
                        {
                            if (cell.Value.ToString() == goodsID)
                            {
                                rowIndex = row.Index;
                                int old = (int)dataGridView8.Rows[rowIndex].Cells[4].Value;
                                dataGridView8.Rows[rowIndex].Cells[4].Value = old + quantity;
                            }
                        }
                    }
                }
            }
        }

        //Clear Button
        private void button7_Click(object sender, EventArgs e)
        {
            ImportDataGridView();
            ExportDataGridView();
            BestSellersDataGridView();
        }
        #endregion

        private void Form1_Load_1(object sender, EventArgs e)
        {


        }
    }
}
