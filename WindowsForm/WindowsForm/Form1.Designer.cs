namespace WindowsForm
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.goodsDeliTab = new System.Windows.Forms.TabPage();
            this.statisticTab = new System.Windows.Forms.TabPage();
            this.label8 = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.comboBox1 = new System.Windows.Forms.ComboBox();
            this.goodsBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.supplementFactsDataSet = new WindowsForm.SupplementFactsDataSet();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.goodsListTab = new System.Windows.Forms.TabPage();
            this.goodsReceivedTab = new System.Windows.Forms.TabPage();
            this.label5 = new System.Windows.Forms.Label();
            this.button5 = new System.Windows.Forms.Button();
            this.button4 = new System.Windows.Forms.Button();
            this.label9 = new System.Windows.Forms.Label();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.button3 = new System.Windows.Forms.Button();
            this.goodsTableAdapter = new WindowsForm.SupplementFactsDataSetTableAdapters.GoodsTableAdapter();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.goodsBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.supplementFactsDataSet)).BeginInit();
            this.tabControl1.SuspendLayout();
            this.goodsReceivedTab.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // goodsDeliTab
            // 
            this.goodsDeliTab.Font = new System.Drawing.Font("Times New Roman", 12.22642F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.goodsDeliTab.Location = new System.Drawing.Point(4, 32);
            this.goodsDeliTab.Name = "goodsDeliTab";
            this.goodsDeliTab.Padding = new System.Windows.Forms.Padding(3);
            this.goodsDeliTab.Size = new System.Drawing.Size(1255, 722);
            this.goodsDeliTab.TabIndex = 1;
            this.goodsDeliTab.Text = "Goods Delivery";
            this.goodsDeliTab.UseVisualStyleBackColor = true;
            // 
            // statisticTab
            // 
            this.statisticTab.Font = new System.Drawing.Font("Times New Roman", 12.22642F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.statisticTab.Location = new System.Drawing.Point(4, 32);
            this.statisticTab.Name = "statisticTab";
            this.statisticTab.Padding = new System.Windows.Forms.Padding(3);
            this.statisticTab.Size = new System.Drawing.Size(1255, 722);
            this.statisticTab.TabIndex = 2;
            this.statisticTab.Text = "Statistic";
            this.statisticTab.UseVisualStyleBackColor = true;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Times New Roman", 12.22642F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label8.Location = new System.Drawing.Point(54, 114);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(77, 21);
            this.label8.TabIndex = 18;
            this.label8.Text = "Quantity:";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(1112, 585);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(83, 38);
            this.button1.TabIndex = 2;
            this.button1.Text = "Create";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // label1
            // 
            this.label1.Font = new System.Drawing.Font("Times New Roman", 16.30189F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(501, 41);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(245, 50);
            this.label1.TabIndex = 0;
            this.label1.Text = "Goods Received Note";
            // 
            // groupBox1
            // 
            this.groupBox1.BackColor = System.Drawing.Color.LightGray;
            this.groupBox1.Controls.Add(this.comboBox1);
            this.groupBox1.Controls.Add(this.label8);
            this.groupBox1.Controls.Add(this.textBox2);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Location = new System.Drawing.Point(28, 97);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(1045, 215);
            this.groupBox1.TabIndex = 7;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Add Product";
            // 
            // comboBox1
            // 
            this.comboBox1.DataSource = this.goodsBindingSource;
            this.comboBox1.DisplayMember = "name";
            this.comboBox1.FormattingEnabled = true;
            this.comboBox1.Location = new System.Drawing.Point(177, 48);
            this.comboBox1.Name = "comboBox1";
            this.comboBox1.Size = new System.Drawing.Size(766, 28);
            this.comboBox1.TabIndex = 19;
            this.comboBox1.ValueMember = "name";
            this.comboBox1.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);
            this.comboBox1.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.comboBox1_KeyPress);
            // 
            // goodsBindingSource
            // 
            this.goodsBindingSource.DataMember = "Goods";
            this.goodsBindingSource.DataSource = this.supplementFactsDataSet;
            // 
            // supplementFactsDataSet
            // 
            this.supplementFactsDataSet.DataSetName = "SupplementFactsDataSet";
            this.supplementFactsDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // textBox2
            // 
            this.textBox2.Font = new System.Drawing.Font("Times New Roman", 12.22642F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBox2.Location = new System.Drawing.Point(177, 110);
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new System.Drawing.Size(298, 28);
            this.textBox2.TabIndex = 7;
            this.textBox2.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.textBox2_KeyPress);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Times New Roman", 12.22642F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(49, 51);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(122, 21);
            this.label2.TabIndex = 6;
            this.label2.Text = "Product Name:";
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.goodsReceivedTab);
            this.tabControl1.Controls.Add(this.goodsListTab);
            this.tabControl1.Controls.Add(this.goodsDeliTab);
            this.tabControl1.Controls.Add(this.statisticTab);
            this.tabControl1.Font = new System.Drawing.Font("Times New Roman", 14.26415F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tabControl1.Location = new System.Drawing.Point(1, 0);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(1263, 758);
            this.tabControl1.TabIndex = 1;
            // 
            // goodsListTab
            // 
            this.goodsListTab.Font = new System.Drawing.Font("Times New Roman", 12.22642F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.goodsListTab.Location = new System.Drawing.Point(4, 32);
            this.goodsListTab.Name = "goodsListTab";
            this.goodsListTab.Padding = new System.Windows.Forms.Padding(3);
            this.goodsListTab.Size = new System.Drawing.Size(1255, 722);
            this.goodsListTab.TabIndex = 3;
            this.goodsListTab.Text = "Goods List";
            this.goodsListTab.UseVisualStyleBackColor = true;
            // 
            // goodsReceivedTab
            // 
            this.goodsReceivedTab.Controls.Add(this.label5);
            this.goodsReceivedTab.Controls.Add(this.button5);
            this.goodsReceivedTab.Controls.Add(this.button4);
            this.goodsReceivedTab.Controls.Add(this.label9);
            this.goodsReceivedTab.Controls.Add(this.dataGridView1);
            this.goodsReceivedTab.Controls.Add(this.button3);
            this.goodsReceivedTab.Controls.Add(this.button1);
            this.goodsReceivedTab.Controls.Add(this.label1);
            this.goodsReceivedTab.Controls.Add(this.groupBox1);
            this.goodsReceivedTab.Font = new System.Drawing.Font("Times New Roman", 12.22642F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.goodsReceivedTab.Location = new System.Drawing.Point(4, 32);
            this.goodsReceivedTab.Name = "goodsReceivedTab";
            this.goodsReceivedTab.Padding = new System.Windows.Forms.Padding(3);
            this.goodsReceivedTab.Size = new System.Drawing.Size(1255, 722);
            this.goodsReceivedTab.TabIndex = 0;
            this.goodsReceivedTab.Text = "Goods Received";
            this.goodsReceivedTab.UseVisualStyleBackColor = true;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Times New Roman", 14.26415F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(576, 352);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(61, 24);
            this.label5.TabIndex = 19;
            this.label5.Text = "Total:";
            // 
            // button5
            // 
            this.button5.Location = new System.Drawing.Point(1112, 211);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(83, 40);
            this.button5.TabIndex = 12;
            this.button5.Text = "Update";
            this.button5.UseVisualStyleBackColor = true;
            // 
            // button4
            // 
            this.button4.Location = new System.Drawing.Point(1112, 521);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(83, 47);
            this.button4.TabIndex = 11;
            this.button4.Text = "Remove";
            this.button4.UseVisualStyleBackColor = true;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Times New Roman", 14.26415F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.Location = new System.Drawing.Point(50, 352);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(149, 24);
            this.label9.TabIndex = 10;
            this.label9.Text = "List of products";
            // 
            // dataGridView1
            // 
            this.dataGridView1.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(28, 395);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowHeadersWidth = 150;
            this.dataGridView1.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.dataGridView1.Size = new System.Drawing.Size(1045, 329);
            this.dataGridView1.TabIndex = 9;
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(1112, 148);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(83, 37);
            this.button3.TabIndex = 4;
            this.button3.Text = "Add";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // goodsTableAdapter
            // 
            this.goodsTableAdapter.ClearBeforeFill = true;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1264, 759);
            this.Controls.Add(this.tabControl1);
            this.Name = "Form1";
            this.Text = "Supplement Facts";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.goodsBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.supplementFactsDataSet)).EndInit();
            this.tabControl1.ResumeLayout(false);
            this.goodsReceivedTab.ResumeLayout(false);
            this.goodsReceivedTab.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TabPage goodsDeliTab;
        private System.Windows.Forms.TabPage statisticTab;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage goodsReceivedTab;
        private System.Windows.Forms.Button button5;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TabPage goodsListTab;
        private System.Windows.Forms.ComboBox comboBox1;
        private SupplementFactsDataSet supplementFactsDataSet;
        private System.Windows.Forms.BindingSource goodsBindingSource;
        private SupplementFactsDataSetTableAdapters.GoodsTableAdapter goodsTableAdapter;
    }
}

