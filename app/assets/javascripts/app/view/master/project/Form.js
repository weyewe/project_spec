Ext.define('AM.view.master.project.Form', {
  extend: 'Ext.window.Window',
  alias : 'widget.projectform',

  title : 'Add / Edit Project',
  layout: 'fit',
	width	: 500,
  autoShow: true,  // does it need to be called?
	modal : true, 
// win.show() 
// if autoShow == true.. on instantiation, will automatically be called 
	
  initComponent: function() {
	
		var remoteJsonStoreCustomer = Ext.create(Ext.data.JsonStore, {
			storeId : 'customer_search',
			fields	: [
			 		{
						name : 'customer_name',
						mapping : "name"
					} ,
					{
						name : 'customer_id',
						mapping : "id"
					}  
			],
			
		 
			proxy  	: {
				type : 'ajax',
				url : 'api/search_customer',
				reader : {
					type : 'json',
					root : 'records', 
					totalProperty  : 'total'
				}
			},
			autoLoad : false 
		});
	
	  
    this.items = [{
      xtype: 'form',
			msgTarget	: 'side',
			border: false,
      bodyPadding: 10,
			fieldDefaults: {
          labelWidth: 165,
					anchor: '100%'
      },
      items: [
				{
	        xtype: 'hidden',
	        name : 'id',
	        fieldLabel: 'id'
	      },
				{
	        xtype: 'textfield',
	        name : 'name',
	        fieldLabel: ' Name Project'
	      },
				{
					xtype: 'textfield',
					name : 'description',
					fieldLabel: 'Deskripsi'
				},
				{
					fieldLabel: 'Customer',
					xtype: 'combo',
					queryMode: 'remote',
					forceSelection: true, 
					displayField : 'customer_name',
					valueField : 'customer_id',
					pageSize : 5,
					minChars : 1, 
					allowBlank : false, 
					triggerAction: 'all',
					store : remoteJsonStoreCustomer , 
					listConfig : {
						getInnerTpl: function(){
							return  	'<div data-qtip="{customer_name}">' + 
													'<div class="combo-name">{customer_name}</div>' + 
							 					'</div>';
						}
					},
					name : 'customer_id' 
				},
			
				
			]
    }];

    this.buttons = [{
      text: 'Save',
      action: 'save'
    }, {
      text: 'Cancel',
      scope: this,
      handler: this.close
    }];

    this.callParent(arguments);
  },

	 
	
	setSelectedCustomer: function( customer_id ){
		var comboBox = this.down('form').getForm().findField('customer_id'); 
		var me = this; 
		var store = comboBox.store;  
		store.load({
			params: {
				selected_id : customer_id 
			},
			callback : function(records, options, success){
				me.setLoading(false);
				comboBox.setValue( customer_id );
			}
		});
	},

	setComboBoxData : function( record){
		// console.log("gonna set combo box data");
		var me = this; 
		me.setLoading(true);
		
		me.setSelectedCustomer( record.get("customer_id")  ) ; 
	},
});

