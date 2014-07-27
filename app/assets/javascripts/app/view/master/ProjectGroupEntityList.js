Ext.define('AM.view.master.ProjectGroupPartList', {
    extend: 'AM.view.Worksheet',
    alias: 'widget.masterprojectgrouppartList',
	 
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
				flex : 1 ,
				showBottomBar: false 
			},
			
			{
				xtype : 'mastergroupList',
				flex : 1
			}, 
			{
				xtype : 'masterpartList',
				flex : 1
			},
		]
});