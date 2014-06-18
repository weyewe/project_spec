Ext.define('AM.view.master.Group', {
    extend: 'AM.view.Worksheet',
    alias: 'widget.groupProcess',
	 
		layout : {
			type : 'hbox',
			align : 'stretch'
		},
		header: false, 
		headerAsText : false,
		selectedParentId : null,
		
		items : [
		// list of group loan.. just the list.. no CRUD etc
			{
				xtype : 'masterprojectList',
				flex : 1
			},
			
			{
				xtype : 'grouplist',
				flex : 2
			}, 
		]
});