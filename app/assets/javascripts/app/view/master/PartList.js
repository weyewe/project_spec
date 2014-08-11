Ext.define('AM.view.master.PartList' ,{
  	extend: 'Ext.grid.Panel',
  	alias : 'widget.masterpartList',

  	store: 'Projects', 
		showBottomBar : true, 
   

	initComponent: function() {
		this.columns = [
		
			{
				xtype : 'templatecolumn',
				text : "Part",
				flex : 1,
				tpl : '<b>{name}</b>' 
				
			}, 
		];

	 
		this.searchField = new Ext.form.field.Text({
			name: 'searchField',
			hideLabel: true,
			width: 200,
			emptyText : "Search",
			checkChangeBuffer: 300
		});
		
		this.downloadPDF  =  new Ext.Button({
			text: 'DL',
			action: 'downloadPDF',
			disabled: true
		});



		this.tbar = [this.searchField,	this.downloadPDF  ];
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
