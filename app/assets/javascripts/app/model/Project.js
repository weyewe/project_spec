Ext.define('AM.model.Project', {
  	extend: 'Ext.data.Model',
  	fields: [
    	{ name: 'id', project: 'int' },
			{ name: 'name', project: 'string' },
			{ name: 'description', project: 'string' },
			{ name: 'customer_id', project: 'string' },
			{ name: 'customer_name', project: 'string' },
			 
  	],

	 


   
  	idProperty: 'id' ,proxy: {
			url: 'api/projects',
			type: 'rest',
			format: 'json',

			reader: {
				root: 'projects',
				successProperty: 'success',
				totalProperty : 'total'
			},

			writer: {
				getRecordData: function(record) {
					return { project : record.data };
				}
			}
		}
	
  
});
