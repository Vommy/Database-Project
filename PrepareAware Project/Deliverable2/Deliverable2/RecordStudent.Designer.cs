namespace Deliverable2
{
    partial class RecordStudent
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
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.createClassToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.searchClassesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.viewStatisticsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.label1 = new System.Windows.Forms.Label();
            this.buttonSearch = new System.Windows.Forms.Button();
            this.groupBoxStudentForm = new System.Windows.Forms.GroupBox();
            this.groupBoxGradeForm = new System.Windows.Forms.GroupBox();
            this.buttonSubmit = new System.Windows.Forms.Button();
            this.buttonClear = new System.Windows.Forms.Button();
            this.label7 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.numericUpDownGrade = new System.Windows.Forms.NumericUpDown();
            this.comboBoxClasses = new System.Windows.Forms.ComboBox();
            this.buttonClearRegister = new System.Windows.Forms.Button();
            this.buttonRegister = new System.Windows.Forms.Button();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.textBoxStudentLname = new System.Windows.Forms.TextBox();
            this.textBoxStudentPN = new System.Windows.Forms.TextBox();
            this.textBoxStudentEmail = new System.Windows.Forms.TextBox();
            this.textBoxStudentFname = new System.Windows.Forms.TextBox();
            this.comboBoxSearch = new System.Windows.Forms.ComboBox();
            this.labelResult = new System.Windows.Forms.Label();
            this.labelFnameError = new System.Windows.Forms.Label();
            this.labelSnameError = new System.Windows.Forms.Label();
            this.labelEmailError = new System.Windows.Forms.Label();
            this.labelPNError = new System.Windows.Forms.Label();
            this.menuStrip1.SuspendLayout();
            this.groupBoxStudentForm.SuspendLayout();
            this.groupBoxGradeForm.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDownGrade)).BeginInit();
            this.SuspendLayout();
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(800, 24);
            this.menuStrip1.TabIndex = 0;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // fileToolStripMenuItem
            // 
            this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.createClassToolStripMenuItem,
            this.searchClassesToolStripMenuItem,
            this.viewStatisticsToolStripMenuItem});
            this.fileToolStripMenuItem.Font = new System.Drawing.Font("Courier New", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
            this.fileToolStripMenuItem.Size = new System.Drawing.Size(47, 20);
            this.fileToolStripMenuItem.Text = "File";
            // 
            // createClassToolStripMenuItem
            // 
            this.createClassToolStripMenuItem.Name = "createClassToolStripMenuItem";
            this.createClassToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)(((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.Alt) 
            | System.Windows.Forms.Keys.C)));
            this.createClassToolStripMenuItem.Size = new System.Drawing.Size(277, 22);
            this.createClassToolStripMenuItem.Text = "&Create Class...";
            this.createClassToolStripMenuItem.Click += new System.EventHandler(this.createClassToolStripMenuItem_Click);
            // 
            // searchClassesToolStripMenuItem
            // 
            this.searchClassesToolStripMenuItem.Name = "searchClassesToolStripMenuItem";
            this.searchClassesToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)(((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.Alt) 
            | System.Windows.Forms.Keys.S)));
            this.searchClassesToolStripMenuItem.Size = new System.Drawing.Size(277, 22);
            this.searchClassesToolStripMenuItem.Text = "&Search Classes...";
            this.searchClassesToolStripMenuItem.Click += new System.EventHandler(this.searchClassesToolStripMenuItem_Click);
            // 
            // viewStatisticsToolStripMenuItem
            // 
            this.viewStatisticsToolStripMenuItem.Name = "viewStatisticsToolStripMenuItem";
            this.viewStatisticsToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)(((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.Alt) 
            | System.Windows.Forms.Keys.V)));
            this.viewStatisticsToolStripMenuItem.Size = new System.Drawing.Size(277, 22);
            this.viewStatisticsToolStripMenuItem.Text = "&View Statistics...";
            this.viewStatisticsToolStripMenuItem.Click += new System.EventHandler(this.viewStatisticsToolStripMenuItem_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Courier New", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(184, 36);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(446, 31);
            this.label1.TabIndex = 1;
            this.label1.Text = "PrepareAware Student Record";
            // 
            // buttonSearch
            // 
            this.buttonSearch.Font = new System.Drawing.Font("Courier New", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonSearch.Location = new System.Drawing.Point(560, 72);
            this.buttonSearch.Name = "buttonSearch";
            this.buttonSearch.Size = new System.Drawing.Size(69, 22);
            this.buttonSearch.TabIndex = 1;
            this.buttonSearch.Text = "Search";
            this.buttonSearch.UseVisualStyleBackColor = true;
            this.buttonSearch.Click += new System.EventHandler(this.buttonSearch_Click);
            // 
            // groupBoxStudentForm
            // 
            this.groupBoxStudentForm.Controls.Add(this.labelPNError);
            this.groupBoxStudentForm.Controls.Add(this.labelEmailError);
            this.groupBoxStudentForm.Controls.Add(this.labelSnameError);
            this.groupBoxStudentForm.Controls.Add(this.labelFnameError);
            this.groupBoxStudentForm.Controls.Add(this.groupBoxGradeForm);
            this.groupBoxStudentForm.Controls.Add(this.buttonClearRegister);
            this.groupBoxStudentForm.Controls.Add(this.buttonRegister);
            this.groupBoxStudentForm.Controls.Add(this.label5);
            this.groupBoxStudentForm.Controls.Add(this.label4);
            this.groupBoxStudentForm.Controls.Add(this.label3);
            this.groupBoxStudentForm.Controls.Add(this.label2);
            this.groupBoxStudentForm.Controls.Add(this.textBoxStudentLname);
            this.groupBoxStudentForm.Controls.Add(this.textBoxStudentPN);
            this.groupBoxStudentForm.Controls.Add(this.textBoxStudentEmail);
            this.groupBoxStudentForm.Controls.Add(this.textBoxStudentFname);
            this.groupBoxStudentForm.Font = new System.Drawing.Font("Courier New", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBoxStudentForm.Location = new System.Drawing.Point(12, 118);
            this.groupBoxStudentForm.Name = "groupBoxStudentForm";
            this.groupBoxStudentForm.Size = new System.Drawing.Size(776, 330);
            this.groupBoxStudentForm.TabIndex = 4;
            this.groupBoxStudentForm.TabStop = false;
            this.groupBoxStudentForm.Text = "Student Form";
            // 
            // groupBoxGradeForm
            // 
            this.groupBoxGradeForm.Controls.Add(this.buttonSubmit);
            this.groupBoxGradeForm.Controls.Add(this.buttonClear);
            this.groupBoxGradeForm.Controls.Add(this.label7);
            this.groupBoxGradeForm.Controls.Add(this.label6);
            this.groupBoxGradeForm.Controls.Add(this.numericUpDownGrade);
            this.groupBoxGradeForm.Controls.Add(this.comboBoxClasses);
            this.groupBoxGradeForm.Font = new System.Drawing.Font("Courier New", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBoxGradeForm.Location = new System.Drawing.Point(399, 45);
            this.groupBoxGradeForm.Name = "groupBoxGradeForm";
            this.groupBoxGradeForm.Size = new System.Drawing.Size(364, 249);
            this.groupBoxGradeForm.TabIndex = 8;
            this.groupBoxGradeForm.TabStop = false;
            this.groupBoxGradeForm.Text = "Student Grade Form";
            // 
            // buttonSubmit
            // 
            this.buttonSubmit.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonSubmit.Location = new System.Drawing.Point(196, 204);
            this.buttonSubmit.Name = "buttonSubmit";
            this.buttonSubmit.Size = new System.Drawing.Size(107, 23);
            this.buttonSubmit.TabIndex = 12;
            this.buttonSubmit.Text = "Submit";
            this.buttonSubmit.UseVisualStyleBackColor = true;
            this.buttonSubmit.Click += new System.EventHandler(this.buttonSubmit_Click);
            // 
            // buttonClear
            // 
            this.buttonClear.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonClear.Location = new System.Drawing.Point(71, 204);
            this.buttonClear.Name = "buttonClear";
            this.buttonClear.Size = new System.Drawing.Size(107, 23);
            this.buttonClear.TabIndex = 11;
            this.buttonClear.Text = "Clear";
            this.buttonClear.UseVisualStyleBackColor = true;
            this.buttonClear.Click += new System.EventHandler(this.button3_Click);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(41, 128);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(103, 16);
            this.label7.TabIndex = 4;
            this.label7.Text = "Mark (/100):";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(17, 78);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(127, 16);
            this.label6.TabIndex = 3;
            this.label6.Text = "Class Attended:";
            // 
            // numericUpDownGrade
            // 
            this.numericUpDownGrade.DecimalPlaces = 1;
            this.numericUpDownGrade.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.numericUpDownGrade.Increment = new decimal(new int[] {
            1,
            0,
            0,
            65536});
            this.numericUpDownGrade.Location = new System.Drawing.Point(150, 126);
            this.numericUpDownGrade.Name = "numericUpDownGrade";
            this.numericUpDownGrade.Size = new System.Drawing.Size(69, 22);
            this.numericUpDownGrade.TabIndex = 10;
            // 
            // comboBoxClasses
            // 
            this.comboBoxClasses.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBoxClasses.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.comboBoxClasses.FormattingEnabled = true;
            this.comboBoxClasses.Location = new System.Drawing.Point(150, 74);
            this.comboBoxClasses.Name = "comboBoxClasses";
            this.comboBoxClasses.Size = new System.Drawing.Size(192, 24);
            this.comboBoxClasses.TabIndex = 9;
            // 
            // buttonClearRegister
            // 
            this.buttonClearRegister.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonClearRegister.Location = new System.Drawing.Point(131, 249);
            this.buttonClearRegister.Name = "buttonClearRegister";
            this.buttonClearRegister.Size = new System.Drawing.Size(68, 23);
            this.buttonClearRegister.TabIndex = 6;
            this.buttonClearRegister.Text = "Clear";
            this.buttonClearRegister.UseVisualStyleBackColor = true;
            this.buttonClearRegister.Click += new System.EventHandler(this.buttonClearRegister_Click);
            // 
            // buttonRegister
            // 
            this.buttonRegister.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonRegister.Location = new System.Drawing.Point(205, 249);
            this.buttonRegister.Name = "buttonRegister";
            this.buttonRegister.Size = new System.Drawing.Size(108, 23);
            this.buttonRegister.TabIndex = 7;
            this.buttonRegister.Text = "Register";
            this.buttonRegister.UseVisualStyleBackColor = true;
            this.buttonRegister.Click += new System.EventHandler(this.buttonRegister_Click);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(6, 202);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(119, 16);
            this.label5.TabIndex = 7;
            this.label5.Text = "Phone Number: ";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(46, 150);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(79, 16);
            this.label4.TabIndex = 6;
            this.label4.Text = "Email* : ";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(30, 97);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(95, 16);
            this.label3.TabIndex = 5;
            this.label3.Text = "Surname* : ";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(14, 49);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(111, 16);
            this.label2.TabIndex = 4;
            this.label2.Text = "Firstname* : ";
            // 
            // textBoxStudentLname
            // 
            this.textBoxStudentLname.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBoxStudentLname.Location = new System.Drawing.Point(131, 93);
            this.textBoxStudentLname.Name = "textBoxStudentLname";
            this.textBoxStudentLname.ReadOnly = true;
            this.textBoxStudentLname.Size = new System.Drawing.Size(182, 22);
            this.textBoxStudentLname.TabIndex = 3;
            // 
            // textBoxStudentPN
            // 
            this.textBoxStudentPN.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBoxStudentPN.Location = new System.Drawing.Point(131, 198);
            this.textBoxStudentPN.Name = "textBoxStudentPN";
            this.textBoxStudentPN.ReadOnly = true;
            this.textBoxStudentPN.Size = new System.Drawing.Size(182, 22);
            this.textBoxStudentPN.TabIndex = 5;
            // 
            // textBoxStudentEmail
            // 
            this.textBoxStudentEmail.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBoxStudentEmail.Location = new System.Drawing.Point(131, 146);
            this.textBoxStudentEmail.Name = "textBoxStudentEmail";
            this.textBoxStudentEmail.ReadOnly = true;
            this.textBoxStudentEmail.Size = new System.Drawing.Size(182, 22);
            this.textBoxStudentEmail.TabIndex = 4;
            // 
            // textBoxStudentFname
            // 
            this.textBoxStudentFname.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBoxStudentFname.Location = new System.Drawing.Point(131, 45);
            this.textBoxStudentFname.Name = "textBoxStudentFname";
            this.textBoxStudentFname.ReadOnly = true;
            this.textBoxStudentFname.Size = new System.Drawing.Size(182, 22);
            this.textBoxStudentFname.TabIndex = 2;
            this.textBoxStudentFname.TextChanged += new System.EventHandler(this.textBox1_TextChanged);
            // 
            // comboBoxSearch
            // 
            this.comboBoxSearch.Font = new System.Drawing.Font("Courier New", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.comboBoxSearch.FormattingEnabled = true;
            this.comboBoxSearch.Location = new System.Drawing.Point(190, 72);
            this.comboBoxSearch.Name = "comboBoxSearch";
            this.comboBoxSearch.Size = new System.Drawing.Size(364, 22);
            this.comboBoxSearch.TabIndex = 0;
            this.comboBoxSearch.Text = "Search Student Email...";
            // 
            // labelResult
            // 
            this.labelResult.AutoSize = true;
            this.labelResult.Font = new System.Drawing.Font("Courier New", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelResult.Location = new System.Drawing.Point(187, 97);
            this.labelResult.Name = "labelResult";
            this.labelResult.Size = new System.Drawing.Size(49, 14);
            this.labelResult.TabIndex = 10;
            this.labelResult.Text = "label8";
            // 
            // labelFnameError
            // 
            this.labelFnameError.AutoSize = true;
            this.labelFnameError.Font = new System.Drawing.Font("Courier New", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelFnameError.ForeColor = System.Drawing.Color.Red;
            this.labelFnameError.Location = new System.Drawing.Point(131, 26);
            this.labelFnameError.Name = "labelFnameError";
            this.labelFnameError.Size = new System.Drawing.Size(49, 14);
            this.labelFnameError.TabIndex = 10;
            this.labelFnameError.Text = "label8";
            // 
            // labelSnameError
            // 
            this.labelSnameError.AutoSize = true;
            this.labelSnameError.Font = new System.Drawing.Font("Courier New", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelSnameError.ForeColor = System.Drawing.Color.Red;
            this.labelSnameError.Location = new System.Drawing.Point(131, 76);
            this.labelSnameError.Name = "labelSnameError";
            this.labelSnameError.Size = new System.Drawing.Size(49, 14);
            this.labelSnameError.TabIndex = 11;
            this.labelSnameError.Text = "label8";
            // 
            // labelEmailError
            // 
            this.labelEmailError.AutoSize = true;
            this.labelEmailError.Font = new System.Drawing.Font("Courier New", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelEmailError.ForeColor = System.Drawing.Color.Red;
            this.labelEmailError.Location = new System.Drawing.Point(131, 129);
            this.labelEmailError.Name = "labelEmailError";
            this.labelEmailError.Size = new System.Drawing.Size(49, 14);
            this.labelEmailError.TabIndex = 12;
            this.labelEmailError.Text = "label8";
            // 
            // labelPNError
            // 
            this.labelPNError.AutoSize = true;
            this.labelPNError.Font = new System.Drawing.Font("Courier New", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelPNError.ForeColor = System.Drawing.Color.Red;
            this.labelPNError.Location = new System.Drawing.Point(131, 181);
            this.labelPNError.Name = "labelPNError";
            this.labelPNError.Size = new System.Drawing.Size(49, 14);
            this.labelPNError.TabIndex = 13;
            this.labelPNError.Text = "label8";
            // 
            // RecordStudent
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 451);
            this.Controls.Add(this.labelResult);
            this.Controls.Add(this.comboBoxSearch);
            this.Controls.Add(this.groupBoxStudentForm);
            this.Controls.Add(this.buttonSearch);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.menuStrip1);
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "RecordStudent";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "RecordStudent";
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.groupBoxStudentForm.ResumeLayout(false);
            this.groupBoxStudentForm.PerformLayout();
            this.groupBoxGradeForm.ResumeLayout(false);
            this.groupBoxGradeForm.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDownGrade)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem createClassToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem searchClassesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem viewStatisticsToolStripMenuItem;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button buttonSearch;
        private System.Windows.Forms.GroupBox groupBoxStudentForm;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox textBoxStudentLname;
        private System.Windows.Forms.TextBox textBoxStudentPN;
        private System.Windows.Forms.TextBox textBoxStudentEmail;
        private System.Windows.Forms.TextBox textBoxStudentFname;
        private System.Windows.Forms.GroupBox groupBoxGradeForm;
        private System.Windows.Forms.Button buttonSubmit;
        private System.Windows.Forms.Button buttonClear;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.NumericUpDown numericUpDownGrade;
        private System.Windows.Forms.ComboBox comboBoxClasses;
        private System.Windows.Forms.Button buttonClearRegister;
        private System.Windows.Forms.Button buttonRegister;
        private System.Windows.Forms.ComboBox comboBoxSearch;
        private System.Windows.Forms.Label labelResult;
        private System.Windows.Forms.Label labelPNError;
        private System.Windows.Forms.Label labelEmailError;
        private System.Windows.Forms.Label labelSnameError;
        private System.Windows.Forms.Label labelFnameError;
    }
}