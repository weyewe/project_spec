Ext.define('AM.view.master.phase.List' ,{
  	extend: 'Ext.grid.Panel',
  	alias : 'widget.phaselist',

  	store: 'Phases', 
 

	initComponent: function() {
		this.columns = [
			// { header: 'Member', dataIndex: 'member_name' , flex : 1 },
	 		{
				xtype : 'templatecolumn',
				text : "Phase",
				flex : 1,
				tpl : '<b>{code}</b>' +  
							'  <b>{name}</b>'  + '<br />'   + 
							'{description}' 
			},
			// { header: 'Code',  dataIndex: 'code', flex : 1  },
			// { header: 'Name',  dataIndex: 'name', flex : 1  },
			// { header: 'Description',  dataIndex: 'description', flex : 1  },
			
		];

		this.addObjectButton = new Ext.Button({
			text: 'Add',
			action: 'addObject',
			disabled: true
		});

		this.editObjectButton = new Ext.Button({
			text: 'Edit',
			action: 'editObject',
			disabled: true
		});

		this.deleteObjectButton = new Ext.Button({
			text: 'Delete',
			action: 'deleteObject',
			disabled: true
		});
		
		// this.deactivateObjectButton = new Ext.Button({
		// 	text: 'Deactivate',
		// 	action: 'deactivateObject',
		// 	disabled: true
		// });
		
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
		  			// '-', 
		// this.deactivateObjectButton
		
		 ];
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
	
	enableAddButton: function(){
		this.addObjectButton.enable();
	},
	disableAddButton : function(){
		this.addObjectButton.disable();
	},

	enableRecordButtons: function() {
		this.editObjectButton.enable();
		this.deleteObjectButton.enable();
		this.downloadPDF.enable();
		// this.deactivateObjectButton.enable();
		
	},

	disableRecordButtons: function() {
		this.editObjectButton.disable();
		this.deleteObjectButton.disable();
		this.downloadPDF.disable();
		// this.deactivateObjectButton.disable();
	}
});
