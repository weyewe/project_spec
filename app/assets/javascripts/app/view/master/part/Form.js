Ext.define('AM.view.master.part.Form', {
  extend: 'Ext.window.Window',
  alias : 'widget.partform',

  title : 'Add / Edit Part',
  layout: 'fit',
	width	: 500,
  autoShow: true,  // does it need to be called?
	modal : true, 
// win.show() 
// if autoShow == true.. on instantiation, will automatically be called 
	
  initComponent: function() {
		var me = this; 
	  
		 
		
		
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
	        xtype: 'hidden',
	        name : 'project_id',
	        fieldLabel: 'Project ID'
	      },
				{
					xtype: 'displayfield',
					fieldLabel: 'Project',
					name: 'project_name' ,
					value : '10' 
				},
				{
					xtype: 'textfield',
					fieldLabel: 'Name',
					name: 'name'  
				},
				{
					xtype: 'textfield',
					fieldLabel: 'Code',
					name: 'code'  
				},
				{
					xtype: 'textarea',
					name : 'description',
					fieldLabel: 'Deskripsi'
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

	 
		setComboBoxData : function( record){ 
		},
	
	setParentData: function( record ){
		this.down('form').getForm().findField('project_name').setValue(record.get('name')); 
		this.down('form').getForm().findField('project_id').setValue(record.get('id')); 
	},
});

