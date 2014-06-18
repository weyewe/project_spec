Ext.define('AM.view.master.ProjectGroupList', {
    extend: 'AM.view.Worksheet',
    alias: 'widget.masterprojectgroupList',
	 
		layout : {
			type : 'vbox',
			align : 'stretch'
		},
		header: false, 
		headerAsText : false,
		selectedParentId : null,
		
		items : [
		// list of part loan.. just the list.. no CRUD etc
			{
				xtype : 'masterprojectList',
				flex : 1
			},
			
			{
				xtype : 'mastergroupList',
				flex : 2
			}, 
		]
});