namespace Deliverable2
{
    partial class ViewStats
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
            this.recordStudentToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.menuStrip1.SuspendLayout();
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
            this.recordStudentToolStripMenuItem});
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
            this.createClassToolStripMenuItem.Size = new System.Drawing.Size(270, 22);
            this.createClassToolStripMenuItem.Text = "&Create Class...";
            this.createClassToolStripMenuItem.Click += new System.EventHandler(this.createClassToolStripMenuItem_Click);
            // 
            // searchClassesToolStripMenuItem
            // 
            this.searchClassesToolStripMenuItem.Name = "searchClassesToolStripMenuItem";
            this.searchClassesToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)(((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.Alt) 
            | System.Windows.Forms.Keys.S)));
            this.searchClassesToolStripMenuItem.Size = new System.Drawing.Size(270, 22);
            this.searchClassesToolStripMenuItem.Text = "&Search Classes...";
            this.searchClassesToolStripMenuItem.Click += new System.EventHandler(this.searchClassesToolStripMenuItem_Click);
            // 
            // recordStudentToolStripMenuItem
            // 
            this.recordStudentToolStripMenuItem.Name = "recordStudentToolStripMenuItem";
            this.recordStudentToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)(((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.Alt) 
            | System.Windows.Forms.Keys.R)));
            this.recordStudentToolStripMenuItem.Size = new System.Drawing.Size(270, 22);
            this.recordStudentToolStripMenuItem.Text = "&Record Student...";
            this.recordStudentToolStripMenuItem.Click += new System.EventHandler(this.recordStudentToolStripMenuItem_Click_1);
            // 
            // ViewStats
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.menuStrip1);
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "ViewStats";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "ViewStats";
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem createClassToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem searchClassesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem recordStudentToolStripMenuItem;
    }
}