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
				flex : 2
			},
			
			{
				xtype: 'container',
				flex: 5,
				layout : {
					type: 'vbox',
					align : 'stretch'
				},
				items : [
					// container for the part and phase
					// the container for part and phase
					{
						xtype: 'container',
						flex: 2,
						layout : {
							type: 'hbox',
							align: 'stretch'
						},
						items : [
							{
								xtype : 'partlist',
								flex : 2
							}, 

							{
								xtype : 'phaselist',
								flex : 2
							},
						]
					},
					
					// container for pre-condition and post-condition 
					{
						xtype : 'container',
						flex: 3 ,
						layout : {
							type: 'hbox',
							align: 'stretch'
						},
						items: [
							{
								xtype : 'container',
								html: "pre condition",
								flex: 1
							},
							{
								xtype : 'container',
								html : 'post_condtion',
								flex: 1
							}
						]
					}
					
				]
				
				
			}
			
			
			
			
		]
});