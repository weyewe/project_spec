Ext.define('AM.view.master.Part', {
    extend: 'AM.view.Worksheet',
    alias: 'widget.partProcess',
	 
		layout : {
			type : 'hbox',
			align : 'stretch'
		},
		header: false, 
		headerAsText : false,
		selectedParentId : null,
		
		items : [
		// list of part loan.. just the list.. no CRUD etc
			{
				xtype : 'masterprojectgroupList',
				flex : 1
			},
			
			{
				xtype : 'partlist',
				flex : 2
			}, 
		]
});