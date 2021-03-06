Ext.define('AM.view.master.project.List' ,{
  	extend: 'Ext.grid.Panel',
  	alias : 'widget.projectlist',

  	store: 'Projects', 
 

	initComponent: function() {
		this.columns = [
			{ header: 'ID', dataIndex: 'id'},
			{ header: 'Customer',  dataIndex: 'customer_name', flex: 1},
			{ header: 'Nama',  dataIndex: 'name', flex: 1},
			{	header: 'Deskripsi', dataIndex: 'description', flex: 1 } 
		];

		this.addObjectButton = new Ext.Button({
			text: 'Add Project',
			action: 'addObject'
		});

		this.editObjectButton = new Ext.Button({
			text: 'Edit Project',
			action: 'editObject',
			disabled: true
		});

		this.deleteObjectButton = new Ext.Button({
			text: 'Delete Project',
			action: 'deleteObject',
			disabled: true
		});
		
		this.downloadPDF  =  new Ext.Button({
			text: 'download PDF',
			action: 'downloadPDF',
			disabled: true
		});
		
		this.searchField = new Ext.form.field.Text({
			name: 'searchField',
			hideLabel: true,
			width: 200,
			emptyText : "Search",
			checkChangeBuffer: 300
		});



		this.tbar = [this.addObjectButton, this.editObjectButton, this.deleteObjectButton, 
		
			this.downloadPDF, 
		 	this.searchField ];
		this.bbar = Ext.create("Ext.PagingToolbar", {
			store	: this.store, 
			displayInfo: true,
			displayMsg: 'Displaying topics {0} - {1} of {2}',
			emptyMsg: "No topics to display" 
		});

		this.callParent(arguments);
	},
 
	loadMask	: true,
	
	getSelectedObject: function() {
		return this.getSelectionModel().getSelection()[0];
	},

	enableRecordButtons: function() {
		this.editObjectButton.enable();
		this.deleteObjectButton.enable();
		this.downloadPDF.enable();
	},

	disableRecordButtons: function() {
		this.editObjectButton.disable();
		this.deleteObjectButton.disable();
		this.downloadPDF.disable();
	}
});
